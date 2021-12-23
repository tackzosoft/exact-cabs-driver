import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exact_cabs_driver/utils/colors.dart';
import 'package:exact_cabs_driver/widgets/icon_widgets.dart';
import 'package:exact_cabs_driver/widgets/text_widgets.dart';

import 'booking_confirmation.dart';

class FareEstimateScreen extends StatelessWidget {
  // const FareEstimateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: AppBarTitle(title: "Fare Estimate",),
        leading: AppBarBack(),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.navigate_next,
            color: darkBlueGrey,
          ),
          onPressed: (){
            Get.to(()=>BookingConfirmationScreen());
          }
      ),
      body: Column(
        children: [
          Container(
            width: double.maxFinite,
            height: size.height*0.4,
            decoration: BoxDecoration(
                gradient: indigoAccentGradient
            ),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50.0),
                    child: Text("10-12 CFA",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40
                      ),
                    ),
                  ),
                  whiteText("Estimated Fare")
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15),
              width: size.width,
              decoration: BoxDecoration(
                color: backgroundColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              offset: Offset(5,5),
                              spreadRadius: 0.5
                          ),
                        ]
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text("4 Privet Drive"),
                          leading: Icon(Icons.blur_circular,color: Colors.green,),
                        ),
                        ListTile(
                          title: Text("4B Bakers' street"),
                          leading: Icon(Icons.location_on_rounded, color: primaryColor,),
                        )
                      ],
                    ),
                  ),
                  Text("Note: This is an approximate estimate. "
                      "Actual fares may vary slightly based on traffic or discounts",
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
