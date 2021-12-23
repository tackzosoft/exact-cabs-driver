import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exact_cabs_driver/utils/colors.dart';
import 'package:exact_cabs_driver/utils/text_styles.dart';
import 'package:exact_cabs_driver/widgets/button_widgets.dart';
import 'package:exact_cabs_driver/widgets/icon_widgets.dart';
import 'package:exact_cabs_driver/widgets/text_widgets.dart';

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: AppBarTitle(
          title: "Forgot Password".tr,
        ),
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
                  Icons.mood_bad,
                  color: primaryColor,
                  size: 40,
                ),
              ),
              Text(
                  "Forgot Password Statement".tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15
                ),
              ),
              SizedBox(
                height: 30,
              ),
              FadedHeading(title: "Phone Number".tr),
              TextField(
                style: inputTextStyle,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero
                ),
              ),
              SizedBox(
                height: 40,
              ),
              MainButton(
                  text: "Reset Password".tr,
                  onPressed: () {
                    // print("clicked");
                    Get.back();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
