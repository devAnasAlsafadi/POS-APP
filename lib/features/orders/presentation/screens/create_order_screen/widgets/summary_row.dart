import 'package:flutter/material.dart';
import 'package:pos_wiz_tech/core/theme/app_color.dart';
import 'package:pos_wiz_tech/core/theme/app_text_style.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const SummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isTotal 
                ? AppTextStyles.h3.copyWith(color: AppColors.textPrimary) 
                : AppTextStyles.bodySecondary,
          ),
          Text(
            value,
            style: isTotal 
                ? AppTextStyles.h2.copyWith(color: AppColors.primary) 
                : AppTextStyles.body.copyWith(color: AppColors.white, fontWeight: FontWeight.bold),
          )
          .animate(key: ValueKey(value))
          .scale(duration: 200.ms, curve: Curves.easeOutBack, alignment: Alignment.centerRight),
        ],
      ),
    );
  }
}