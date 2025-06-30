import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class RecentPayoutsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> payouts;

  const RecentPayoutsWidget({super.key, required this.payouts});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Payouts',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to full payouts history
              },
              child: Text('View All'),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppTheme.lightTheme.colorScheme.outline,
              width: 1,
            ),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: payouts.length > 3 ? 3 : payouts.length,
            separatorBuilder:
                (context, index) => Divider(
                  color: AppTheme.lightTheme.colorScheme.outline,
                  height: 1,
                ),
            itemBuilder: (context, index) {
              final payout = payouts[index];
              return _buildPayoutItem(payout);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPayoutItem(Map<String, dynamic> payout) {
    final date = payout["date"] as String;
    final amount = payout["amount"] as double;
    final status = payout["status"] as String;
    final bankAccount = payout["bankAccount"] as String;

    final isCompleted = status == "Completed";
    final statusColor =
        isCompleted ? AppTheme.successGreen : AppTheme.warningAmber;

    return Padding(
      padding: EdgeInsets.all(4.w),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: CustomIconWidget(
              iconName: isCompleted ? 'check_circle' : 'schedule',
              color: statusColor,
              size: 20,
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${amount.toStringAsFixed(2)}',
                      style: AppTheme.dataDisplayMedium(
                        isLight: true,
                      ).copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 2.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        status,
                        style: AppTheme.lightTheme.textTheme.labelSmall
                            ?.copyWith(
                              color: statusColor,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0.5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      date,
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      bankAccount,
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
