import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../localization/app_localizations.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

// lib/presentation/driver_dashboard/widgets/status_toggle_widget.dart

class StatusToggleWidget extends StatelessWidget {
  final bool isOnline;
  final VoidCallback onToggle;

  const StatusToggleWidget({
    super.key,
    required this.isOnline,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Status Text
          Text(
            isOnline
                ? AppLocalizations.get('you_are_online')
                : AppLocalizations.get('you_are_offline'),
            style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
              color: isOnline ? AppTheme.successGreen : AppTheme.neutralMedium,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            isOnline
                ? AppLocalizations.get('ready_for_trips')
                : AppLocalizations.get('tap_to_start'),
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.neutralMedium,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),

          // Large Toggle Switch
          GestureDetector(
            onTap: onToggle,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 30.w,
              height: 15.h,
              decoration: BoxDecoration(
                color:
                    isOnline ? AppTheme.primaryOrange : AppTheme.neutralLight,
                borderRadius: BorderRadius.circular(75),
                border: Border.all(
                  color:
                      isOnline
                          ? AppTheme.primaryOrange
                          : AppTheme.neutralMedium,
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color:
                        isOnline
                            ? AppTheme.primaryOrange.withValues(alpha: 0.3)
                            : AppTheme.shadowLight,
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  AnimatedAlign(
                    duration: const Duration(milliseconds: 300),
                    alignment:
                        isOnline ? Alignment.topCenter : Alignment.bottomCenter,
                    child: Container(
                      width: 24.w,
                      height: 12.w,
                      margin: EdgeInsets.all(1.5.w),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceWhite,
                        borderRadius: BorderRadius.circular(60),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.shadowLight,
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: CustomIconWidget(
                          iconName:
                              isOnline ? 'power_settings_new' : 'power_off',
                          color:
                              isOnline
                                  ? AppTheme.successGreen
                                  : AppTheme.neutralMedium,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 3.h),

          // Status Description
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            decoration: BoxDecoration(
              color:
                  isOnline
                      ? AppTheme.successGreen.withValues(alpha: 0.1)
                      : AppTheme.neutralMedium.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomIconWidget(
                  iconName:
                      isOnline ? 'check_circle' : 'radio_button_unchecked',
                  color:
                      isOnline ? AppTheme.successGreen : AppTheme.neutralMedium,
                  size: 20,
                ),
                SizedBox(width: 2.w),
                Text(
                  isOnline
                      ? AppLocalizations.get('available_for_trips')
                      : AppLocalizations.get('not_accepting_trips'),
                  style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                    color:
                        isOnline
                            ? AppTheme.successGreen
                            : AppTheme.neutralMedium,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
