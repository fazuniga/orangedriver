import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class QuickStatsWidget extends StatelessWidget {
  final Map<String, dynamic> weeklyStats;

  const QuickStatsWidget({super.key, required this.weeklyStats});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Weekly Overview',
          style: AppTheme.lightTheme.textTheme.titleLarge,
        ),
        SizedBox(height: 2.h),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: 'account_balance_wallet',
                title: 'Weekly Earnings',
                value: weeklyStats["weeklyEarnings"] as String,
                color: AppTheme.successGreen,
                context: context,
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: _buildStatCard(
                icon: 'star',
                title: 'Rating',
                value: weeklyStats["rating"] as String,
                color: AppTheme.warningAmber,
                context: context,
              ),
            ),
          ],
        ),
        SizedBox(height: 3.w),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: 'check_circle',
                title: 'Acceptance Rate',
                value: weeklyStats["acceptanceRate"] as String,
                color: AppTheme.accentBlue,
                context: context,
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: _buildStatCard(
                icon: 'local_fire_department',
                title: 'Streak',
                value: '12 days',
                color: AppTheme.primaryOrange,
                context: context,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String icon,
    required String title,
    required String value,
    required Color color,
    required BuildContext context,
  }) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon and Title Row
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomIconWidget(iconName: icon, color: color, size: 20),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: Text(
                  title,
                  style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                    color: AppTheme.neutralMedium,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),

          // Value
          Text(
            value,
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Progress indicator for rating
          if (title == 'Rating') ...[
            SizedBox(height: 1.h),
            LinearProgressIndicator(
              value: (double.parse(value) / 5.0),
              backgroundColor: color.withValues(alpha: 0.2),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ],

          // Progress indicator for acceptance rate
          if (title == 'Acceptance Rate') ...[
            SizedBox(height: 1.h),
            LinearProgressIndicator(
              value: (int.parse(value.replaceAll('%', '')) / 100.0),
              backgroundColor: color.withValues(alpha: 0.2),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ],
        ],
      ),
    );
  }
}
