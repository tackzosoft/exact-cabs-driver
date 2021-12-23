import 'package:flutter/material.dart';
import 'package:exact_cabs_driver/utils/colors.dart';
import 'package:exact_cabs_driver/widgets/icon_widgets.dart';
import 'package:exact_cabs_driver/widgets/text_widgets.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: AppBarTitle(
          title: "Notification".tr,
        ),
        leading: AppBarBack(),
      ),
      body: Center(
        child: Container(
          color: backgroundColor,
          child: Text("This is notification page"),
        ),
      ),
    );
  }
}
