import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction {
  static String userLogedInKey = "LOGEDINKEY";
  static String userEmailKey = "USEREMAILKEY";
  static String userNameKey = "USERNAMEKEY";
  static String teacherLogedInKey = "KEY";

  //getting data from sf
  static Future<bool?> getUserLogedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLogedInKey);
  }

  static Future<bool?> getTeacherLogedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(teacherLogedInKey);
  }

  //saving data to sf
  static Future<bool> saveUserLoggedInStatus(bool isUserLoggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLogedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserNameSF(String userName) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userNameKey, userName);
  }

  static Future<bool> saveUserEmailSF(String userEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailKey, userEmail);
  }

  static Future<bool> saveTeacherLoggedInStatus(bool isTeacherLoggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(teacherLogedInKey, isTeacherLoggedIn);
  }

  static Future<bool> saveTeacherEmailSF(String userEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailKey, userEmail);
  }
}
