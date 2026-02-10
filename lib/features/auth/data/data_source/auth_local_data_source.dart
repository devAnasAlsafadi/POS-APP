import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheToken(String token);
  String? getToken();
  Future<void> clearCache();
}


class AuthLocalDataSourceImpl implements AuthLocalDataSource {

  final SharedPreferences sharedPreferences;
  AuthLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<void> cacheToken(String token
      )async {
    await sharedPreferences.setString("CACHED_TOKEN", token);
  }

  @override
  String? getToken() {
    return sharedPreferences.getString("CACHED_TOKEN");
  }

  @override
  Future<void> clearCache() async {
    await sharedPreferences.remove("CACHED_TOKEN");
  }
}