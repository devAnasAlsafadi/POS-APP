import 'package:flutter/material.dart';
import 'package:pos_wiz_tech/core/theme/app_color.dart';
import 'package:pos_wiz_tech/core/theme/app_text_style.dart';
import 'package:pos_wiz_tech/features/orders/domain/entities/order_product_entity.dart';

class OrderHistoryCard extends StatelessWidget {
  final List<OrderProductEntity> items;
  final double subtotal;

  const OrderHistoryCard({super.key, required this.items, required this.subtotal});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardLight, // Slightly lighter than background
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.check_circle_outline, color: AppColors.success, size: 16),
              const SizedBox(width: 6),
              Text("SERVED", style: AppTextStyles.caption.copyWith(color: AppColors.success, fontWeight: FontWeight.bold)),
              const Spacer(),
              Text("Prep: 15 min", style: AppTextStyles.caption.copyWith(fontSize: 10)),
            ],
          ),
          const SizedBox(height: 12),
          ...items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${item.count}x ${item.nameEn}", style: AppTextStyles.bodySecondary),
                // Optional: Show price per line or just plain list
                 // Text("\$${(item.finalPrice * item.count).toStringAsFixed(2)}", style: AppTextStyles.bodySecondary),
              ],
            ),
          )),
          const Divider(color: AppColors.border, height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Subtotal:", style: AppTextStyles.bodySecondary.copyWith(color: AppColors.textMuted)),
              Text("\$${subtotal.toStringAsFixed(2)}", style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}
