import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class EarningsBreakdownWidget extends StatelessWidget {
  final Map<String, dynamic> breakdown;

  const EarningsBreakdownWidget({super.key, required this.breakdown});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Earnings Breakdown',
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2.h),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 3.w,
          mainAxisSpacing: 2.h,
          childAspectRatio: 1.5,
          children: [
            _buildBreakdownCard(
              'Trip Fares',
              breakdown["tripFares"] as double,
              'directions_car',
              AppTheme.lightTheme.colorScheme.primary,
            ),
            _buildBreakdownCard(
              'Tips',
              breakdown["tips"] as double,
              'star',
              AppTheme.successGreen,
            ),
            _buildBreakdownCard(
              'Bonuses',
              breakdown["bonuses"] as double,
              'card_giftcard',
              AppTheme.accentBlue,
            ),
            _buildBreakdownCard(
              'Surge',
              breakdown["surgeEarnings"] as double,
              'flash_on',
              AppTheme.warningAmber,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBreakdownCard(
    String title,
    double amount,
    String iconName,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomIconWidget(
                  iconName: iconName,
                  color: color,
                  size: 20,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '\$${amount.toStringAsFixed(2)}',
                style: AppTheme.dataDisplayMedium(
                  isLight: true,
                ).copyWith(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 0.5.h),
              Text(
                title,
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
