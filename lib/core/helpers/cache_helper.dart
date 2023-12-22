import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  late final SharedPreferences _sharedPreferences;

  CacheHelper(this._sharedPreferences);

  Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await _sharedPreferences.setString(key, value);
    if (value is bool) return await _sharedPreferences.setBool(key, value);
    if (value is int) return await _sharedPreferences.setInt(key, value);

    return await _sharedPreferences.setDouble(key, value);
  }

  bool? getBoolData({required String key}) {
    return _sharedPreferences.getBool(key);
  }

  int? getIntData({required String key}) {
    return _sharedPreferences.getInt(key);
  }

  String? getStringData({required String key}) {
    return _sharedPreferences.getString(key);
  }

  Future<bool> removeData({required String key}) async {
    return await _sharedPreferences.remove(key);
  }

  Future<bool> clearData() async {
    return await _sharedPreferences.clear();
  }
}
