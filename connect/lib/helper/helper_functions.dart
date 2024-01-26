import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction {
  static String userLogedInKey = "LOGEDINKEY";
  static String userEmailKey = "USEREMAILKEY";

  static Future<bool?> getUserLogedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLogedInKey);
  }
}
