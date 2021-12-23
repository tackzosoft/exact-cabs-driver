import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exact_cabs_driver/utils/colors.dart';
import 'package:exact_cabs_driver/utils/text_styles.dart';
import 'package:exact_cabs_driver/views/auth/payments_type.dart';
import 'package:exact_cabs_driver/views/auth/update_phone_number.dart';
import 'package:exact_cabs_driver/widgets/button_widgets.dart';
import 'package:exact_cabs_driver/widgets/icon_widgets.dart';
import 'package:exact_cabs_driver/widgets/text_widgets.dart';

class VerifyMobileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: AppBarTitle(title: "Verify Mobile".tr,),
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
                  Icons.message,
                  color: primaryColor,
                  size: 40,
                ),
              ),
              Text(
                  "Verify Statement".tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15
                ),
              ),
              SizedBox(height: 30,),
              FadedHeading(title: "Enter OTP".tr),
              TextField(
                style: inputTextStyle,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              SizedBox(height: 40,),
              MainButton(
                  text: "Submit".tr,
                  onPressed: (){
                    Get.to(()=>UpdatePhoneNumber());
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
