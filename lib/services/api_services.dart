import 'dart:convert';

import 'package:exact_cabs_driver/models/user_model.dart';
import 'package:exact_cabs_driver/services/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:exact_cabs_driver/constants/api_endpoints.dart';

class ApiServices{

  Future<dynamic> driverLogin({String phoneNumber, String password, String deviceType, String deviceId, String countryCode}) async{
    Map data = {
      "mobile": phoneNumber,
      "password": password,
      "device_type": deviceType,
      "device_id": deviceId,
      "country_code":countryCode
    };
    print(jsonEncode(data));
    print(ApiEndPoints.driverLogin);
    try{
      var response = await http.post(
          ApiEndPoints.driverLogin,
          body: jsonEncode(data),
          headers: {"Content-Type": "application/json"});
      Map responseBody = jsonDecode(response.body);
      print(responseBody);
      if(responseBody["statusCode"]==200){
        SharedPrefsService.saveToken(responseBody["data"]["token"]);
        return UserModel.fromJson(responseBody["data"]["user_data"]);
      }else{
        return responseBody;
      }
    }catch(e){
      print("Error caught during User Login: " + e.toString());
    }
    return null;
  }

  Future<dynamic> driverRegister({
    String fName,
    String lName,
    String email,
    String mobile,
    String password,
    String country
  }) async{

    Map data = {
      "email": email,
      "mobile": mobile,
      "first_name":fName,
      "last_name":lName,
      "device_id":"dd",
      "device_type":"ddd",
      "password": password,
      "username" : fName+lName,
      "gender":"male",
      "dob":"1-1-1999",
      "country_code" : country
    };
    print(jsonEncode(data));
    print(ApiEndPoints.driverRegister);

    try{
      var response = await http.post(
          ApiEndPoints.driverRegister,
          body: jsonEncode(data),
          headers: {"Content-Type": "application/json"});
      Map responseBody = jsonDecode(response.body);
      print(responseBody);
      return responseBody;
    }catch(e){
      print("Error caught during Driver Login: " + e.toString());
      return {
        "success": false,
        "message" : "Network Error Occurred"
      };
    }
  }

  Future<dynamic> updateDuty({
    String latitude,
    String longitude,
    String location,
    String address,
    String status,
    String date
  }) async{

    Map data = {
      "date" :date,
      "latitude":latitude,
      "longitude":longitude,
      "latest_location":location,
      "location_address":address,
      "status":status
    };
    print(jsonEncode(data));
    print(ApiEndPoints.updateDuty);
    print(SharedPrefsService.getToken());


    try{
      var response = await http.post(
          ApiEndPoints.updateDuty,
          body: jsonEncode(data),
          headers: {
            "Content-Type": "application/json",
            "Authorization" : SharedPrefsService.getToken()
          }
          );
      Map responseBody = jsonDecode(response.body);
      print(responseBody);
      return responseBody;
    }catch(e){
      print("Error caught while updating duty: " + e.toString());
      return {
        "httpCode": 500,
        "success": false,
        "message" : "Network Error Occurred"
      };
    }
  }

  Future<dynamic> acceptDuty(String bookingRequestId) async{

    Map data = {
      "booking_request_id": bookingRequestId,
      "driver_duity_id": SharedPrefsService.getDutyId()
    };
    print(jsonEncode(data));
    print(ApiEndPoints.acceptDuty);

    try{
      var response = await http.post(
          ApiEndPoints.acceptDuty,
          body: jsonEncode(data),
          headers: {
            "Content-Type": "application/json",
            "Authorization" : SharedPrefsService.getToken()
          }
      );
      Map responseBody = jsonDecode(response.body);
      print(responseBody);
      return responseBody;
    }catch(e){
      print("Error caught while updating duty: " + e.toString());
      return {
        "httpCode": 500,
        "success": false,
        "message" : "Network Error Occurred"
      };
    }
  }

  Future<dynamic> addVehicle({
    String vehicleName,
    String vehicleType,
    String vehicleRegistrationNumber,
    List<String> vehicleImages,
    Map<String,String> insuranceFile,
    Map<String,String> technicalControlFile,
    Map<String,String> carteGriseFile,

  }) async{

    Map data = {
      "vehical_type":vehicleType,
      "vehical_name":vehicleName,
      "vehical_registration_number":vehicleRegistrationNumber,
      "vehical_image" : vehicleImages,
      "vehical_insurance" : insuranceFile,
      "technical_control":technicalControlFile,
      "carte_grise" : carteGriseFile
    };
    print(jsonEncode(data));
    print(ApiEndPoints.addVehicle);

    try{
      var response = await http.post(
          ApiEndPoints.addVehicle,
          body: jsonEncode(data),
          headers: {
            "Content-Type": "application/json",
            "Authorization" : SharedPrefsService.getToken()
          }
      );
      Map responseBody = jsonDecode(response.body);
      print(responseBody);
      return responseBody;
    }catch(e){
      print("Error caught while adding vehicle: " + e.toString());
      return {
        "httpCode": 500,
        "success": false,
        "message" : "Network Error Occurred"
      };
    }
  }

  Future<dynamic> addDriverDocument({
    String dutyLocation,
    Map<String,String> drivingLicenseFile,
    Map<String,String> identityCardFile,
    Map<String,String> addressProofFile,

  }) async{

    Map data = {
      "location_of_duty":dutyLocation,
      "identity" : identityCardFile,
      "driving_license":drivingLicenseFile,
      "address_proof" : addressProofFile
    };
    print(jsonEncode(data));
    print(ApiEndPoints.addDriverDocument);

    try{
      var response = await http.post(
          ApiEndPoints.addDriverDocument,
          body: jsonEncode(data),
          headers: {
            "Content-Type": "application/json",
            "Authorization" : SharedPrefsService.getToken()
          }
      );
      Map responseBody = jsonDecode(response.body);
      print(responseBody);
      return responseBody;
    }catch(e){
      print("Error caught while updating driving document: " + e.toString());
      return {
        "httpCode": 500,
        "success": false,
        "message" : "Network Error Occurred"
      };
    }
  }

  Future<dynamic> getDriverStatus() async{

    print(ApiEndPoints.getDriverStatus);

    try{
      var response = await http.get(
          ApiEndPoints.getDriverStatus,
          headers: {
            "Content-Type": "application/json",
            "Authorization" : SharedPrefsService.getToken()
          }
      );
      Map responseBody = jsonDecode(response.body);
      print(responseBody);
      return responseBody;
    }catch(e){
      print("Error caught while getting driver status: " + e.toString());
      return {
        "httpCode": 500,
        "success": false,
        "message" : "Network Error Occurred"
      };
    }
  }

}