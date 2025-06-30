import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';
import '../../../widgets/custom_image_widget.dart';

class MapPreviewWidget extends StatelessWidget {
  final Map<String, dynamic> pickupLocation;
  final Map<String, dynamic> destination;

  const MapPreviewWidget({
    super.key,
    required this.pickupLocation,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.primaryOrange.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(11),
        child: Stack(
          children: [
            // Map placeholder with gradient
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppTheme.accentBlue.withValues(alpha: 0.1),
                    AppTheme.primaryOrange.withValues(alpha: 0.1),
                  ],
                ),
              ),
              child: CustomImageWidget(
                imageUrl:
                    'https://images.unsplash.com/photo-1524661135-423995f22d0b?w=800&h=600&fit=crop',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            // Overlay with route information
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.3),
                  ],
                ),
              ),
            ),

            // Pickup pin
            Positioned(
              top: 4.h,
              left: 8.w,
              child: _buildLocationPin(
                icon: 'location_on',
                color: AppTheme.primaryOrange,
                label: 'Pickup',
              ),
            ),

            // Destination pin (if available)
            if (destination['address'] != null)
              Positioned(
                bottom: 4.h,
                right: 8.w,
                child: _buildLocationPin(
                  icon: 'flag',
                  color: AppTheme.successGreen,
                  label: 'Drop-off',
                ),
              ),

            // Route info overlay
            Positioned(
              bottom: 2.h,
              left: 4.w,
              right: 4.w,
              child: Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildRouteInfo(
                      icon: 'directions',
                      label: 'Distance',
                      value: pickupLocation['distance'] ?? '0 km',
                    ),
                    Container(
                      width: 1,
                      height: 4.h,
                      color: AppTheme.neutralLight,
                    ),
                    _buildRouteInfo(
                      icon: 'schedule',
                      label: 'ETA',
                      value: pickupLocation['eta'] ?? '0 min',
                    ),
                  ],
                ),
              ),
            ),

            // Map controls
            Positioned(
              top: 2.h,
              right: 2.w,
              child: Column(
                children: [
                  _buildMapControl(
                    icon: 'my_location',
                    onTap: () {
                      // Center on current location
                    },
                  ),
                  SizedBox(height: 1.h),
                  _buildMapControl(
                    icon: 'fullscreen',
                    onTap: () {
                      // Open full map view
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationPin({
    required String icon,
    required Color color,
    required String label,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: CustomIconWidget(
            iconName: icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        SizedBox(height: 0.5.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            label,
            style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRouteInfo({
    required String icon,
    required String label,
    required String value,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomIconWidget(
          iconName: icon,
          color: AppTheme.primaryOrange,
          size: 20,
        ),
        SizedBox(height: 0.5.h),
        Text(
          label,
          style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
            color: AppTheme.neutralMedium,
          ),
        ),
        Text(
          value,
          style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.neutralDark,
          ),
        ),
      ],
    );
  }

  Widget _buildMapControl({required String icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: CustomIconWidget(
          iconName: icon,
          color: AppTheme.neutralDark,
          size: 18,
        ),
      ),
    );
  }
}
