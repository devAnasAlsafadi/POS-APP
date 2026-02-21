import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_wiz_tech/core/blocs/connectivity/connectivity_bloc.dart';
import 'package:pos_wiz_tech/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:pos_wiz_tech/features/floor_map/presentation/blocs/floor_map_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'core/di/injection_container.dart';
import 'core/routes/app_router.dart';
import 'core/routes/route_name.dart';
import 'core/theme/theme.dart';
import 'core/widgets/offline_screen.dart';


class PosApp extends StatefulWidget {
  const PosApp({super.key,});



  @override
  State<PosApp> createState() => _PosAppState();
}

class _PosAppState extends State<PosApp> {
  final AppRouter _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<ConnectivityBloc>(),),
        BlocProvider(create: (context) => sl<FloorMapBloc>(),),
        BlocProvider(create: (context) => sl<AuthBloc>(),)
      ],
      child:MaterialApp(
        title: 'FineDine POS',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        initialRoute: RouteNames.splashScreen,
        onGenerateRoute: _appRouter.onGenerateRoute,
        builder: (context, child) {
          return ResponsiveBreakpoints(
            breakpoints: [
              Breakpoint(start: 0, end: 450, name: MOBILE),
              Breakpoint(start: 451, end: 900, name: TABLET),
              Breakpoint(start: 901, end: 1920, name: DESKTOP),
              Breakpoint(start: 1921, end: double.infinity, name: '4K'),
            ],
            child: BlocBuilder<ConnectivityBloc, ConnectivityState>(builder:(context, state) {
              return Stack(
                children: [
                  child!,
                  // if (state.status == ConnectivityStatus.disconnected)
                  //   const OfflineScreen(),
                ],
              );
             },
            ),
          );
        },
      ),
    );
  }
}

