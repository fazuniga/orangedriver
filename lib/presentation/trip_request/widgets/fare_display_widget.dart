import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class FareDisplayWidget extends StatelessWidget {
  final Map<String, dynamic> fareData;

  const FareDisplayWidget({super.key, required this.fareData});

  @override
  Widget build(BuildContext context) {
    final double baseFare = fareData['base']?.toDouble() ?? 0.0;
    final double surgeMultiplier = fareData['surge']?.toDouble() ?? 1.0;
    final double totalFare = fareData['total']?.toDouble() ?? 0.0;
    final String currency = fareData['currency'] ?? '\$';
    final bool hasSurge = surgeMultiplier > 1.0;

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryOrange.withValues(alpha: 0.1),
            AppTheme.secondaryOrange.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.primaryOrange.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Trip Fare',
                    style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                      color: AppTheme.neutralMedium,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '$currency${totalFare.toStringAsFixed(2)}',
                        style: AppTheme.lightTheme.textTheme.headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppTheme.primaryOrange,
                            ),
                      ),
                      if (hasSurge) ...[
                        SizedBox(width: 2.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 2.w,
                            vertical: 0.5.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.warningAmber,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '${surgeMultiplier}x',
                            style: AppTheme.lightTheme.textTheme.labelSmall
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),

              // Earnings indicator
              Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: AppTheme.successGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomIconWidget(
                      iconName: 'trending_up',
                      color: AppTheme.successGreen,
                      size: 24,
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      'Good Fare',
                      style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                        color: AppTheme.successGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          if (hasSurge) ...[
            SizedBox(height: 2.h),
            Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: AppTheme.warningAmber.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppTheme.warningAmber.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'local_fire_department',
                    color: AppTheme.warningAmber,
                    size: 20,
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Surge Pricing Active',
                          style: AppTheme.lightTheme.textTheme.labelMedium
                              ?.copyWith(
                                color: AppTheme.warningAmber,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        Text(
                          'High demand in this area - ${surgeMultiplier}x multiplier',
                          style: AppTheme.lightTheme.textTheme.bodySmall
                              ?.copyWith(color: AppTheme.neutralMedium),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],

          SizedBox(height: 2.h),

          // Fare breakdown
          _buildFareBreakdown(baseFare, surgeMultiplier, totalFare, currency),
        ],
      ),
    );
  }

  Widget _buildFareBreakdown(
    double baseFare,
    double surgeMultiplier,
    double totalFare,
    String currency,
  ) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildFareRow(
            'Base Fare',
            '$currency${baseFare.toStringAsFixed(2)}',
            false,
          ),
          if (surgeMultiplier > 1.0) ...[
            SizedBox(height: 1.h),
            _buildFareRow(
              'Surge (${surgeMultiplier}x)',
              '+$currency${(totalFare - baseFare).toStringAsFixed(2)}',
              false,
            ),
          ],
          SizedBox(height: 1.h),
          Divider(color: AppTheme.neutralLight, thickness: 1),
          SizedBox(height: 1.h),
          _buildFareRow(
            'Your Earnings',
            '$currency${(totalFare * 0.8).toStringAsFixed(2)}',
            true,
          ),
        ],
      ),
    );
  }

  Widget _buildFareRow(String label, String amount, bool isTotal) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
            color: isTotal ? AppTheme.successGreen : AppTheme.neutralMedium,
          ),
        ),
        Text(
          amount,
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: isTotal ? AppTheme.successGreen : AppTheme.neutralDark,
          ),
        ),
      ],
    );
  }
}
