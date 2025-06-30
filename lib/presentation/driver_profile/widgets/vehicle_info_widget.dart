import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../localization/app_localizations.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';
import '../../../widgets/custom_image_widget.dart';

class VehicleInfoWidget extends StatelessWidget {
  final Map<String, dynamic> vehicleData;
  final VoidCallback onEdit;

  const VehicleInfoWidget({
    super.key,
    required this.vehicleData,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.get('vehicle_details'),
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: onEdit,
                  icon: CustomIconWidget(
                    iconName: 'edit',
                    color: AppTheme.primaryOrange,
                    size: 24,
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),

            // Vehicle Image
            Container(
              width: double.infinity,
              height: 20.h,
              decoration: BoxDecoration(
                color: AppTheme.neutralLight,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.neutralMedium.withValues(alpha: 0.3),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CustomImageWidget(
                  imageUrl:
                      vehicleData['photo'] ??
                      'https://images.unsplash.com/photo-1549924231-f129b911e442?w=800',
                  width: double.infinity,
                  height: 20.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 3.h),

            // Vehicle Details Grid
            _buildInfoRow(
              context,
              AppLocalizations.get('vehicle_make'),
              vehicleData['make'] ?? 'Toyota',
              'directions_car',
            ),
            SizedBox(height: 2.h),
            _buildInfoRow(
              context,
              AppLocalizations.get('vehicle_model'),
              vehicleData['model'] ?? 'Corolla',
              'info',
            ),
            SizedBox(height: 2.h),
            _buildInfoRow(
              context,
              AppLocalizations.get('vehicle_year'),
              vehicleData['year']?.toString() ?? '2020',
              'calendar_today',
            ),
            SizedBox(height: 2.h),
            _buildInfoRow(
              context,
              AppLocalizations.get('plate_number'),
              vehicleData['plateNumber'] ?? 'ABC-123',
              'confirmation_number',
            ),
            SizedBox(height: 2.h),
            _buildInfoRow(
              context,
              'Color',
              vehicleData['color'] ?? 'Blanco',
              'palette',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value,
    String iconName,
  ) {
    return Row(
      children: [
        Container(
          width: 10.w,
          height: 10.w,
          decoration: BoxDecoration(
            color: AppTheme.primaryOrange.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: CustomIconWidget(
              iconName: iconName,
              color: AppTheme.primaryOrange,
              size: 20,
            ),
          ),
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppTheme.neutralMedium),
              ),
              SizedBox(height: 0.5.h),
              Text(
                value,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
