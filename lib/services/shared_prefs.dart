import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService{

  static SharedPreferences prefs;

  static Future<SharedPreferences> init() async{
    prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  static String getString(String key) {
    return prefs.getString(key);
  }

  static Future<bool> saveString(String key, String value) async{
    return await prefs.setString(key, value);
  }

  static void saveLocale(String locale) {
    saveString('locale', locale);
  }

  static String getLocale() {
    return getString('locale') ?? "English";
  }

  static void saveToken(String token){
    saveString('token', token);
  }

  static void clearToken(){
    saveString('token', "");
  }

  static String getToken() {
    return getString('token');
  }

  static void saveDutyId(String dutyId){
    saveString('dutyId', dutyId);
  }

  static String getDutyId() {
    return getString('dutyId');
  }

  static  saveDutyStatus(bool status) async{
    return await prefs.setBool('dutyStatus', status);
  }

  static bool getDutyStatus() {
    return prefs.getBool('dutyStatus');
  }

}