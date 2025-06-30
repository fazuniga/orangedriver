import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class LoginFormWidget extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final bool isPasswordVisible;
  final bool isLoading;
  final String? emailError;
  final String? passwordError;
  final VoidCallback onTogglePasswordVisibility;
  final VoidCallback onLogin;
  final VoidCallback onForgotPassword;
  final VoidCallback onBiometricLogin;

  const LoginFormWidget({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.emailFocusNode,
    required this.passwordFocusNode,
    required this.isPasswordVisible,
    required this.isLoading,
    this.emailError,
    this.passwordError,
    required this.onTogglePasswordVisibility,
    required this.onLogin,
    required this.onForgotPassword,
    required this.onBiometricLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Email Field
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email Address',
              style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                color: AppTheme.neutralDark,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 1.h),
            TextFormField(
              controller: emailController,
              focusNode: emailFocusNode,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              enabled: !isLoading,
              decoration: InputDecoration(
                hintText: 'Enter your email address',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(3.w),
                  child: CustomIconWidget(
                    iconName: 'person',
                    color:
                        emailFocusNode.hasFocus
                            ? AppTheme.primaryOrange
                            : AppTheme.neutralMedium,
                    size: 5.w,
                  ),
                ),
                errorText: null,
              ),
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(passwordFocusNode);
              },
            ),
            if (emailError != null) ...[
              SizedBox(height: 0.5.h),
              Text(
                emailError!,
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.errorRed,
                ),
              ),
            ],
          ],
        ),

        SizedBox(height: 3.h),

        // Password Field
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Password',
              style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                color: AppTheme.neutralDark,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 1.h),
            TextFormField(
              controller: passwordController,
              focusNode: passwordFocusNode,
              obscureText: !isPasswordVisible,
              textInputAction: TextInputAction.done,
              enabled: !isLoading,
              decoration: InputDecoration(
                hintText: 'Enter your password',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(3.w),
                  child: CustomIconWidget(
                    iconName: 'lock',
                    color:
                        passwordFocusNode.hasFocus
                            ? AppTheme.primaryOrange
                            : AppTheme.neutralMedium,
                    size: 5.w,
                  ),
                ),
                suffixIcon: IconButton(
                  onPressed: isLoading ? null : onTogglePasswordVisibility,
                  icon: CustomIconWidget(
                    iconName:
                        isPasswordVisible ? 'visibility_off' : 'visibility',
                    color: AppTheme.neutralMedium,
                    size: 5.w,
                  ),
                ),
                errorText: null,
              ),
              onFieldSubmitted: (_) {
                if (!isLoading) {
                  onLogin();
                }
              },
            ),
            if (passwordError != null) ...[
              SizedBox(height: 0.5.h),
              Text(
                passwordError!,
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.errorRed,
                ),
              ),
            ],
          ],
        ),

        SizedBox(height: 2.h),

        // Forgot Password Link
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: isLoading ? null : onForgotPassword,
            child: Text(
              'Forgot Password?',
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.primaryOrange,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),

        SizedBox(height: 4.h),

        // Login Button
        SizedBox(
          height: 6.h,
          child: ElevatedButton(
            onPressed: isLoading ? null : onLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  isLoading ? AppTheme.neutralMedium : AppTheme.primaryOrange,
              foregroundColor: AppTheme.surfaceWhite,
              elevation: isLoading ? 0 : 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.w),
              ),
            ),
            child:
                isLoading
                    ? SizedBox(
                      width: 5.w,
                      height: 5.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppTheme.surfaceWhite,
                        ),
                      ),
                    )
                    : Text(
                      'Login',
                      style: AppTheme.lightTheme.textTheme.titleMedium
                          ?.copyWith(
                            color: AppTheme.surfaceWhite,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
          ),
        ),

        SizedBox(height: 3.h),

        // Biometric Login Option
        Center(
          child: TextButton.icon(
            onPressed: isLoading ? null : onBiometricLogin,
            icon: CustomIconWidget(
              iconName: 'fingerprint',
              color: AppTheme.primaryOrange,
              size: 5.w,
            ),
            label: Text(
              'Use Biometric Login',
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.primaryOrange,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
