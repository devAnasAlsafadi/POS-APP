import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pos_wiz_tech/core/utils/app_assets.dart';
import 'package:pos_wiz_tech/features/floor_map/presentation/screens/alerts_screen/alerts_screen.dart';
import 'package:pos_wiz_tech/features/floor_map/presentation/screens/floor_map_screen/floor_map_screen.dart';
import 'package:pos_wiz_tech/features/floor_map/presentation/screens/main_screen/main_screen_controller.dart';
import 'package:pos_wiz_tech/features/floor_map/presentation/screens/main_screen/widgets/main_bottom_nav.dart';
import 'package:pos_wiz_tech/features/floor_map/presentation/screens/main_screen/widgets/main_mobile_app_bar.dart';
import 'package:pos_wiz_tech/features/floor_map/presentation/screens/main_screen/widgets/main_side_bar.dart';
import 'package:pos_wiz_tech/features/floor_map/presentation/screens/main_screen/widgets/side_bar_item_widget.dart';
import 'package:pos_wiz_tech/features/floor_map/presentation/screens/orders_screen/orders_screen.dart';
import 'package:pos_wiz_tech/features/floor_map/presentation/screens/settings_screen/settings_screen.dart';

import '../../../../../core/theme/app_color.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final MainScreenController _controller = MainScreenController();

  @override
  void initState() {
    super.initState();
    _controller.onUpdate = () => setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        bool isTablet = constraints.maxWidth > 800;
        return Row(
          children: [
            if (isTablet) MainSideBar(controller: _controller, onUpdate: () => setState(() {}),),
            Expanded(
              child: Scaffold(
               appBar: !isTablet ? MainMobileAppBar(onAlertsTap: () => setState(()=> _controller.selectedIndex = 2),) : null,
                body: IndexedStack(
                  index: _controller.selectedIndex,
                  children: _controller.screens,
                ),
                bottomNavigationBar: !isTablet ? MainBottomNav(currentIndex: _controller.currentMobileIndex, onTap: (index) => _controller.onMobileTap(index, () => setState(() {})) ,) : null,
              )
            ),
          ],
        );
      },),
    );
  }





}
