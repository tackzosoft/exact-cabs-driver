import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exact_cabs_driver/utils/colors.dart';
import 'package:exact_cabs_driver/utils/text_styles.dart';
import 'package:exact_cabs_driver/views/auth/add_payment.dart';
import 'package:exact_cabs_driver/widgets/button_widgets.dart';
import 'package:exact_cabs_driver/widgets/card_widgets.dart';
import 'package:exact_cabs_driver/widgets/icon_widgets.dart';
import 'package:exact_cabs_driver/widgets/text_widgets.dart';

class PaymentType extends StatelessWidget {
  // const PaymentType({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: AppBarTitle(
          title: "Payment Type".tr,
        ),
        leading: AppBarBack(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.maxFinite,
            color: Colors.white,
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30,),
                FadedHeading(title: "Enter Promo Code Here".tr),
                Row(
                  children: [
                    Expanded(
                        child: TextField(
                          style: inputTextStyle,
                          decoration: InputDecoration(
                            suffix: TextButton(
                              onPressed: (){},
                              child: ButtonText("Done".tr),
                            ),
                            contentPadding: EdgeInsets.zero,
                          ),
                        )
                    ),

                  ],
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  BoldHeading(title: "Select Payment Mode".tr),
                  SelectableCard(
                      title: "Credit/Debit".tr,
                      isSelected: true
                  ),
                  SelectableCard(
                      title: "Cash".tr,
                      isSelected: false
                  ),
                  SelectableCard(
                      title: "MTN Mobile Money".tr,
                      isSelected: false
                  ),
                  SelectableCard(
                      title: "Orange Mobile Money".tr,
                      isSelected: false
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: MainButton(
                text: "Done".tr,
              onPressed: (){
                  Get.to(()=>AddPaymentScreen());
              },
            ),
          ),
        ],
      ),
    );
  }
}
