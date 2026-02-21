import 'package:flutter/material.dart';
import 'package:pos_wiz_tech/core/theme/app_color.dart';
import 'package:pos_wiz_tech/core/theme/app_text_style.dart';
import 'package:pos_wiz_tech/features/orders/domain/entities/order_product_entity.dart';

class OrderHistoryCard extends StatelessWidget {
  final List<OrderProductEntity> items;

  const OrderHistoryCard({
    super.key,
    required this.items,
  });

  double get subtotal => items.fold(0, (sum, item) => sum + (item.price * item.count));

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:  AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.check, color: Colors.green, size: 14),
                  const SizedBox(width: 2),
                  Text(
                    'SERVED',
                    style: AppTextStyles.smallText.copyWith(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                    ),
                  ),
                ],
              ),
              Text(
                'Prep: 15 min',
                style: AppTextStyles.labelSmall.copyWith(color: AppColors.grey),
              ),
            ],
          ),
          const SizedBox(height: 10),

          ...items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Text(
                  '${item.count}× ',
                  style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.grey,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(width: 5,),
                Expanded(
                  child: Text(
                    item.nameEn,
                    style: AppTextStyles.smallText,
                  ),
                ),
              ],
            ),
          )),

          const Divider(color: Colors.white10, thickness: 1),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subtotal:',
                style: AppTextStyles.labelSmall.copyWith(color: AppColors.grey),
              ),
              Text(
                '\$${subtotal.toStringAsFixed(2)}',
                style: AppTextStyles.caption.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}