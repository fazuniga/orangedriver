import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class CountdownTimerWidget extends StatelessWidget {
  final int remainingSeconds;
  final AnimationController controller;

  const CountdownTimerWidget({
    super.key,
    required this.remainingSeconds,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.primaryOrange.withValues(alpha: 0.1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
      child: Column(
        children: [
          Text(
            'New Trip Request',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppTheme.primaryOrange,
            ),
          ),
          SizedBox(height: 2.h),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 20.w,
                height: 20.w,
                child: AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) {
                    return CircularProgressIndicator(
                      value: 1.0 - controller.value,
                      strokeWidth: 6,
                      backgroundColor: AppTheme.neutralLight,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        remainingSeconds <= 5
                            ? AppTheme.errorRed
                            : AppTheme.primaryOrange,
                      ),
                    );
                  },
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$remainingSeconds',
                    style: AppTheme.lightTheme.textTheme.headlineMedium
                        ?.copyWith(
                          fontWeight: FontWeight.w700,
                          color:
                              remainingSeconds <= 5
                                  ? AppTheme.errorRed
                                  : AppTheme.primaryOrange,
                        ),
                  ),
                  Text(
                    'seconds',
                    style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                      color: AppTheme.neutralMedium,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Text(
            'Respond quickly to maximize your earnings',
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.neutralMedium,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
