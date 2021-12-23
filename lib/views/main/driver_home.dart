import 'dart:ffi';

import 'package:exact_cabs_driver/services/api_services.dart';
import 'package:exact_cabs_driver/services/misc.dart';
import 'package:exact_cabs_driver/services/shared_prefs.dart';
import 'package:exact_cabs_driver/views/map_views/show_location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exact_cabs_driver/utils/colors.dart';
import 'package:exact_cabs_driver/utils/strings.dart';
import 'package:exact_cabs_driver/views/ride/fare_estimate.dart';
import 'package:exact_cabs_driver/widgets/side_navigation.dart';
import 'package:exact_cabs_driver/widgets/text_widgets.dart';


import 'package:exact_cabs_driver/views/map_views/show_location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:exact_cabs_driver/utils/colors.dart';
import 'package:exact_cabs_driver/utils/strings.dart';
import 'package:exact_cabs_driver/views/ride/fare_estimate.dart';
import 'package:exact_cabs_driver/widgets/side_navigation.dart';
import 'package:exact_cabs_driver/widgets/text_widgets.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';

class DriverHomePage extends StatefulWidget {

  @override
  _DriverHomePageState createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {

  bool isOnline = false;

  Location _locationTracker = Location();
  LocationData location;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
    isOnline = SharedPrefsService.getDutyStatus() ?? false;
  }

  Future<LocationData> getCurrentLocation() async {
    try {

      location = await _locationTracker.getLocation();
      print(location.latitude.toString() + "--" + location.longitude.toString());
      setState(() {

      });

    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }

    return location;
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: AppBarTitle(title: appTitle),
        leading: Builder(
          builder: (BuildContext ctx) => IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: (){
              Scaffold.of(ctx).openDrawer();
            },
          ),
        ),
      ),
      body: Container(
        color: backgroundColor,
        child: Stack(
          children: [
            mapScreen(),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: FloatingActionButton(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.my_location,
                        color: darkBlueGrey,
                      ),
                      onPressed: (){
                        getCurrentLocation();
                      }
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(15),
                  width: size.width,
                  height: size.height * 0.1,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            color: Colors.black26
                        )
                      ]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        isOnline ? "You're online" : "You're offline",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                        ),
                      ),
                      Switch(
                          value: isOnline,
                          onChanged: updateDuty,
                        activeColor: Colors.green,
                        inactiveThumbColor: Colors.red,
                        inactiveTrackColor: Colors.red[200],
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      drawer: SideNavigation(),
    );
  }

  Widget mapScreen(){
    if(location==null) {
      return Container(
        height: double.maxFinite,
        width: double.maxFinite,
        color: backgroundColor,
      );
    }
    return ShowLocationScreen(location.latitude, location.longitude);
  }

  void updateDuty(bool value) async{
    if(location!=null){
      Get.dialog(
        Center(child: CircularProgressIndicator()),
        barrierDismissible: true,
      );
      var result = await ApiServices().updateDuty(
        latitude: location.latitude.toString(),
        longitude: location.longitude.toString(),
        date: "09-12-2021",
        location: "location",
        address: "address",
        status: value ? "1" : "0"
      );
      if(result["httpCode"]==200){
        SharedPrefsService.saveDutyId(result["data"]["driver_duity_id"]);
        SharedPrefsService.saveDutyStatus(value);
        setState(() {
          isOnline = !isOnline;
        });
        showSnackBar(context, "Duty status updated");
      }else{
        showSnackBar(context, "Failed to update duty status");
      }
      Get.back();
    }else{
      getCurrentLocation();
    }


  }
}
