import 'package:flutter/material.dart';

import '../theme/app_text_style.dart';

class OfflineScreen extends StatelessWidget {
  const OfflineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black.withOpacity(0.8), // تعتيم خلف الشاشة
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off_rounded, size: 80, color: Colors.white),
            const SizedBox(height: 20),
            Text("لا يوجد اتصال بالشبكة", style: AppTextStyles.h2.copyWith(color: Colors.white)),
            const SizedBox(height: 10),
            Text("يرجى التحقق من اتصال الجهاز بالراوتر أو السيرفر",
                style: AppTextStyles.body.copyWith(color: Colors.grey[300])),
          ],
        ),
      ),
    );
  }
}