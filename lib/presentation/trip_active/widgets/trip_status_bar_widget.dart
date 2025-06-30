import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../localization/app_localizations.dart';
import '../../../theme/app_theme.dart';

class TripStatusBarWidget extends StatelessWidget {
  final String status;
  final String elapsedTime;
  final String currentFare;
  final double progress;

  const TripStatusBarWidget({
    super.key,
    required this.status,
    required this.elapsedTime,
    required this.currentFare,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_buildStatusInfo(), _buildFareInfo()],
          ),
          SizedBox(height: 1.h),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: AppTheme.neutralLight,
            valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryOrange),
            minHeight: 4,
          ),
        ],
      ),
    );
  }

  Widget _buildStatusInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          status,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppTheme.primaryOrange,
          ),
        ),
        Text(
          '${AppLocalizations.get('elapsed_time')}: $elapsedTime',
          style: TextStyle(fontSize: 12.sp, color: AppTheme.neutralMedium),
        ),
      ],
    );
  }

  Widget _buildFareInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          currentFare,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: AppTheme.neutralDark,
          ),
        ),
        Text(
          AppLocalizations.get('current_fare'),
          style: TextStyle(fontSize: 12.sp, color: AppTheme.neutralMedium),
        ),
      ],
    );
  }
}
