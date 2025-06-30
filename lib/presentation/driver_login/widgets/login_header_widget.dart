import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppTheme.primaryOrange, AppTheme.secondaryOrange],
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 6.h),

          // App Logo
          Container(
            width: 20.w,
            height: 20.w,
            decoration: BoxDecoration(
              color: AppTheme.surfaceWhite,
              borderRadius: BorderRadius.circular(4.w),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: 'local_taxi',
                color: AppTheme.primaryOrange,
                size: 8.w,
              ),
            ),
          ),

          SizedBox(height: 3.h),

          // App Name
          Text(
            'OrangeDriver',
            style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
              color: AppTheme.surfaceWhite,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 1.h),

          // Login Title
          Text(
            'Driver Login',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              color: AppTheme.surfaceWhite.withValues(alpha: 0.9),
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(height: 4.h),
        ],
      ),
    );
  }
}
