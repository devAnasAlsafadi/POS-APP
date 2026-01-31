import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../core/theme/app_text_style.dart';
import '../../../../../../core/utils/app_assets.dart';

class AuthBranding extends StatelessWidget {
  const AuthBranding({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AppAssets.logo, width: 200),
          SvgPicture.asset(AppAssets.fineDine, width: 250),
          const SizedBox(height: 5),
          Text("Professional Waiter POS", style: AppTextStyles.caption),
        ],
      ),
    );
  }
}