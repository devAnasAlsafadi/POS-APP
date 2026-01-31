import 'package:flutter/material.dart';
import 'widgets/auth_branding.dart';
import 'widgets/login_form.dart';
import 'login_screen_controller.dart';
import '../../../../../core/theme/app_color.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final LoginScreenController _controller;

  @override
  void initState() {
    super.initState();
    _controller = LoginScreenController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isTablet = constraints.maxWidth > 800;
          return isTablet ? _buildTabletView() : _buildMobileView();
        },
      ),
    );
  }


  Widget _buildTabletView() {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: Colors.black.withValues(alpha: 0.05),
            child: const Center(child: AuthBranding()),
          ),
        ),
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: LoginForm(controller: _controller),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileView() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const AuthBranding(),
            const SizedBox(height: 50),
            LoginForm(controller: _controller),
          ],
        ),
      ),
    );
  }
}