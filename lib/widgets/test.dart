import 'package:exact_cabs_driver/services/api_services.dart';
import 'package:exact_cabs_driver/utils/colors.dart';
import 'package:exact_cabs_driver/widgets/alert_dialogs.dart';
import 'package:exact_cabs_driver/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class TestScreen extends StatelessWidget {
  final RemoteMessage message;
  TestScreen(this.message);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          color: backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: 20,),
              Text(
                "New Ride Request",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),
              ),
              SizedBox(height: 20,),
              Spacer(),
              Container(
                // height: size.width * 0.6,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5
                    )
                  ]
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: ()=>Get.back(),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Center(
                            child: Text(
                              "Reject",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: acceptDuty,
                        child: Container(
                          color: primaryColor,
                          padding: EdgeInsets.all(20),
                          child: Center(
                            child: Text(
                              "Accept",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }


  void acceptDuty() async{
    List body = message.notification.body.split(" ");
    showLoading();
    var result = await ApiServices().acceptDuty(body.last);
    Get.back();
    if(result["httpCode"]==200){
      bookingAccepted(result["data"]);
    }

  }

}
