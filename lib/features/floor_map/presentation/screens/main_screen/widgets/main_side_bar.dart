import 'package:flutter/material.dart';
import 'package:pos_wiz_tech/features/floor_map/presentation/screens/main_screen/widgets/side_bar_item_widget.dart';
import '../../../../../../core/theme/app_color.dart';
import '../main_screen_controller.dart';

class MainSideBar extends StatelessWidget {
  final MainScreenController controller;
  final VoidCallback onUpdate;

  const MainSideBar({super.key, required this.controller, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      color: AppColors.surface,
      padding: const EdgeInsetsDirectional.only(bottom: 0, start: 15, end: 15,top: 20),
      child: ListView(
        children: [
          CircleAvatar(
            child: Icon(Icons.restaurant_rounded,color: AppColors.white,),),
          const SizedBox(height: 20),
          _item(Icons.grid_view_rounded, 0, "Floor"),
          _item(Icons.receipt_long_rounded, 1, "Orders"),
          _item(Icons.notifications_none_rounded, 2, "Alerts"),
          _item(Icons.settings_outlined, 3, "Settings"),
          const SizedBox(height: 20),
          _item(Icons.logout_rounded, -1, "Logout", isLogout: true),
        ],
      ),
    );
  }

  Widget _item(IconData icon, int index, String label, {bool isLogout = false}) {
    return SideBarItemWidget(
      icon: icon,
      label: label,
      isSelected: controller.selectedIndex == index,
      isLogout: isLogout,
      onTap: () => controller.onSideBarTap(index, onUpdate),
    );
  }
}