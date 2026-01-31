
import 'package:flutter/material.dart';
import 'package:pos_wiz_tech/core/routes/route_name.dart';

class SplashScreenController {
  Future<void> init(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 4));

    if (context.mounted) {
      Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
    }
  }
}