import 'package:exact_cabs_driver/views/auth/login.dart';
import 'package:exact_cabs_driver/widgets/button_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class RegistrationCompletedPage extends StatelessWidget {
  // const RegistrationCompletedPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                "Registration Completed".tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 15,),
            MainButton(
                text: "login".tr,
                onPressed: (){
                  Get.off(()=>LoginScreen());
                }
            ),
          ],
        ),
      ),
    );
  }
}
