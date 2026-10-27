import 'package:shared_preferences/shared_preferences.dart';

class PrefrenceManager {
  late SharedPreferences _preferences;
  static final PrefrenceManager _instance = PrefrenceManager._internal();

  PrefrenceManager._internal();

  factory PrefrenceManager() {
    return _instance;
  }

  Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future setString(String key, String value) async {
    await _preferences.setString(key, value);
  }

  String? getString(String key) {
    return _preferences.getString(key);
  }

  Future setBool(String key, bool value) async {
    await _preferences.setBool(key, value);
  }

  bool? getBool(String key) {
    return _preferences.getBool(key);
  }

  Future remove(String key) async {
    await _preferences.remove(key);
  }
}
