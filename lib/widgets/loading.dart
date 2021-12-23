import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showLoading(){
  Get.dialog(
    Center(child: CircularProgressIndicator()),
    barrierDismissible: false,
  );
}