import 'package:flutter/material.dart';
import 'package:pos_wiz_tech/core/theme/app_color.dart';
import 'package:pos_wiz_tech/core/theme/app_text_style.dart';

class KitchenNotesSection extends StatelessWidget {
  const KitchenNotesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.description_outlined, color: AppColors.primary, size: 18),
              const SizedBox(width: 8),
              Text("KITCHEN NOTES", style: AppTextStyles.caption.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border),
            ),
            child: TextField(
              style: AppTextStyles.bodySecondary.copyWith(color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: "Special instructions...",
                hintStyle: AppTextStyles.bodySecondary.copyWith(color: AppColors.textMuted),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
              maxLines: 2,
              minLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
