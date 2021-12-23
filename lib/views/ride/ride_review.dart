import 'package:flutter/material.dart';
import 'package:exact_cabs_driver/utils/colors.dart';
import 'package:exact_cabs_driver/utils/text_styles.dart';
import 'package:exact_cabs_driver/widgets/button_widgets.dart';
import 'package:exact_cabs_driver/widgets/icon_widgets.dart';
import 'package:exact_cabs_driver/widgets/text_widgets.dart';

import 'booking_confirmation.dart';

class RideReviewScreen extends StatelessWidget {
  // const FareEstimateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: AppBarTitle(title: "Fare Estimate",),
        leading: AppBarBack(),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                    Text("10 CFA",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 35
                      ),
                    ),
                    Icon(
                      Icons.local_taxi,
                      size: 60,
                      color: Colors.white,
                    ),
                    whiteText("Estimated Fare")
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
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
                      SizedBox(height: 20,),
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
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(Icons.star, color: Colors.amber,size: 40,),
                                  Icon(Icons.star, color: Colors.amber,size: 40,),
                                  Icon(Icons.star, color: Colors.amber,size: 40,),
                                  Icon(Icons.star, color: Colors.grey,size: 40,),
                                  Icon(Icons.star, color: Colors.grey,size: 40,),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(15,0,15,15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FadedHeading(title: "Write your comment"),
                                  TextField(style: inputTextStyle,),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      FadedHeading(title: "rate your trip and receive a bonus"),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(
                        child: BorderedButton(
                          text: "Need Help?",
                          color: darkBlueGrey,
                          onPressed: (){},
                        ),
                      ),
                      SizedBox(width: 15,),
                      Expanded(
                        child: MainButton(
                          text: "Rate Now",
                          onPressed: (){},
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
