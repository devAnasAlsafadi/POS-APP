import 'package:flutter/material.dart';
import 'package:pos_wiz_tech/core/theme/app_color.dart';
import 'package:pos_wiz_tech/core/theme/app_text_style.dart';

class MenuHeader extends StatelessWidget {
  final String tableNumber;
  final String waiterName;
  // أضفت الـ tableId هنا عشان نستخدمه في الـ Hero Tag
  final int tableId;

  const MenuHeader({
    super.key,
    required this.tableNumber,
    required this.waiterName,
    required this.tableId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text("Table #", style: AppTextStyles.appBarTitle),
              Hero(
                tag: 'table_hero_$tableId',
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    tableNumber,
                    style: AppTextStyles.appBarTitle.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.person_outline, size: 14, color: AppColors.grey),
              const SizedBox(width: 4),
              Text("Waiter: $waiterName", style: AppTextStyles.appBarSubtitle),
            ],
          ),
        ],
      ),
    );
  }
}