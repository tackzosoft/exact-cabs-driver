import 'package:exact_cabs_driver/services/shared_prefs.dart';

const String API_BASE_URL = "http://15.228.146.26:8010";

class ApiEndPoints{

  static String baseUrl = API_BASE_URL + "/api/v1";
  static String driver = baseUrl + "/driver";
  static String driverProfile = baseUrl + "/driver_profile";
  static String duty = baseUrl + "/driver_duty";


  static Uri driverLogin = Uri.parse(driver + "/login");
  static Uri driverRegister = Uri.parse(driver + "/register");
  static Uri updateDuty = Uri.parse(duty + "/update_duty");
  static Uri acceptDuty = Uri.parse(duty + "/accept_data");
  static Uri addVehicle = Uri.parse(duty + "/add_vehical");
  static Uri addDriverDocument = Uri.parse(driverProfile + "/update_driver_document");
  static Uri getDriverStatus = Uri.parse(driverProfile + "/driver_status");

  // static Uri driversCustomers = Uri.parse(driver + "/customers?driver=" + SharedPrefsService.getDriverId());
  // static Uri driversCustomers = Uri.parse(driver + "/customers?driver=" + "60feb6fd0e7a61001c6b075c");
  // static Uri driversPayments = Uri.parse(driver + "/payments?driver=" + SharedPrefsService.getDriverId());
// static Uri driversPayments = Uri.parse(driver + "/payments?driver=" + "60feb6fd0e7a61001c6b075c");
}