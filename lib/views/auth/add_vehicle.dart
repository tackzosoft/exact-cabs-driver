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


class AddVehicle extends StatefulWidget {

  @override
  _AddVehicleState createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {
  TextEditingController vehicleNameController = new TextEditingController();

  TextEditingController vehicleTypeController = new TextEditingController();

  TextEditingController vehicleNumberController = new TextEditingController();


  List countries = [
    {
      "country" : "Cameroon",
      "code" : "+237",
      "flag" : "assets/logos/cameroon.png"
    },
    {
      "country" : "France",
      "code" : "+33",
      "flag" : "assets/logos/france.png"
    }
  ];

  Io.File insuranceFile;
  String insuranceFileBase64 = "";
  String insuranceFileName = "";
  String insuranceFileExt = "";

  Io.File technicalControlFile;
  String technicalControlFileBase64 = "";
  String technicalControlFileName = "";
  String technicalControlFileExt = "";

  Io.File carteGriseFile;
  String carteGriseFileBase64 = "";
  String carteGriseFileName = "";
  String carteGriseFileExt = "";


  List<String> vehicleImages = [];

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: AppBarTitle(title: "Add Vehicle".tr,),
        leading: AppBarBack(),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadedHeading(title: "Vehicle Name".tr),
              TextField(
                controller: vehicleNameController,
                style: inputTextStyle,
              ),
              SizedBox(height: 30,),
              FadedHeading(title: "Vehicle Type".tr),
              TextField(
                controller: vehicleTypeController,
                style: inputTextStyle,
              ),
              SizedBox(height: 30,),
              FadedHeading(title: "Vehicle Registration Number".tr),
              TextField(
                controller: vehicleNumberController,
                style: inputTextStyle,
              ),
              SizedBox(height: 30,),
              FadedHeading(title: "Vehicle Images".tr),
              InkWell(
                onTap: () async {
                  if(vehicleImages.length<5){
                    onCameraPressed();
                  }else{
                    showSnackBar(context, "Maximum 5 images allowed");
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
                        "Add Images".tr,
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: vehicleImages.map((imageString){
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(5, 10, 10, 0),
                          child: Image.memory(
                            base64Decode(imageString),
                            width: size.width * 0.25,
                          ),
                        ),
                        Positioned(
                          top:0,
                            right:0,
                            child: InkWell(
                              onTap:(){
                                setState(() {
                                  vehicleImages.remove(imageString);
                                });
                              },
                              child: Icon(
                                Icons.cancel,
                                size: 30,
                                color: Colors.grey,
                              ),
                            ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 30,),
              FadedHeading(title: "Vehicle Insurance".tr),
              InkWell(
                onTap: ()async{
                  var result = await onAddFile();
                  if(result==null) return;

                  if(result=="camera"){
                    var pickedFile = await getImage(ImageSource.camera);

                    if (pickedFile != null) {
                      var path = pickedFile.path;
                      insuranceFile = Io.File(path);
                      insuranceFileExt = path.toString().split(".").last;
                      insuranceFileName = "InsuranceImage";
                      var bytes = insuranceFile.readAsBytesSync();
                      setState(() {
                        insuranceFileBase64 = base64Encode(bytes);
                      });
                    } else {
                      showSnackBar(context, "No image selected");
                    }
                  }
                  if(result=="gallery"){
                    var pickedFile = await getImage(ImageSource.gallery);

                    if (pickedFile != null) {
                      var path = pickedFile.path;
                      insuranceFile = Io.File(path);
                      insuranceFileExt = path.toString().split(".").last;
                      insuranceFileName = "InsuranceImage";
                      var bytes = insuranceFile.readAsBytesSync();
                      setState(() {
                        insuranceFileBase64 = base64Encode(bytes);
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
                      insuranceFile = Io.File(path);
                      insuranceFileExt = pickedFile.files.first.extension;
                      insuranceFileName = "InsuranceFile_"+pickedFile.files.first.name.split(".").first;
                      var bytes = insuranceFile.readAsBytesSync();
                      setState(() {
                        insuranceFileBase64 = base64Encode(bytes);
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
                visible: insuranceFileBase64.isNotEmpty && insuranceFileExt!="pdf",
                child: Container(
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: Image.memory(
                    base64Decode(insuranceFileBase64),
                    width: size.width * 0.8,
                  ),
                ),
              ),
              Visibility(
                visible: insuranceFileBase64.isNotEmpty && insuranceFileExt=="pdf",
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
                            insuranceFileName + "." + insuranceFileExt,
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
                            OpenFile.open(insuranceFile.path);
                          }
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30,),
              FadedHeading(title: "Technical Control Document".tr),
              InkWell(
                onTap: ()async{
                  var result = await onAddFile();
                  if(result==null) return;

                  if(result=="camera"){
                    var pickedFile = await getImage(ImageSource.camera);

                    if (pickedFile != null) {
                      var path = pickedFile.path;
                      technicalControlFile = Io.File(path);
                      technicalControlFileExt = path.toString().split(".").last;
                      technicalControlFileName = "TechnicalControlImage";
                      var bytes = technicalControlFile.readAsBytesSync();
                      setState(() {
                        technicalControlFileBase64 = base64Encode(bytes);
                      });
                    } else {
                      showSnackBar(context, "No image selected");
                    }
                  }
                  if(result=="gallery"){
                    var pickedFile = await getImage(ImageSource.gallery);

                    if (pickedFile != null) {
                      var path = pickedFile.path;
                      technicalControlFile = Io.File(path);
                      technicalControlFileExt = path.toString().split(".").last;
                      technicalControlFileName = "TechnicalControlImage";
                      var bytes = technicalControlFile.readAsBytesSync();
                      setState(() {
                        technicalControlFileBase64 = base64Encode(bytes);
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
                      technicalControlFile = Io.File(path);
                      technicalControlFileExt = pickedFile.files.first.extension;
                      technicalControlFileName = "TechnicalControlFile_"+pickedFile.files.first.name.split(".").first;
                      var bytes = technicalControlFile.readAsBytesSync();
                      setState(() {
                        technicalControlFileBase64 = base64Encode(bytes);
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
                visible: technicalControlFileBase64.isNotEmpty && technicalControlFileExt!="pdf",
                child: Container(
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: Image.memory(
                    base64Decode(technicalControlFileBase64),
                    width: size.width * 0.8,
                  ),
                ),
              ),
              Visibility(
                visible: technicalControlFileBase64.isNotEmpty && technicalControlFileExt=="pdf",
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
                          technicalControlFileName + "." + technicalControlFileExt,
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
                            OpenFile.open(technicalControlFile.path);
                          }
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30,),
              FadedHeading(title: "Carte Grise".tr),
              InkWell(
                onTap: ()async{
                  var result = await onAddFile();
                  if(result==null) return;

                  if(result=="camera"){
                    var pickedFile = await getImage(ImageSource.camera);

                    if (pickedFile != null) {
                      var path = pickedFile.path;
                      carteGriseFile = Io.File(path);
                      carteGriseFileExt = path.toString().split(".").last;
                      carteGriseFileName = "CarteGriseImage";
                      var bytes = carteGriseFile.readAsBytesSync();
                      setState(() {
                        carteGriseFileBase64 = base64Encode(bytes);
                      });
                    } else {
                      showSnackBar(context, "No image selected");
                    }
                  }
                  if(result=="gallery"){
                    var pickedFile = await getImage(ImageSource.gallery);

                    if (pickedFile != null) {
                      var path = pickedFile.path;
                      carteGriseFile = Io.File(path);
                      carteGriseFileExt = path.toString().split(".").last;
                      carteGriseFileName = "CarteGriseImage";
                      var bytes = carteGriseFile.readAsBytesSync();
                      setState(() {
                        carteGriseFileBase64 = base64Encode(bytes);
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
                      carteGriseFile = Io.File(path);
                      carteGriseFileExt = pickedFile.files.first.extension;
                      carteGriseFileName = "CarteGriseFile_"+pickedFile.files.first.name.split(".").first;
                      var bytes = carteGriseFile.readAsBytesSync();
                      setState(() {
                        carteGriseFileBase64 = base64Encode(bytes);
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
                visible: carteGriseFileBase64.isNotEmpty && carteGriseFileExt!="pdf",
                child: Container(
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: Image.memory(
                    base64Decode(carteGriseFileBase64),
                    width: size.width * 0.8,
                  ),
                ),
              ),
              Visibility(
                visible: carteGriseFileBase64.isNotEmpty && carteGriseFileExt=="pdf",
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
                          carteGriseFileName + "." + carteGriseFileExt,
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
                            OpenFile.open(carteGriseFile.path);
                          }
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30,),
              MainButton(
                  text: "Add Vehicle".tr,
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
    if(vehicleNameController.text.isEmpty){
      showSnackBar(context, "Please enter vehicle name");
      return false;
    }
    if(vehicleTypeController.text.isEmpty) {
      showSnackBar(context, "Please enter vehicle type");
      return false;
    }
    if(vehicleNumberController.text.isEmpty) {
      showSnackBar(context, "Please enter vehicle registration number");
      return false;
    }
    if(vehicleImages.isEmpty) {
      showSnackBar(context, "Please add atleast one image of your vehicle");
      return false;
    }
    if(insuranceFileBase64.isEmpty) {
      showSnackBar(context, "Please add an insurance file");
      return false;
    }
    if(technicalControlFileBase64.isEmpty) {
      showSnackBar(context, "Please add a technical control file");
      return false;
    }
    if(carteGriseFileBase64.isEmpty) {
      showSnackBar(context, "Please add a carte grise file");
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
    var result = await ApiServices().addVehicle(
        vehicleImages: vehicleImages,
      vehicleName: vehicleNameController.text,
      vehicleType: vehicleTypeController.text,
      vehicleRegistrationNumber: vehicleNumberController.text,
      insuranceFile: {
        "file_name":insuranceFileName,
        "file_type":insuranceFileExt,
        "file_data": insuranceFileBase64
      },
      technicalControlFile: {
        "file_name":technicalControlFileName,
        "file_type":technicalControlFileExt,
        "file_data": technicalControlFileBase64
      },
      carteGriseFile: {
        "file_name":carteGriseFileName,
        "file_type":carteGriseFileExt,
        "file_data": carteGriseFileBase64
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

  void onCameraPressed() {
    Get.defaultDialog(
      barrierDismissible: false,
        title: "Add image from",
        cancel: InkWell(
          onTap: () => Get.back(),
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
              onTap: () => getVehicleImage(ImageSource.camera),
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
              onTap: () => getVehicleImage(ImageSource.gallery),
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
          ],
        ));
  }

  Future getVehicleImage(ImageSource source) async {
    Get.back();

    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;
    if (!permissionStatus.isGranted) {
      print("Please allow storage access");
      return;
    }

    final picker = ImagePicker();
    var pickedFile = await picker.pickImage(source: source);

    String vimagePath = "";
    Io.File _vimage;
    List<int> vimageBytes = [];

    if (pickedFile != null) {
      vimagePath = pickedFile.path;
      _vimage = Io.File(vimagePath);
      vimageBytes = _vimage.readAsBytesSync();
      setState(() {
        vehicleImages.add(base64Encode(vimageBytes));
      });
    } else {
      print("No Image Picked");
    }
  }


}
