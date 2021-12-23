import 'package:exact_cabs_driver/widgets/test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void newBookingAlert(RemoteMessage message){
  Get.dialog(
    TestScreen(message),
    barrierDismissible: true,
  );
}

void bookingAccepted(Map data){
  Get.defaultDialog(
    title: "Ride Accepted",
    onConfirm: (){
      Get.back();
      Get.back();
    },
    content: Column(
      children: [
        Text(
            data["booking_id"],
          style: TextStyle(
            fontSize: 18
          ),
        ),
      ],
    ),
  );
}