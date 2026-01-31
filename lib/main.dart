import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'core/di/injection_container.dart';
import 'core/utils/app_assets.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await init();

  runApp(EasyLocalization(
    supportedLocales: const [Locale('en'), Locale("ar")],
    fallbackLocale: const Locale('en'),
    path: AppAssets.translations,
    child: const PosApp(),
  ));
}


