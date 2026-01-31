import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../core/theme/app_color.dart';
import '../../../../../../core/theme/app_text_style.dart';
import '../../../../../../core/utils/app_assets.dart';

class SplashCard extends StatelessWidget {
  final double width;

  const SplashCard({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.2),
            blurRadius: 50,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          SvgPicture.asset(AppAssets.fineDine),
          Text("POS", style: AppTextStyles.h2.copyWith(color: AppColors.primary)),
          const SizedBox(height: 20),
          Text("Restaurant Management System",
              style: AppTextStyles.caption.copyWith(color: AppColors.grey)),
        ],
      ),
    );
  }
}