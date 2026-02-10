
import 'package:flutter/material.dart';
import 'package:pos_wiz_tech/core/routes/navigation_manager.dart';
import 'package:pos_wiz_tech/core/routes/route_name.dart';

import '../../../../../core/di/injection_container.dart';
import '../../../data/data_source/auth_local_data_source.dart';

class SplashScreenController {
  Future<void> init(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 4));
    final localDataSource = sl<AuthLocalDataSource>();
    final token = localDataSource.getToken();

    if (context.mounted) {
      if (token != null && token.isNotEmpty) {
        NavigationManger.navigateAndReplace(context, RouteNames.mainScreen);
      } else {
        NavigationManger.navigateAndReplace(context, RouteNames.loginScreen);
      }
    }

  }
}