import 'package:exact_cabs_driver/services/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exact_cabs_driver/utils/colors.dart';
import 'package:exact_cabs_driver/views/auth/payments_type.dart';
import 'package:exact_cabs_driver/views/main/edit_profile.dart';
import 'package:exact_cabs_driver/views/navigation/help.dart';
import 'package:exact_cabs_driver/views/navigation/notification.dart';
import 'package:exact_cabs_driver/views/welcome_page.dart';

class SideNavigation extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.8,
      color: primaryColor,
      child: SafeArea(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image(
                  image: AssetImage('assets/images/backgrounds/header_bg.png'),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 35,
                      ),
                      Text(
                        "Dummy Name",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Colors.white
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Get.to(()=>EditProfile());
                        },
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.white
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        "Home".tr,
                        style: TextStyle(
                          color: darkBlueGrey,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      leading: Icon(
                        Icons.home,
                        color: darkBlueGrey,
                      ),
                      onTap: (){},
                    ),
                    ListTile(
                      title: Text(
                        "Payment".tr,
                        style: TextStyle(
                            color: darkBlueGrey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      leading: Icon(
                        Icons.payment,
                        color: darkBlueGrey,
                      ),
                      onTap: (){
                        Get.to(()=>PaymentType());
                      },
                    ),
                    ListTile(
                      title: Text(
                        "History".tr,
                        style: TextStyle(
                            color: darkBlueGrey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      leading: Icon(
                        Icons.history,
                        color: darkBlueGrey,
                      ),
                      onTap: (){},
                    ),
                    ListTile(
                      title: Text(
                        "DashBoard".tr,
                        style: TextStyle(
                            color: darkBlueGrey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      leading: Icon(
                        Icons.dashboard,
                        color: darkBlueGrey,
                      ),
                      onTap: (){},
                    ),
                    ListTile(
                      title: Text(
                        "Notifications".tr,
                        style: TextStyle(
                            color: darkBlueGrey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      leading: Icon(
                        Icons.notifications,
                        color: darkBlueGrey,
                      ),
                      onTap: (){
                        Get.to(()=>NotificationsPage());
                      },
                    ),
                    ListTile(
                      title: Text(
                        "Settings".tr,
                        style: TextStyle(
                            color: darkBlueGrey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      leading: Icon(
                        Icons.settings,
                        color: darkBlueGrey,
                      ),
                      onTap: (){},
                    ),
                    ListTile(
                      title: Text(
                        "Help".tr,
                        style: TextStyle(
                            color: darkBlueGrey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      leading: Icon(
                        Icons.help,
                        color: darkBlueGrey,
                      ),
                      onTap: (){
                        Get.to(()=>HelpPage());
                      },
                    ),
                    ListTile(
                      title: Text(
                        "Logout".tr,
                        style: TextStyle(
                            color: darkBlueGrey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      leading: Icon(
                        Icons.logout,
                        color: darkBlueGrey,
                      ),
                      onTap: (){
                        SharedPrefsService.clearToken();
                        Get.offAll(()=>WelcomePage());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
