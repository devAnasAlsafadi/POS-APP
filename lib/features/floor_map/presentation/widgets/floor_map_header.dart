import 'package:flutter/material.dart';

import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_style.dart';

class FloorMapHeader extends StatelessWidget {
  const FloorMapHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Floor Map", style: AppTextStyles.h3.copyWith(fontSize: 28,color: AppColors.white)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[800]!),
              ),
              child: Row(
                children: [
                  const Text("All Tables", style: TextStyle(color: Colors.white)),
                  const SizedBox(width: 10),
                  Icon(Icons.keyboard_arrow_down, color: Colors.orange[400]),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            _buildStatusIndicator("Available", Colors.green),
            _buildStatusIndicator("Waiting", Colors.yellow),
            _buildStatusIndicator("Dining", Colors.red),
            _buildStatusIndicator("Billing", Colors.orange),
            _buildStatusIndicator("Reserved", Colors.blue),
          ],
        ),
        const Divider(color: Colors.grey, height: 40, thickness: 0.2),
      ],
    );
  }

  Widget _buildStatusIndicator(String label, Color color) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        children: [
          CircleAvatar(radius: 4, backgroundColor: color),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}