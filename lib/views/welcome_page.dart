import 'package:exact_cabs_driver/services/localization_service.dart';
import 'package:exact_cabs_driver/services/shared_prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:exact_cabs_driver/utils/colors.dart';
import 'package:exact_cabs_driver/views/auth/login.dart';
import 'package:exact_cabs_driver/views/auth/register.dart';
import 'package:exact_cabs_driver/widgets/button_widgets.dart';

class WelcomePage extends StatefulWidget {

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  String lng = SharedPrefsService.getLocale();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 70.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: size.height * 0.5,
                width: size.width,
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 0,
                      blurRadius: 5
                    )
                  ]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Welcome to Exact Cabs',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 25,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipisicing dlit, sed do eiusmod tempor incididunt ut labcre et colore magna aliqua.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: BorderedButton(
                            text: "login".tr,
                            color: darkBlueGrey,
                            onPressed: (){
                              Get.to(()=>LoginScreen());
                            },
                          ),
                        ),
                        SizedBox(width: 15,),
                        Expanded(
                          child: MainButton(
                            text: "register".tr,
                            onPressed: (){
                              Get.to(()=>RegisterScreen());
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: size.width,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          spreadRadius: 0,
                          blurRadius: 5
                      )
                    ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Choose Your Preferred Language / Choisissez votre langue préférée",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    DropdownButton<String>(
                      items: LocalizationService.langs.map((String value) {
                        return new DropdownMenuItem(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      value: lng,
                      underline: Container(color: primaryColor,),
                      isExpanded: false,
                      onChanged: (newVal) {
                        setState((){
                          lng = newVal;
                          LocalizationService().changeLocale(newVal);
                          SharedPrefsService.saveLocale(lng);
                          print(newVal);
                        });
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


