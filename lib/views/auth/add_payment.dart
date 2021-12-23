import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:exact_cabs_driver/utils/colors.dart';
import 'package:exact_cabs_driver/utils/text_styles.dart';
import 'package:exact_cabs_driver/views/navigation/emergency_contacts.dart';
import 'package:exact_cabs_driver/views/navigation/help.dart';
import 'package:exact_cabs_driver/widgets/button_widgets.dart';
import 'package:exact_cabs_driver/widgets/card_widgets.dart';
import 'package:exact_cabs_driver/widgets/icon_widgets.dart';
import 'package:exact_cabs_driver/widgets/text_widgets.dart';

class AddPaymentScreen extends StatefulWidget {
  @override
  _AddPaymentScreenState createState() => _AddPaymentScreenState();
}

class _AddPaymentScreenState extends State<AddPaymentScreen> {
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: AppBarTitle(
          title: "Add Payment".tr,
        ),
        leading: AppBarBack(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 200,
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                int imageNumber = index + 1;
                return Image(
                  image: AssetImage("assets/images/cards/card$imageNumber.png"),
                );
              },
              itemCount: 4,
              viewportFraction: 0.8,
              scale: 1,
              autoplay: false,
              // loop: false,
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: MainButton(
              text: "Next".tr,
              onPressed: (){
                // Get.to(()=>HelpPage());
              },
            ),
          ),
        ],
      ),
    );
  }

  

}
