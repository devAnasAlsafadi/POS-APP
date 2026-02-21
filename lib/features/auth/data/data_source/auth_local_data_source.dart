import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheToken(String token);
  String? getToken();
  Future<void> clearCache();
  Future<void> cacheUser(String name);
  String? getUserName();
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
    await sharedPreferences.remove("CACHED_USER_NAME");
  }

  @override
  Future<void> cacheUser(String name) async {
    await sharedPreferences.setString("CACHED_USER_NAME", name);
  }

  @override
  String? getUserName() {
    return sharedPreferences.getString("CACHED_USER_NAME");
  }
}
