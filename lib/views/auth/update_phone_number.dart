import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exact_cabs_driver/utils/colors.dart';
import 'package:exact_cabs_driver/utils/text_styles.dart';
import 'package:exact_cabs_driver/views/auth/payments_type.dart';
import 'package:exact_cabs_driver/views/main/user_home.dart';
import 'package:exact_cabs_driver/widgets/button_widgets.dart';
import 'package:exact_cabs_driver/widgets/icon_widgets.dart';
import 'package:exact_cabs_driver/widgets/text_widgets.dart';

class UpdatePhoneNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: AppBarTitle(title: "Update Phone Number".tr,),
        leading: AppBarBack(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 140,
                child: Icon(
                  Icons.phone_android_sharp,
                  color: primaryColor,
                  size: 40,
                ),
              ),
              Text(
                  "Update Statement".tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15
                ),
              ),
              SizedBox(height: 30,),
              FadedHeading(title: "Mobile".tr),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                    image: AssetImage('assets/logos/cameroon.png'),
                    height: 20,
                    width: 20,
                  ),
                  SizedBox(width: 20,),
                  Container(
                    width: 50,
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        hintText: "+237",
                        hintStyle: inputTextStyle,

                      ),
                      style: inputTextStyle,
                    ),
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    child: TextField(
                      style: inputTextStyle,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40,),
              MainButton(
                  text: "Save and Verify".tr,
                  onPressed: (){
                    Get.to(()=>UserHomePage());
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
