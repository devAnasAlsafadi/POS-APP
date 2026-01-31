import 'package:flutter/material.dart';
import 'package:pos_wiz_tech/core/routes/navigation_manager.dart';
import 'package:pos_wiz_tech/core/routes/route_name.dart';
import '../../../../../../core/enum/snakebar_tybe.dart';
import '../../../../../../core/theme/app_color.dart';
import '../../../../../../core/theme/app_text_style.dart';
import '../../../../../../core/utils/app_snackbar.dart';
import '../../../../../../core/utils/validators.dart';
import '../../../../../../core/widgets/my_button.dart';
import '../../../../../../core/widgets/my_text_field.dart';
import '../login_screen_controller.dart';

class LoginForm extends StatefulWidget {
  final LoginScreenController controller;
  const LoginForm({super.key, required this.controller});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Welcome Back", style: AppTextStyles.h2),
          const SizedBox(height: 8),
          Text("Sign in to access your waiter dashboard", style: AppTextStyles.caption),
          const SizedBox(height: 40),

          _buildLabel("EMAIL ADDRESS"),
          MyTextField(
            obscureText: false,
            keyboardType: TextInputType.emailAddress,
            controller: widget.controller.emailController,
            hintText: "waiter@finedine.com",
            prefixIcon: const Icon(Icons.email_outlined, color: AppColors.primary),
            fillColor: AppColors.surface,
            validator: Validators.validateEmail,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),

          const SizedBox(height: 20),

          _buildLabel("PASSWORD"),
          MyTextField(
            obscureText: widget.controller.obscurePassword,
            controller: widget.controller.passwordController,
            hintText: "Enter your password",
            fillColor: AppColors.surface,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            prefixIcon: const Icon(Icons.lock_outline, color: AppColors.primary),
            suffixIcon: IconButton(
              onPressed: () => setState(() => widget.controller.togglePasswordVisibility()),
              icon: Icon(widget.controller.iconPassword),
            ),
            validator: Validators.validatePassword, keyboardType: TextInputType.text,
          ),

          const SizedBox(height: 30),

          CustomButton(
            text: "Sign In",
            icon: Icons.login,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                AppSnackBar.show(
                  type: SnackBarType.success,
                  context,
                  title: "Login Successful",
                  message: "Welcome back waiter!"
                );
                NavigationManger.navigateAndReplace(context, RouteNames.mainScreen);
              }else{
                AppSnackBar.show(
                  type: SnackBarType.error,
                  context,
                  title: "Missing Credentials",
                  message: "Please enter both email and password.",
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(label, style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.bold)),
    );
  }
}