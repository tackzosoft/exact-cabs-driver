import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exact_cabs_driver/utils/colors.dart';
import 'package:exact_cabs_driver/views/navigation/emergency_contacts.dart';
import 'package:exact_cabs_driver/widgets/icon_widgets.dart';
import 'package:exact_cabs_driver/widgets/text_widgets.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: AppBarTitle(
          title: "Help".tr,
        ),
        leading: AppBarBack(),
      ),
      body: Center(
        child: Container(
          color: backgroundColor,
          child: Text("this is help page"),
        ),
      ),
    );
  }
}
