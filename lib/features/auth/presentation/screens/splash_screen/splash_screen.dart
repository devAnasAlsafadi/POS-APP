import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:pos_wiz_tech/core/utils/app_assets.dart';
import 'package:pos_wiz_tech/features/auth/presentation/screens/splash_screen/splash_screen_controller.dart';
import 'package:pos_wiz_tech/features/auth/presentation/screens/splash_screen/widgets/splash_card.dart';

import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_text_style.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final _controller = SplashScreenController();
  late AnimationController _animController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;
  void _setupAnimations() {
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeIn));

    _animController.forward();
  }

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _controller.init(context);
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth > 600;
          final logoWidth = isTablet
              ? constraints.maxWidth * 0.35
              : constraints.maxWidth * 0.7;
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppAssets.logo, height: 200),
                  FadeTransition(
                    opacity: _opacityAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: SplashCard(width: logoWidth),
                    ),
                  ),
                  const SizedBox(height: 50),
                  _buildLoadingArea(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoadingArea() {
    return Column(
      children: [
        const SizedBox(
          width: 50,
          child: LoadingIndicator(
            indicatorType: Indicator.ballPulseSync,
            colors: [AppColors.primary],
            strokeWidth: 2,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "LOADING...",
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textSecondary,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
