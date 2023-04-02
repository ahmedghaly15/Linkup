import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  //=============== For Initializing The SharedPreferences ===============
  static initSharedPref() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);

    return await sharedPreferences.setDouble(key, value);
  }

  //=============== For Getting Saved Boolean Data In Shared Pref ===============
  static bool? getBoolData({required String key}) {
    return sharedPreferences.getBool(key);
  }

  //=============== For Getting Saved String Data In Shared Pref ===============
  static String? getStringData({required String key}) {
    return sharedPreferences.getString(key);
  }

  //============== For Removing Some Saved Data From SharedPref ==============
  static Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }
}
