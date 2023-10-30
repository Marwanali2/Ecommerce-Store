// https://blog.logrocket.com/using-sharedpreferences-in-flutter-to-store-data-locally/
//https://poe.com/s/KHVE4ZiMoKDVBuOqfRBS

import 'package:shared_preferences/shared_preferences.dart';

class CachedNetwork {
  static late SharedPreferences shardPref;

  static Future cacheInitialization() async {
    shardPref = await SharedPreferences.getInstance();
  }

  static Future<bool> insertToCache(
      {required String key, required String value}) async {
    return await shardPref.setString(key, value);
  }

  static String getCacheData({required String key}) {
    return shardPref.getString(key) ?? '';
  }

  static Future<bool> deleteCacheItem({required String key}) async {
    return await shardPref.remove(key);
  }
}

class CachedLocal {
  static late SharedPreferences shardPref;

  static Future cacheInitialization() async {
    shardPref = await SharedPreferences.getInstance();
  }

  static insertToCache({required String key, required bool value}) async {
    return await shardPref.setBool(key, value);
  }

  static bool getCacheData({required String key}) {
    return shardPref.getBool(key) ?? true;
  }

  static Future<bool> deleteCacheItem({required String key}) async {
    return await shardPref.remove(key);
  }
}
