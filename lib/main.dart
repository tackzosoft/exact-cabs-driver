import 'package:exact_cabs_driver/services/localization_service.dart';
import 'package:exact_cabs_driver/services/shared_prefs.dart';
import 'package:exact_cabs_driver/views/auth/add_driver_details.dart';
import 'package:exact_cabs_driver/views/auth/add_vehicle.dart';
import 'package:exact_cabs_driver/views/main/driver_home.dart';
import 'package:exact_cabs_driver/views/main/user_home.dart';
import 'package:exact_cabs_driver/views/welcome_page.dart';
import 'package:exact_cabs_driver/widgets/alert_dialogs.dart';
import 'package:exact_cabs_driver/widgets/test.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io';

const AndroidNotificationChannel androidNotificationChannel = AndroidNotificationChannel(
    'exact_cabs_driver_notification',
    'Exact Cabs Notification',
    'This channel is used for high importance notification',
    importance: Importance.high,
    playSound: true
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async{
  await Firebase.initializeApp();
  print("Background message received: " + message.messageId);
  // SharedPrefsService.saveString("bgnot", "Background message");
}

InitializationSettings initializationSettings = InitializationSettings(
    android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    iOS: IOSInitializationSettings(
        requestAlertPermission: true,
        requestSoundPermission: true,
        requestBadgePermission: true,
        onDidReceiveLocalNotification: (int id, String title, String body, String payload) async {
          // display a dialog with the notification details, tap ok to go to another page
        }));

Future onSelectNotification(String message) async {
  if (message != null && message.isNotEmpty && message == "update") {
    if (Platform.isAndroid) {
      // _launchURL("https://play.google.com/store/apps/details?id=com.happyLifter");
    } else if (Platform.isIOS) {
      // _launchURL("https://apps.apple.com/us/app/happy-lifters/id1574284172");
    }
  } else if (message.isEmpty) {
    print("payload is empty");
  } else {
    print("unable to load notification");
  }
}

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPrefsService.init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: onSelectNotification);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(androidNotificationChannel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    initFCM();
    super.initState();
  }

  void initFCM() async {
    await Firebase.initializeApp();
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage message) {
      print("Notification received getInitialMessage");

      if (message != null) {
        print("InitialMessage:${message.notification.body}");
        if (message.data["route"] == "update") {
          if (Platform.isAndroid) {
            // _launchURL("https://play.google.com/store/apps/details?id=com.happyLifter");
          } else if (Platform.isIOS) {
            // _launchURL("https://apps.apple.com/us/app/happy-lifters/id1574284172");
          }
        } else {
          print("No data found");
        }
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Notification received onMessage: ");
      newBookingAlert(message);
      // print(message.data);
      // print("contentAvailable " + message.contentAvailable.toString());
      // // print("category " + message.category);
      // // print("from " + message.from);
      // // print("type " + message.messageType);
      // // print("senderId " + message.senderId);
      // // print("collapseKey " + message.collapseKey);
      // print("notification " + message
      //
      //     .notification.toString());
      // print("body " + message.notification.body);
      // print("title " + message.notification.title);

      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      AppleNotification appleNotification = message.notification?.apple;
      if (Platform.isAndroid && notification != null ||
          android != null ||
          appleNotification != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              // iOS: IOSNotificationDetails(
              //   threadIdentifier: "notification_thread",
              //   // badgeNumber: 1,
              //   presentAlert: true,
              //   presentBadge: true,
              //   presentSound: true,
              // ),
              android: AndroidNotificationDetails(
                androidNotificationChannel.id,
                androidNotificationChannel.name,
                androidNotificationChannel.description,
                playSound: true,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
                //  sound: RawResourceAndroidNotificationSound("babu.mp3"),
                priority: Priority.high,
                largeIcon: DrawableResourceAndroidBitmap("@mipmap/ic_launcher"),
                subText: "Notification",

                //   styleInformation: BigTextStyleInformation()
              ),
            ),
            payload: message.data["route"]);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Notification received onMessageOpenedApp");
      if (message != null) {
        print("InitialMessage:${message.notification.body}");
        if (message.data["route"] == "update") {
          if (Platform.isAndroid) {
            // _launchURL("https://play.google.com/store/apps/details?id=com.happyLifter");
          } else if (Platform.isIOS) {
            // _launchURL("https://apps.apple.com/us/app/happy-lifters/id1574284172");
          }
        } else {
          print("No data found");
        }
      }
      // print('A new onMessageOpenedApp event was published!');
      // Navigator.pushNamed(context, '/message',
      //     arguments: MessageArguments(message, true));
    });

    FirebaseMessaging.instance.getToken().then((value) {
      print("Notification received instance");
      print('TOKEN: ${value.toString()}');
    });
    // print('User granted permission: ${settings.authorizationStatus}');
  }

  @override
  Widget build(BuildContext context) {

    String token = SharedPrefsService.getToken();

    return GetMaterialApp(
      title: '',
      debugShowCheckedModeBanner: false,
      translations: LocalizationService(),
      locale: LocalizationService().getLocaleFromLanguage(SharedPrefsService.getLocale()),
      fallbackLocale: Locale("en" , "US"),
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: token!=null && token.isNotEmpty ? DriverHomePage() : WelcomePage(),
      // home: AddDriverDetails(),
    );
  }
}