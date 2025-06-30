import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class EarningsSummaryWidget extends StatelessWidget {
  final Map<String, dynamic> todayEarnings;

  const EarningsSummaryWidget({super.key, required this.todayEarnings});

  void _showEarningsBreakdown(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            height: 50.h,
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.cardColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            padding: EdgeInsets.all(6.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle bar
                Center(
                  child: Container(
                    width: 12.w,
                    height: 0.5.h,
                    decoration: BoxDecoration(
                      color: AppTheme.neutralMedium,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  'Today\'s Earnings Breakdown',
                  style: AppTheme.lightTheme.textTheme.titleLarge,
                ),
                SizedBox(height: 3.h),
                _buildBreakdownItem('Base Fare', '\$89.20'),
                _buildBreakdownItem('Distance Bonus', '\$23.40'),
                _buildBreakdownItem('Time Bonus', '\$12.60'),
                _buildBreakdownItem('Tips', '\$8.30'),
                _buildBreakdownItem('Surge Pricing', '\$4.00'),
                Divider(height: 3.h),
                _buildBreakdownItem(
                  'Total Earnings',
                  todayEarnings["amount"] as String,
                  isTotal: true,
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildBreakdownItem(
    String label,
    String amount, {
    bool isTotal = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
              color: isTotal ? AppTheme.primaryOrange : null,
            ),
          ),
          Text(
            amount,
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: isTotal ? AppTheme.primaryOrange : AppTheme.successGreen,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => _showEarningsBreakdown(context),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(5.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.primaryOrange, AppTheme.secondaryOrange],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryOrange.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Today\'s Earnings',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.onPrimaryLight,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CustomIconWidget(
                  iconName: 'info_outline',
                  color: AppTheme.onPrimaryLight.withValues(alpha: 0.8),
                  size: 20,
                ),
              ],
            ),
            SizedBox(height: 2.h),

            // Main Earnings Amount
            Text(
              todayEarnings["amount"] as String,
              style: AppTheme.lightTheme.textTheme.displaySmall?.copyWith(
                color: AppTheme.onPrimaryLight,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 3.h),

            // Stats Row
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    icon: 'directions_car',
                    label: 'Trips',
                    value: '${todayEarnings["tripsCompleted"]}',
                  ),
                ),
                Container(
                  width: 1,
                  height: 6.h,
                  color: AppTheme.onPrimaryLight.withValues(alpha: 0.3),
                ),
                Expanded(
                  child: _buildStatItem(
                    icon: 'access_time',
                    label: 'Online',
                    value: todayEarnings["hoursOnline"] as String,
                  ),
                ),
                Container(
                  width: 1,
                  height: 6.h,
                  color: AppTheme.onPrimaryLight.withValues(alpha: 0.3),
                ),
                Expanded(
                  child: _buildStatItem(
                    icon: 'trending_up',
                    label: 'Per Hour',
                    value: '\$${(127.50 / 6.5).toStringAsFixed(0)}',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required String icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        CustomIconWidget(
          iconName: icon,
          color: AppTheme.onPrimaryLight.withValues(alpha: 0.9),
          size: 24,
        ),
        SizedBox(height: 1.h),
        Text(
          value,
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            color: AppTheme.onPrimaryLight,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          label,
          style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
            color: AppTheme.onPrimaryLight.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }
}
