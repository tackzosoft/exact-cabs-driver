import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exact_cabs_driver/utils/colors.dart';
import 'package:exact_cabs_driver/views/navigation/notification.dart';
import 'package:exact_cabs_driver/widgets/icon_widgets.dart';
import 'package:exact_cabs_driver/widgets/text_widgets.dart';

class EmergencyContact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: AppBarTitle(
          title: "Emergency Contacts".tr,
        ),
        leading: AppBarBack(),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all( 10.0),
            child: Column(
              children: [
                MyListView(),
                MyListView(),
                MyListView(),
              ],
            ),
          )
      ),
    );
  }
}

class MyListView extends StatelessWidget {
  double diameter = 55;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Container(
            height: diameter,
            width: diameter,
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.circular(diameter/2),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide.none,
              right: BorderSide.none,
              top: BorderSide.none,
              bottom: BorderSide(
                color: darkBlueGrey.withOpacity(0.5),
              ),
            ),
          ),
          child: ListTile(
            title: Text('Placeholder Name'.tr),
            subtitle: Text('+1 1234567890'),
            trailing: Checkbox(
              value: true,
              onChanged: (bool value) {},
            ),
          ),
        ),
      ],
    );
  }
}
