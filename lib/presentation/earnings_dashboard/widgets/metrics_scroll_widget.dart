import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class MetricsScrollWidget extends StatelessWidget {
  final Map<String, dynamic> metrics;

  const MetricsScrollWidget({super.key, required this.metrics});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Key Metrics',
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2.h),
        SizedBox(
          height: 15.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildMetricCard(
                'Total Trips',
                '${metrics["totalTrips"]}',
                'local_taxi',
                AppTheme.lightTheme.colorScheme.primary,
              ),
              _buildMetricCard(
                'Average Fare',
                '\$${(metrics["averageFare"] as double).toStringAsFixed(2)}',
                'attach_money',
                AppTheme.successGreen,
              ),
              _buildMetricCard(
                'Hours Online',
                '${(metrics["hoursOnline"] as double).toStringAsFixed(1)}h',
                'schedule',
                AppTheme.accentBlue,
              ),
              _buildMetricCard(
                'Best Day',
                metrics["highestEarningDay"] as String,
                'trending_up',
                AppTheme.warningAmber,
                isWide: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    String title,
    String value,
    String iconName,
    Color color, {
    bool isWide = false,
  }) {
    return Container(
      width: isWide ? 60.w : 40.w,
      margin: EdgeInsets.only(right: 3.w),
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
                value,
                style: AppTheme.dataDisplayMedium(isLight: true).copyWith(
                  fontSize: isWide ? 14.sp : 16.sp,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: isWide ? 2 : 1,
                overflow: TextOverflow.ellipsis,
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
