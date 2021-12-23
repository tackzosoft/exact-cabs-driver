import 'package:exact_cabs_driver/services/api_services.dart';
import 'package:exact_cabs_driver/services/misc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exact_cabs_driver/utils/colors.dart';
import 'package:exact_cabs_driver/utils/text_styles.dart';
import 'package:exact_cabs_driver/views/auth/login.dart';
import 'package:exact_cabs_driver/widgets/button_widgets.dart';
import 'package:exact_cabs_driver/widgets/icon_widgets.dart';
import 'package:exact_cabs_driver/widgets/text_widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as Io;
import 'dart:convert';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';


class AddDriverDetails extends StatefulWidget {

  @override
  _AddDriverDetailsState createState() => _AddDriverDetailsState();
}

class _AddDriverDetailsState extends State<AddDriverDetails> {
  TextEditingController locationNameController = new TextEditingController();


  Io.File drivingLicenseFile;
  String drivingLicenseFileBase64 = "";
  String drivingLicenseFileName = "";
  String drivingLicenseFileExt = "";

  Io.File identityCardFile;
  String identityCardFileBase64 = "";
  String identityCardFileName = "";
  String identityCardFileExt = "";

  Io.File addressProofFile;
  String addressProofFileBase64 = "";
  String addressProofFileName = "";
  String addressProofFileExt = "";




  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: AppBarTitle(title: "Add Your Details".tr,),
        leading: AppBarBack(),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadedHeading(title: "Location of Duty".tr),
              FadedHeading(title: "(Preferred area where you would like to drive)".tr, isBold: false, textSize: 14,),
              TextField(
                controller: locationNameController,
                style: inputTextStyle,
              ),
              SizedBox(height: 30,),
              FadedHeading(title: "Driving License".tr),
              InkWell(
                onTap: ()async{
                  var result = await onAddFile();
                  if(result==null) return;

                  if(result=="camera"){
                    var pickedFile = await getImage(ImageSource.camera);

                    if (pickedFile != null) {
                      var path = pickedFile.path;
                      drivingLicenseFile = Io.File(path);
                      drivingLicenseFileExt = path.toString().split(".").last;
                      drivingLicenseFileName = "InsuranceImage";
                      var bytes = drivingLicenseFile.readAsBytesSync();
                      setState(() {
                        drivingLicenseFileBase64 = base64Encode(bytes);
                      });
                    } else {
                      showSnackBar(context, "No image selected");
                    }
                  }
                  if(result=="gallery"){
                    var pickedFile = await getImage(ImageSource.gallery);

                    if (pickedFile != null) {
                      var path = pickedFile.path;
                      drivingLicenseFile = Io.File(path);
                      drivingLicenseFileExt = path.toString().split(".").last;
                      drivingLicenseFileName = "InsuranceImage";
                      var bytes = drivingLicenseFile.readAsBytesSync();
                      setState(() {
                        drivingLicenseFileBase64 = base64Encode(bytes);
                      });
                    } else {
                      showSnackBar(context, "No image selected");
                    }
                  }
                  if(result=="pdf"){

                    await Permission.storage.request();
                    var permissionStatus = await Permission.storage.status;
                    if (!permissionStatus.isGranted) {
                      print("Please allow storage access");
                      return;
                    }

                    FilePickerResult pickedFile = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['pdf'],
                    );

                    if (pickedFile != null) {
                      String path = pickedFile.files.first.path;
                      drivingLicenseFile = Io.File(path);
                      drivingLicenseFileExt = pickedFile.files.first.extension;
                      drivingLicenseFileName = "InsuranceFile_"+pickedFile.files.first.name.split(".").first;
                      var bytes = drivingLicenseFile.readAsBytesSync();
                      setState(() {
                        drivingLicenseFileBase64 = base64Encode(bytes);
                      });
                    } else {
                      showSnackBar(context, "No File selected");
                    }

                  }
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Add File".tr,
                        style: TextStyle(
                            fontSize: 16
                        ),
                      ),
                      Icon(
                          Icons.image_outlined
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: drivingLicenseFileBase64.isNotEmpty && drivingLicenseFileExt!="pdf",
                child: Container(
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: Image.memory(
                    base64Decode(drivingLicenseFileBase64),
                    width: size.width * 0.8,
                  ),
                ),
              ),
              Visibility(
                visible: drivingLicenseFileBase64.isNotEmpty && drivingLicenseFileExt=="pdf",
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          drivingLicenseFileName + "." + drivingLicenseFileExt,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.open_in_new,
                            color: Colors.black,
                          ),
                          onPressed: (){
                            OpenFile.open(drivingLicenseFile.path);
                          }
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30,),
              FadedHeading(title: "Identity Card".tr),
              FadedHeading(title: "(Passport, National Identity card, etc.)".tr, isBold: false, textSize: 14,),
              InkWell(
                onTap: ()async{
                  var result = await onAddFile();
                  if(result==null) return;

                  if(result=="camera"){
                    var pickedFile = await getImage(ImageSource.camera);

                    if (pickedFile != null) {
                      var path = pickedFile.path;
                      identityCardFile = Io.File(path);
                      identityCardFileExt = path.toString().split(".").last;
                      identityCardFileName = "TechnicalControlImage";
                      var bytes = identityCardFile.readAsBytesSync();
                      setState(() {
                        identityCardFileBase64 = base64Encode(bytes);
                      });
                    } else {
                      showSnackBar(context, "No image selected");
                    }
                  }
                  if(result=="gallery"){
                    var pickedFile = await getImage(ImageSource.gallery);

                    if (pickedFile != null) {
                      var path = pickedFile.path;
                      identityCardFile = Io.File(path);
                      identityCardFileExt = path.toString().split(".").last;
                      identityCardFileName = "TechnicalControlImage";
                      var bytes = identityCardFile.readAsBytesSync();
                      setState(() {
                        identityCardFileBase64 = base64Encode(bytes);
                      });
                    } else {
                      showSnackBar(context, "No image selected");
                    }
                  }
                  if(result=="pdf"){

                    await Permission.storage.request();
                    var permissionStatus = await Permission.storage.status;
                    if (!permissionStatus.isGranted) {
                      print("Please allow storage access");
                      return;
                    }

                    FilePickerResult pickedFile = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['pdf'],
                    );

                    if (pickedFile != null) {
                      String path = pickedFile.files.first.path;
                      identityCardFile = Io.File(path);
                      identityCardFileExt = pickedFile.files.first.extension;
                      identityCardFileName = "TechnicalControlFile_"+pickedFile.files.first.name.split(".").first;
                      var bytes = identityCardFile.readAsBytesSync();
                      setState(() {
                        identityCardFileBase64 = base64Encode(bytes);
                      });
                    } else {
                      showSnackBar(context, "No File selected");
                    }

                  }
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Add File".tr,
                        style: TextStyle(
                            fontSize: 16
                        ),
                      ),
                      Icon(
                          Icons.image_outlined
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: identityCardFileBase64.isNotEmpty && identityCardFileExt!="pdf",
                child: Container(
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: Image.memory(
                    base64Decode(identityCardFileBase64),
                    width: size.width * 0.8,
                  ),
                ),
              ),
              Visibility(
                visible: identityCardFileBase64.isNotEmpty && identityCardFileExt=="pdf",
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          identityCardFileName + "." + identityCardFileExt,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.open_in_new,
                            color: Colors.black,
                          ),
                          onPressed: (){
                            OpenFile.open(identityCardFile.path);
                          }
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30,),
              FadedHeading(title: "Address Proof".tr),
              FadedHeading(title: "(Electricity bill, Water bill, etc)".tr, isBold: false, textSize: 14,),
              InkWell(
                onTap: ()async{
                  var result = await onAddFile();
                  if(result==null) return;

                  if(result=="camera"){
                    var pickedFile = await getImage(ImageSource.camera);

                    if (pickedFile != null) {
                      var path = pickedFile.path;
                      addressProofFile = Io.File(path);
                      addressProofFileExt = path.toString().split(".").last;
                      addressProofFileName = "CarteGriseImage";
                      var bytes = addressProofFile.readAsBytesSync();
                      setState(() {
                        addressProofFileBase64 = base64Encode(bytes);
                      });
                    } else {
                      showSnackBar(context, "No image selected");
                    }
                  }
                  if(result=="gallery"){
                    var pickedFile = await getImage(ImageSource.gallery);

                    if (pickedFile != null) {
                      var path = pickedFile.path;
                      addressProofFile = Io.File(path);
                      addressProofFileExt = path.toString().split(".").last;
                      addressProofFileName = "CarteGriseImage";
                      var bytes = addressProofFile.readAsBytesSync();
                      setState(() {
                        addressProofFileBase64 = base64Encode(bytes);
                      });
                    } else {
                      showSnackBar(context, "No image selected");
                    }
                  }
                  if(result=="pdf"){

                    await Permission.storage.request();
                    var permissionStatus = await Permission.storage.status;
                    if (!permissionStatus.isGranted) {
                      print("Please allow storage access");
                      return;
                    }

                    FilePickerResult pickedFile = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['pdf'],
                    );

                    if (pickedFile != null) {
                      String path = pickedFile.files.first.path;
                      addressProofFile = Io.File(path);
                      addressProofFileExt = pickedFile.files.first.extension;
                      addressProofFileName = "CarteGriseFile_"+pickedFile.files.first.name.split(".").first;
                      var bytes = addressProofFile.readAsBytesSync();
                      setState(() {
                        addressProofFileBase64 = base64Encode(bytes);
                      });
                    } else {
                      showSnackBar(context, "No File selected");
                    }

                  }
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Add File".tr,
                        style: TextStyle(
                            fontSize: 16
                        ),
                      ),
                      Icon(
                          Icons.image_outlined
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: addressProofFileBase64.isNotEmpty && addressProofFileExt!="pdf",
                child: Container(
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: Image.memory(
                    base64Decode(addressProofFileBase64),
                    width: size.width * 0.8,
                  ),
                ),
              ),
              Visibility(
                visible: addressProofFileBase64.isNotEmpty && addressProofFileExt=="pdf",
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          addressProofFileName + "." + addressProofFileExt,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.open_in_new,
                            color: Colors.black,
                          ),
                          onPressed: (){
                            OpenFile.open(addressProofFile.path);
                          }
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30,),
              MainButton(
                  text: "Submit".tr,
                  onPressed: (){
                    addVehicle(context);
                    // Get.offAll(()=>LoginScreen());
                  }
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }

  bool validate(){
    if(locationNameController.text.isEmpty){
      showSnackBar(context, "Please enter a preferred location of duty");
      return false;
    }
    if(drivingLicenseFileBase64.isEmpty) {
      showSnackBar(context, "Please add a driving license");
      return false;
    }
    if(identityCardFileBase64.isEmpty) {
      showSnackBar(context, "Please add an identity card");
      return false;
    }
    if(addressProofFileBase64.isEmpty) {
      showSnackBar(context, "Please add a proof of address");
      return false;
    }

    return true;
  }

  void addVehicle(BuildContext context) async{

    bool valid = validate();
    if(!valid) return;

    Get.dialog(
      Center(child: CircularProgressIndicator()),
      barrierDismissible: true,
    );
    var result = await ApiServices().addDriverDocument(
      dutyLocation: locationNameController.text,
      drivingLicenseFile: {
        "file_name":drivingLicenseFileName,
        "file_type":drivingLicenseFileExt,
        "file_data": drivingLicenseFileBase64
      },
      identityCardFile: {
        "file_name":identityCardFileName,
        "file_type":identityCardFileExt,
        "file_data": identityCardFileBase64
      },
      addressProofFile: {
        "file_name":addressProofFileName,
        "file_type":addressProofFileExt,
        "file_data": addressProofFileBase64
      },

    );
    Get.back();
    if(result==null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Check Your Internet Connectivity")));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result["message"])));
    }

  }

  Future<dynamic> onAddFile() async {
    return await Get.defaultDialog(
        barrierDismissible: false,
        title: "Add image from",
        cancel: InkWell(
          onTap: (){
            Get.back();
            // return null;
          },
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: primaryColor)),
            child: Center(
              child: Text(
                "Cancel",
                style: TextStyle(color: primaryColor),
              ),
            ),
          ),
        ),
        content: Column(
          children: [
            InkWell(
              onTap: () {
                Get.back(result: "camera");
              } ,
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: primaryColor),
                child: Center(
                  child: Text(
                    "Camera",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.back(result: "gallery");
              } ,
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: primaryColor),
                child: Center(
                  child: Text(
                    "Gallery",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.back(result: "pdf");
              } ,
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: primaryColor),
                child: Center(
                  child: Text(
                    "Add PDF",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Future<dynamic> getImage(ImageSource source) async {

    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;
    if (!permissionStatus.isGranted) {
      print("Please allow storage access");
      return;
    }

    final picker = ImagePicker();
    return await picker.pickImage(source: source);

  }


}
