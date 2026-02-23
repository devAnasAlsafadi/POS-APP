import 'package:flutter/material.dart';
import 'package:pos_wiz_tech/core/theme/app_color.dart';
import 'package:pos_wiz_tech/core/theme/app_text_style.dart';

class CartHeader extends StatelessWidget {
  final String tableNumber;
  final VoidCallback? onClear;

  const CartHeader({super.key, required this.tableNumber, this.onClear});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text("Order Summary", style: AppTextStyles.h2),
              const SizedBox(width: 8),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              "Table $tableNumber",
              style: AppTextStyles.body.copyWith(
                color: AppColors.black, // Dark text on primary color for contrast
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
