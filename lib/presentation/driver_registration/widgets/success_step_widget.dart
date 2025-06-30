import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class SuccessStepWidget extends StatelessWidget {
  const SuccessStepWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        children: [
          SizedBox(height: 8.h),

          // Success Icon
          Container(
            width: 30.w,
            height: 30.w,
            decoration: BoxDecoration(
              color: AppTheme.successGreen.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: CustomIconWidget(
              iconName: 'check_circle',
              color: AppTheme.successGreen,
              size: 80,
            ),
          ),
          SizedBox(height: 4.h),

          // Success Title
          Text(
            'Registration Complete!',
            style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
              color: AppTheme.successGreen,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 2.h),

          // Success Message
          Text(
            'Thank you for joining OrangeDriver! Your application has been submitted successfully.',
            style: AppTheme.lightTheme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),

          // Status Card
          Card(
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          color: AppTheme.warningAmber.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: CustomIconWidget(
                          iconName: 'hourglass_empty',
                          color: AppTheme.warningAmber,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pending Approval',
                              style: AppTheme.lightTheme.textTheme.titleMedium
                                  ?.copyWith(
                                    color: AppTheme.warningAmber,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Text(
                              'Your application is under review',
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(
                                    color:
                                        AppTheme
                                            .lightTheme
                                            .colorScheme
                                            .onSurfaceVariant,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 3.h),

          // Timeline Card
          Card(
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What happens next?',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  _buildTimelineItem(
                    icon: 'email',
                    title: 'Email Verification',
                    description: 'Check your email and verify your account',
                    status: 'pending',
                    timeframe: 'Within 5 minutes',
                  ),
                  _buildTimelineItem(
                    icon: 'fact_check',
                    title: 'Document Review',
                    description: 'We\'ll review your uploaded documents',
                    status: 'upcoming',
                    timeframe: '1-2 business days',
                  ),
                  _buildTimelineItem(
                    icon: 'security',
                    title: 'Background Check',
                    description: 'Comprehensive background verification',
                    status: 'upcoming',
                    timeframe: '3-5 business days',
                  ),
                  _buildTimelineItem(
                    icon: 'verified',
                    title: 'Account Activation',
                    description: 'Start earning with OrangeDriver',
                    status: 'upcoming',
                    timeframe: '5-7 business days',
                    isLast: true,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 4.h),

          // Contact Information Card
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.primaryContainer
                  .withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.lightTheme.colorScheme.primary.withValues(
                  alpha: 0.2,
                ),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'support_agent',
                      color: AppTheme.lightTheme.colorScheme.primary,
                      size: 24,
                    ),
                    SizedBox(width: 3.w),
                    Text(
                      'Need Help?',
                      style: AppTheme.lightTheme.textTheme.titleMedium
                          ?.copyWith(
                            color: AppTheme.lightTheme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Text(
                  'Our support team is here to help you through the onboarding process.',
                  style: AppTheme.lightTheme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          // Simulate support chat
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Opening support chat...'),
                              backgroundColor:
                                  AppTheme.lightTheme.colorScheme.primary,
                            ),
                          );
                        },
                        icon: CustomIconWidget(
                          iconName: 'chat',
                          color: AppTheme.lightTheme.colorScheme.primary,
                          size: 16,
                        ),
                        label: Text('Chat Support'),
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          // Simulate phone call
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Calling support: +1-800-ORANGE'),
                              backgroundColor:
                                  AppTheme.lightTheme.colorScheme.primary,
                            ),
                          );
                        },
                        icon: CustomIconWidget(
                          iconName: 'phone',
                          color: AppTheme.lightTheme.colorScheme.primary,
                          size: 16,
                        ),
                        label: Text('Call Us'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 4.h),

          // Action Buttons
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/driver-login',
                      (route) => false,
                    );
                  },
                  icon: CustomIconWidget(
                    iconName: 'login',
                    color: AppTheme.lightTheme.colorScheme.onPrimary,
                    size: 20,
                  ),
                  label: Text('Go to Login'),
                  style: AppTheme.lightTheme.elevatedButtonTheme.style
                      ?.copyWith(
                        minimumSize: WidgetStateProperty.all(
                          Size(double.infinity, 6.h),
                        ),
                      ),
                ),
              ),
              SizedBox(height: 2.h),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/splash-screen',
                      (route) => false,
                    );
                  },
                  icon: CustomIconWidget(
                    iconName: 'home',
                    color: AppTheme.lightTheme.colorScheme.primary,
                    size: 20,
                  ),
                  label: Text('Back to Home'),
                  style: AppTheme.lightTheme.outlinedButtonTheme.style
                      ?.copyWith(
                        minimumSize: WidgetStateProperty.all(
                          Size(double.infinity, 6.h),
                        ),
                      ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required String icon,
    required String title,
    required String description,
    required String status,
    required String timeframe,
    bool isLast = false,
  }) {
    Color statusColor;
    switch (status) {
      case 'completed':
        statusColor = AppTheme.successGreen;
        break;
      case 'pending':
        statusColor = AppTheme.warningAmber;
        break;
      case 'upcoming':
      default:
        statusColor = Colors.grey;
        break;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 8.w,
              height: 8.w,
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
                border: Border.all(color: statusColor, width: 2),
              ),
              child: CustomIconWidget(
                iconName: icon,
                color: statusColor,
                size: 16,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 6.h,
                color: statusColor.withValues(alpha: 0.3),
              ),
          ],
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                description,
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                timeframe,
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: statusColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (!isLast) SizedBox(height: 2.h),
            ],
          ),
        ),
      ],
    );
  }
}
