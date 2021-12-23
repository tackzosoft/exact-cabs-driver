import 'dart:ffi';

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

class UserHomePage extends StatefulWidget {

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {

  Location _locationTracker = Location();
  LocationData location;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
  }

  Future<LocationData> getCurrentLocation() async {
    try {

      location = await _locationTracker.getLocation();

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
                      // Get.to(()=>FareEstimateScreen());
                      }
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(15),
                  width: size.width,
                  height: size.height * 0.2,
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image(
                            image: AssetImage('assets/logos/cab.png'),
                            width: 80,
                          ),
                          Text(
                              "Cab".tr,
                            style: TextStyle(
                              fontSize: 17,
                              color: darkBlueGrey,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image(
                            image: AssetImage('assets/logos/bike.png'),
                            width: 60,
                          ),
                          Text(
                            "Bike".tr,
                            style: TextStyle(
                                fontSize: 17,
                                color: darkBlueGrey,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                      // Column(
                      //   mainAxisSize: MainAxisSize.min,
                      //   children: [
                      //     Icon(
                      //       Icons.shopping_bag,
                      //       color: primaryColor,
                      //       size: 50,
                      //     ),
                      //     Text(
                      //       "Parcel".tr,
                      //       style: TextStyle(
                      //           fontSize: 17,
                      //           color: darkBlueGrey,
                      //           fontWeight: FontWeight.bold
                      //       ),
                      //     ),
                      //   ],
                      // ),
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
    return FutureBuilder(
      future: getCurrentLocation(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          return ShowLocationScreen(location.latitude, location.longitude);
        }
        return Container(
          height: double.maxFinite,
          width: double.maxFinite,
          color: backgroundColor,
        );
      },
    );
  }

}
