import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exact_cabs_driver/utils/colors.dart';
import 'package:exact_cabs_driver/utils/text_styles.dart';
import 'package:exact_cabs_driver/views/auth/login.dart';
import 'package:exact_cabs_driver/widgets/button_widgets.dart';
import 'package:exact_cabs_driver/widgets/icon_widgets.dart';
import 'package:exact_cabs_driver/widgets/text_widgets.dart';


class EditProfile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: AppBarTitle(title: "Edit Profile".tr,),
        leading: AppBarBack(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: primaryColor,
              height: 150,
              width: double.maxFinite,
              child: Center(
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 35,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FadedHeading(title: "First Name".tr),
                            TextField(
                              style: inputTextStyle,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero
                              ),
                            ),
                          ],),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FadedHeading(title: "Last Name".tr),
                            TextField(
                              style: inputTextStyle,
                            ),
                          ],),
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  FadedHeading(title: "Email".tr),
                  TextField(
                    style: inputTextStyle,
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
                  SizedBox(height: 30,),
                  FadedHeading(title: "Places".tr),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                    height: 20,
                  ),
                  ListTile(
                    title: Text(
                      "148 Vallie Road",
                      style: TextStyle(
                          color: darkBlueGrey.withOpacity(0.7),
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    subtitle: Text(
                      "Home",
                      style: TextStyle(
                          color: darkBlueGrey,
                          fontSize: 15,
                      ),
                    ),
                    leading: Icon(
                      Icons.home,
                      color: darkBlueGrey,
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: darkBlueGrey,
                      ),
                      onPressed: (){},
                    ),
                    onTap: (){},
                  ),
                  ListTile(
                    title: Text(
                      "148 Vallie Road",
                      style: TextStyle(
                          color: darkBlueGrey.withOpacity(0.7),
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    subtitle: Text(
                      "Work",
                      style: TextStyle(
                        color: darkBlueGrey,
                        fontSize: 15,
                      ),
                    ),
                    leading: Icon(
                      Icons.work,
                      color: darkBlueGrey,
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: darkBlueGrey,
                      ),
                      onPressed: (){},
                    ),
                    onTap: (){},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
