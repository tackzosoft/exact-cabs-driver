import 'package:exact_cabs_driver/models/user_model.dart';
import 'package:exact_cabs_driver/services/api_services.dart';
import 'package:exact_cabs_driver/services/misc.dart';
import 'package:exact_cabs_driver/utils/country_data.dart';
import 'package:exact_cabs_driver/views/auth/add_driver_details.dart';
import 'package:exact_cabs_driver/views/auth/add_vehicle.dart';
import 'package:exact_cabs_driver/views/main/driver_home.dart';
import 'package:exact_cabs_driver/views/main/user_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exact_cabs_driver/utils/colors.dart';
import 'package:exact_cabs_driver/utils/text_styles.dart';
import 'package:exact_cabs_driver/views/auth/forgot_password.dart';
import 'package:exact_cabs_driver/views/auth/verify_mobile.dart';
import 'package:exact_cabs_driver/widgets/button_widgets.dart';
import 'package:exact_cabs_driver/widgets/icon_widgets.dart';
import 'package:exact_cabs_driver/widgets/text_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = new TextEditingController();

  TextEditingController passwordController = new TextEditingController();

  UserModel userModel;

  String selectedCountryCode;

  FirebaseAuth _auth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initApp();
  }

  void initApp() async {
    FirebaseApp defaultApp = await Firebase.initializeApp();
    _auth = FirebaseAuth.instanceFor(app: defaultApp);
    // immediately check whether the user is signed in
    // checkIfUserIsSignedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: AppBarTitle(
          title: "login".tr,
        ),
        leading: AppBarBack(),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                        icon: Image(
                          image: AssetImage("assets/logos/google_logo_white.png"),
                          height: 25,
                        ),
                        onPressed: () {},
                        color: googleButtonColor),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: FilledButton(
                        icon: Image(
                          image: AssetImage("assets/logos/fb_logo_white.png"),
                          height: 25,
                        ),
                        onPressed: () {},
                        color: facebookButtonColor),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: Center(
                    child: FadedHeading(
                  title: 'OR',
                )),
              ),
              FadedHeading(title: "Phone Number".tr),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownButton(
                    value: selectedCountryCode,
                    underline: SizedBox(),
                    hint: Text("Select Country"),
                    onChanged: (value){
                      print(value);
                      setState(() {
                        selectedCountryCode = value;
                      });
                      print(selectedCountryCode);
                    },
                    items: COUNTRIES.map((country) {
                      return DropdownMenuItem(
                        child: Text(
                          "${country["country"]}(${country["code"]})",
                        ),
                        value: country["code"],
                      );
                    }).toList(),
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    child: TextField(
                      style: inputTextStyle,
                      controller: phoneController,
                      maxLength: 10,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          counterText: ""
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              FadedHeading(title: "Password".tr),
              TextField(
                style: inputTextStyle,
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              MainButton(
                  text: "login".tr,
                  onPressed: (){
                    login(context);
                  }
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: InkWell(
                    onTap: (){
                      Get.to(()=>ForgotPasswordScreen());
                    },
                    child: FadedHeading(
                      title: 'Forgot Password?'.tr,
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login(BuildContext context) async{

    // Get.offAll(()=> UserHomePage());
    // return;

    final fcmToken = await FirebaseMessaging.instance.getToken();
    Get.dialog(
      Center(child: CircularProgressIndicator()),
      barrierDismissible: true,
    );
    var user = await ApiServices().driverLogin(
        phoneNumber: phoneController.text,
        password: passwordController.text,
        countryCode: "FR",
        deviceId: fcmToken,
        deviceType: Platform.isAndroid ? 'android' : 'ios'
    );
    Get.back();
    if(user is UserModel){
      userModel = user;
      print(userModel.accountStatus);
      getDriverStatus();
      // if(userModel.accountStatus==0){
      //   Get.offAll(()=> AddVehicle());
      // }else if(userModel.accountStatus==1){
      //   Get.offAll(()=> AddDriverDetails());
      // }else {
      //   Get.offAll(()=> DriverHomePage());
      // }


    }else if(user!=null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(user["message"])));
    }else{

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Check Your Internet Connectivity")));
    }

  }

  void getDriverStatus()async{
    Get.dialog(
      Center(child: CircularProgressIndicator()),
      barrierDismissible: true,
    );
    var result = await ApiServices().getDriverStatus();
    Get.back();
    if(result["httpCode"]==500){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result["message"])));
    }
    if(result["httpCode"]==200){
      int status = result["data"]["status"];
      print(status);
      if(status==0){
        print("string");
        Get.to(()=>AddVehicle());
      }
    }
  }

  bool validate(){
    if(phoneController.text.length!=10 || phoneController.text.contains(".")|| phoneController.text.contains(",")|| phoneController.text.contains("-")){
      showSnackBar(context, "Please enter a valid phone number.");
      return false;
    }
    return true;
  }
}
