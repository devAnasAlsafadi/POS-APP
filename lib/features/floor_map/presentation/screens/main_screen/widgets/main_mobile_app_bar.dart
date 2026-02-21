import 'package:flutter/material.dart';
import 'package:pos_wiz_tech/core/di/injection_container.dart';
import 'package:pos_wiz_tech/features/auth/domain/repositories/auth_repository.dart';

import '../../../../../../core/theme/app_color.dart';
import '../../../../../../core/theme/app_text_style.dart';

class MainMobileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onAlertsTap;
  const MainMobileAppBar({super.key, required this.onAlertsTap});

  @override
  Widget build(BuildContext context) {
    final waiterName = sl<AuthRepository>().getUserName() ?? "Waiter";

    return AppBar(
      backgroundColor:AppColors.background,
      elevation: 0,
      title: Row(
        children: [
          const CircleAvatar(
              backgroundColor: AppColors.primary,
              child: Icon(Icons.person, color: Colors.white)),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(waiterName,
                  style: AppTextStyles.appBarTitle),
              Text("FineDine POS",
                  style: AppTextStyles.appBarSubtitle),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: onAlertsTap,
          icon: const Badge(
            label: Text("3"),
            child: Icon(Icons.notifications_none_rounded, color: Colors.white),
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }


  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}