import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pos_wiz_tech/core/routes/route_name.dart';
import 'package:pos_wiz_tech/features/auth/presentation/screens/splash_screen/splash_screen.dart';
import 'package:pos_wiz_tech/features/floor_map/presentation/screens/alerts_screen/alerts_screen.dart';
import 'package:pos_wiz_tech/features/floor_map/presentation/screens/floor_map_screen/floor_map_screen.dart';
import 'package:pos_wiz_tech/features/floor_map/presentation/screens/main_screen/main_screen.dart';
import 'package:pos_wiz_tech/features/floor_map/presentation/screens/main_screen/main_screen_controller.dart';
import 'package:pos_wiz_tech/features/floor_map/presentation/screens/orders_screen/orders_screen.dart';
import 'package:pos_wiz_tech/features/floor_map/presentation/screens/settings_screen/settings_screen.dart';
import 'package:pos_wiz_tech/features/orders/presentation/screens/create_order_screen.dart';

import '../../features/auth/presentation/screens/login_screen/login_screen.dart';


class AppRouter {

   Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return MaterialPageRoute(builder: (context) =>SplashScreen());
      case RouteNames.loginScreen:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case RouteNames.mainScreen:
        return MaterialPageRoute(builder: (context) => MainScreen());
      case RouteNames.floorMapScreen:
        final controller = settings.arguments as MainScreenController ;
        return MaterialPageRoute(builder: (context) => FloorMapScreen(mainController: controller,));
      case RouteNames.alertScreen:
        return MaterialPageRoute(builder: (context) => AlertsScreen());
      case RouteNames.settingsScreen:
        return MaterialPageRoute(builder: (context) => SettingsScreen());
      case RouteNames.ordersScreen:
        return MaterialPageRoute(builder: (context) => OrdersScreen());
      case RouteNames.createOrderScreen:
        return MaterialPageRoute(builder: (context) => CreateOrderScreen());

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }



}
