import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../localization/app_localizations.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_image_widget.dart';

// lib/presentation/splash_screen/widgets/splash_logo_widget.dart

class SplashLogoWidget extends StatelessWidget {
  final Animation<double> scaleAnimation;

  const SplashLogoWidget({super.key, required this.scaleAnimation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: scaleAnimation.value,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLogoContainer(),
              SizedBox(height: 3.h),
              _buildAppName(),
              SizedBox(height: 1.h),
              _buildTagline(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLogoContainer() {
    return Container(
      width: 25.w,
      height: 25.w,
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: CustomImageWidget(
          imageUrl: 'assets/images/no-image.jpg',
          width: 25.w,
          height: 25.w,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildAppName() {
    return Text(
      AppLocalizations.get('app_title'),
      style: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w700,
        color: AppTheme.surfaceWhite,
        letterSpacing: 1.2,
        shadows: [
          Shadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }

  Widget _buildTagline() {
    return Text(
      AppLocalizations.get('app_tagline'),
      style: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: AppTheme.surfaceWhite.withValues(alpha: 0.9),
        letterSpacing: 0.8,
      ),
    );
  }
}
