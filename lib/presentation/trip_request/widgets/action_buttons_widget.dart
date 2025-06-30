import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class ActionButtonsWidget extends StatelessWidget {
  final bool canInteract;
  final bool isAcceptLoading;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  const ActionButtonsWidget({
    super.key,
    required this.canInteract,
    required this.isAcceptLoading,
    required this.onAccept,
    required this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(18),
          bottomRight: Radius.circular(18),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!canInteract)
              Container(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIconWidget(
                      iconName: 'info_outline',
                      color: AppTheme.neutralMedium,
                      size: 16,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Please wait to prevent accidental touches...',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.neutralMedium,
                      ),
                    ),
                  ],
                ),
              ),

            SizedBox(height: 2.h),

            Row(
              children: [
                // Decline button
                Expanded(flex: 2, child: _buildDeclineButton()),

                SizedBox(width: 4.w),

                // Accept button
                Expanded(flex: 3, child: _buildAcceptButton()),
              ],
            ),

            SizedBox(height: 1.h),

            // Quick action tips
            Text(
              'Swipe right to accept • Swipe left to decline',
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.neutralMedium,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeclineButton() {
    return GestureDetector(
      onTap: canInteract ? onDecline : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 7.h,
        decoration: BoxDecoration(
          color:
              canInteract
                  ? AppTheme.neutralMedium.withValues(alpha: 0.1)
                  : AppTheme.neutralLight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: canInteract ? AppTheme.neutralMedium : AppTheme.neutralLight,
            width: 1.5,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomIconWidget(
                iconName: 'close',
                color:
                    canInteract
                        ? AppTheme.neutralMedium
                        : AppTheme.textDisabledLight,
                size: 20,
              ),
              SizedBox(width: 2.w),
              Text(
                'Decline',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color:
                      canInteract
                          ? AppTheme.neutralMedium
                          : AppTheme.textDisabledLight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAcceptButton() {
    return GestureDetector(
      onTap: canInteract && !isAcceptLoading ? onAccept : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 7.h,
        decoration: BoxDecoration(
          gradient:
              canInteract
                  ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppTheme.primaryOrange, AppTheme.secondaryOrange],
                  )
                  : null,
          color: !canInteract ? AppTheme.neutralLight : null,
          borderRadius: BorderRadius.circular(12),
          boxShadow:
              canInteract
                  ? [
                    BoxShadow(
                      color: AppTheme.primaryOrange.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                  : null,
        ),
        child: Center(
          child:
              isAcceptLoading
                  ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                  : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconWidget(
                        iconName: 'check',
                        color:
                            canInteract
                                ? Colors.white
                                : AppTheme.textDisabledLight,
                        size: 20,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'Accept Trip',
                        style: AppTheme.lightTheme.textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w700,
                              color:
                                  canInteract
                                      ? Colors.white
                                      : AppTheme.textDisabledLight,
                            ),
                      ),
                    ],
                  ),
        ),
      ),
    );
  }
}
