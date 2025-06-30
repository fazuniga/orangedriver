import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../localization/app_localizations.dart';
import '../../../theme/app_theme.dart';

class TripStatisticsWidget extends StatelessWidget {
  final int totalTrips;
  final double averageRating;
  final String totalEarnings;
  final Map<String, double> earningsTrends;

  const TripStatisticsWidget({
    super.key,
    required this.totalTrips,
    required this.averageRating,
    required this.totalEarnings,
    required this.earningsTrends,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Resumen del Período',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: AppTheme.neutralDark,
            ),
          ),
          SizedBox(height: 3.h),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  title: AppLocalizations.get('total_trips'),
                  value: totalTrips.toString(),
                  icon: Icons.directions_car,
                  color: AppTheme.primaryOrange,
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: _buildStatCard(
                  title: AppLocalizations.get('average_rating'),
                  value: averageRating.toStringAsFixed(1),
                  icon: Icons.star,
                  color: AppTheme.warningAmber,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          _buildEarningsCard(),
          SizedBox(height: 2.h),
          _buildTrendChart(),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          SizedBox(height: 1.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: AppTheme.neutralDark,
            ),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 10.sp, color: AppTheme.neutralMedium),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildEarningsCard() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.successGreen,
            AppTheme.successGreen.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ganancias Totales',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppTheme.surfaceWhite.withValues(alpha: 0.9),
                    ),
                  ),
                  Text(
                    totalEarnings,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.surfaceWhite,
                    ),
                  ),
                ],
              ),
              Icon(Icons.trending_up, color: AppTheme.surfaceWhite, size: 32),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrendChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.get('earnings_trends'),
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppTheme.neutralDark,
          ),
        ),
        SizedBox(height: 2.h),
        Container(
          height: 20.h,
          decoration: BoxDecoration(
            color: AppTheme.neutralLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppTheme.neutralMedium.withValues(alpha: 0.2),
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.bar_chart, size: 48, color: AppTheme.neutralMedium),
                SizedBox(height: 1.h),
                Text(
                  'Gráfico de Tendencias',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppTheme.neutralMedium,
                  ),
                ),
                Text(
                  '(Próximamente con fl_chart)',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: AppTheme.neutralMedium.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
