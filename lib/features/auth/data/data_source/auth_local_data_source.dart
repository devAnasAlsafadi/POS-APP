import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheToken(String token);
  String? getToken();
  Future<void> clearCache();
  Future<void> cacheUser(String name);
  String? getUserName();

  Future<void> cacheUserData(UserModel user);
  UserModel? getUserData();


}





class AuthLocalDataSourceImpl implements AuthLocalDataSource {

  final SharedPreferences sharedPreferences;
  AuthLocalDataSourceImpl({required this.sharedPreferences});
  static const String _cachedUser = "CACHED_USER_DATA";
  static const String _cachedToken = "CACHED_TOKEN";
  static const String _cachedName = "CACHED_USER_NAME";


  @override
  Future<void> cacheToken(String token
      )async {
    await sharedPreferences.setString(_cachedToken, token);
  }

  @override
  String? getToken() {
    return sharedPreferences.getString(_cachedToken);
  }


  @override
  Future<void> cacheUserData(UserModel user) async {
    String userJson = jsonEncode(user.toJson());
    await sharedPreferences.setString(_cachedUser, userJson);
  }

  @override
  UserModel? getUserData() {
    final jsonString = sharedPreferences.getString(_cachedUser);
    if (jsonString != null) {
      return UserModel.fromJson(jsonDecode(jsonString));
    }
    return null;
  }

  @override
  Future<void> clearCache() async {
    await sharedPreferences.remove(_cachedToken);
    await sharedPreferences.remove(_cachedName);
    await sharedPreferences.remove(_cachedUser);
  }

  @override
  Future<void> cacheUser(String name) async {
    await sharedPreferences.setString(_cachedName, name);
  }

  @override
  String? getUserName() {
    return sharedPreferences.getString(_cachedName);
  }
}
