import 'package:exact_cabs_driver/services/api_services.dart';
import 'package:exact_cabs_driver/utils/country_data.dart';
import 'package:exact_cabs_driver/views/auth/add_vehicle.dart';
import 'package:exact_cabs_driver/views/message_screens/registration_complete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exact_cabs_driver/utils/colors.dart';
import 'package:exact_cabs_driver/utils/text_styles.dart';
import 'package:exact_cabs_driver/views/auth/login.dart';
import 'package:exact_cabs_driver/widgets/button_widgets.dart';
import 'package:exact_cabs_driver/widgets/icon_widgets.dart';
import 'package:exact_cabs_driver/widgets/text_widgets.dart';

class RegisterScreen extends StatefulWidget {

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController fNameController = new TextEditingController();

  TextEditingController lNameController = new TextEditingController();

  TextEditingController emailController = new TextEditingController();

  TextEditingController phoneController = new TextEditingController();

  TextEditingController passwordController = new TextEditingController();



  String selectedCountryCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: AppBarTitle(title: "register".tr,),
        leading: AppBarBack(),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                        icon: Image(
                          image: AssetImage("assets/logos/google_logo_white.png"),
                          height: 25,
                        ),
                        onPressed: (){},
                        color: googleButtonColor
                    ),
                  ),
                  SizedBox(width: 15,),
                  Expanded(
                    child: FilledButton(
                        icon: Image(
                          image: AssetImage("assets/logos/fb_logo_white.png"),
                          height: 25,
                        ),
                        onPressed: (){},
                        color: facebookButtonColor
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Center(child:FadedHeading(title: 'or'.tr,)),
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      FadedHeading(title: "First Name".tr),
                      TextField(
                        controller: fNameController,
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
                        controller: lNameController,
                        style: inputTextStyle,
                      ),
                    ],),
                  ),
                ],
              ),
              SizedBox(height: 30,),
              FadedHeading(title: "Email".tr),
              TextField(
                controller: emailController,
                style: inputTextStyle,
              ),
              SizedBox(height: 30,),
              FadedHeading(title: "Mobile".tr),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownButton(
                    value: selectedCountryCode,
                    underline: SizedBox(),
                    hint: Text("Select Country"),
                    onChanged: (value){

                      setState(() {
                        selectedCountryCode = value;
                      });
                      print(selectedCountryCode);
                    },
                    items: COUNTRIES.map((country) {
                      return DropdownMenuItem(
                        child: Text(
                          "${country["country"]}(${country["code"]})",
                        ),
                        value: country["code"],
                      );
                    }).toList(),
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    child: TextField(
                      controller: phoneController,
                      style: inputTextStyle,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      decoration: InputDecoration(
                        counterText: ""
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30,),
              FadedHeading(title: "Password".tr),
              TextField(
                controller: passwordController,
                style: inputTextStyle,

              ),
              SizedBox(height: 40,),
              MainButton(
                  text: "Next".tr,
                  onPressed: (){
                    register(context);

                  }
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }

  void register(BuildContext context) async{
    Get.dialog(
      Center(child: CircularProgressIndicator()),
      barrierDismissible: true,
    );
    var result = await ApiServices().driverRegister(
        mobile: phoneController.text,
        password: passwordController.text,
      fName: fNameController.text,
      lName: lNameController.text,
      email: emailController.text,
      country: "FR"
    );
    Get.back();
    if(result==null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Check Your Internet Connectivity")));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result["message"])));
      if(result["statusCode"]==200){
        Get.off(()=>RegistrationCompletedPage());
      }

    }

  }

  bool validate(){
    return true;
  }
}
