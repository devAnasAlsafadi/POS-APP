import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../core/theme/app_color.dart';
import '../../../../../../core/theme/app_text_style.dart';

class OrderSuccessDialog extends StatelessWidget {
  final String title;
  final String message;

  const OrderSuccessDialog({
    super.key,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(24),
        constraints: const BoxConstraints(maxWidth: 400),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.success, width: 2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle_outline, color: AppColors.success, size: 80)
                .animate()
                .scale(duration: 400.ms, curve: Curves.easeOutBack),
            const SizedBox(height: 16),
            Text(
              title,
              style: AppTextStyles.h1.copyWith(color: AppColors.white),
            ).animate().fade().slideY(begin: 0.5, end: 0),
            const SizedBox(height: 8),
            Text(
              message,
              style: const TextStyle(color: AppColors.grey),
              textAlign: TextAlign.center,
            ).animate().fade(delay: 200.ms),
          ],
        ),
      ),
    );
  }
}