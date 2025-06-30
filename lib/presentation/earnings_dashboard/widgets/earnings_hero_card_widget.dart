import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class EarningsHeroCardWidget extends StatelessWidget {
  final double currentEarnings;
  final double percentageChange;
  final String period;
  final bool isRefreshing;

  const EarningsHeroCardWidget({
    super.key,
    required this.currentEarnings,
    required this.percentageChange,
    required this.period,
    this.isRefreshing = false,
  });

  @override
  Widget build(BuildContext context) {
    final isPositiveChange = percentageChange >= 0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.lightTheme.colorScheme.primary,
            AppTheme.lightTheme.colorScheme.primaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.lightTheme.colorScheme.primary.withValues(
              alpha: 0.3,
            ),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$period Earnings',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              isRefreshing
                  ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppTheme.lightTheme.colorScheme.onPrimary,
                      ),
                    ),
                  )
                  : CustomIconWidget(
                    iconName: 'trending_up',
                    color: AppTheme.lightTheme.colorScheme.onPrimary,
                    size: 24,
                  ),
            ],
          ),
          SizedBox(height: 2.h),
          Text(
            '\$${currentEarnings.toStringAsFixed(2)}',
            style: AppTheme.dataDisplayLarge(isLight: true).copyWith(
              color: AppTheme.lightTheme.colorScheme.onPrimary,
              fontSize: 32.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 1.h),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color:
                      isPositiveChange
                          ? AppTheme.successGreen.withValues(alpha: 0.2)
                          : AppTheme.errorRed.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomIconWidget(
                      iconName:
                          isPositiveChange ? 'arrow_upward' : 'arrow_downward',
                      color:
                          isPositiveChange
                              ? AppTheme.successGreen
                              : AppTheme.errorRed,
                      size: 16,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      '${percentageChange.abs().toStringAsFixed(1)}%',
                      style: AppTheme.lightTheme.textTheme.labelMedium
                          ?.copyWith(
                            color:
                                isPositiveChange
                                    ? AppTheme.successGreen
                                    : AppTheme.errorRed,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 2.w),
              Text(
                'vs last $period',
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onPrimary.withValues(
                    alpha: 0.8,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
