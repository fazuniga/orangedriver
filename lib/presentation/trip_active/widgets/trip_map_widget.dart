import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class TripMapWidget extends StatelessWidget {
  final String pickupAddress;
  final String destinationAddress;
  final bool showGpsWarning;
  final String? warningMessage;

  const TripMapWidget({
    super.key,
    required this.pickupAddress,
    required this.destinationAddress,
    this.showGpsWarning = false,
    this.warningMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Full-screen map placeholder
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.successGreen.withValues(alpha: 0.1),
                AppTheme.accentBlue.withValues(alpha: 0.1),
              ],
            ),
          ),
          child: Stack(
            children: [
              // Map simulation with route overlay
              Center(
                child: Container(
                  width: 80.w,
                  height: 40.h,
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      children: [
                        // Map background
                        Container(
                          color: AppTheme.neutralLight,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.map,
                                  size: 48,
                                  color: AppTheme.neutralMedium,
                                ),
                                SizedBox(height: 1.h),
                                Text(
                                  'Mapa de Navegación',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppTheme.neutralMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Route overlay in orange
                        Positioned(
                          top: 20,
                          left: 20,
                          child: _buildLocationPin(
                            icon: Icons.my_location,
                            color: AppTheme.accentBlue,
                            label: 'Tu ubicación',
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          right: 20,
                          child: _buildLocationPin(
                            icon: Icons.location_on,
                            color: AppTheme.errorRed,
                            label: 'Destino',
                          ),
                        ),
                        // Route line
                        CustomPaint(
                          size: Size(double.infinity, double.infinity),
                          painter: RouteLinePainter(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // GPS warning overlay
        if (showGpsWarning && warningMessage != null)
          Positioned(
            top: 10.h,
            left: 4.w,
            right: 4.w,
            child: Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: AppTheme.warningAmber.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.shadowLight,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: AppTheme.surfaceWhite, size: 24),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: Text(
                      warningMessage!,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppTheme.surfaceWhite,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildLocationPin({
    required IconData icon,
    required Color color,
    required String label,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, color: AppTheme.surfaceWhite, size: 20),
        ),
        SizedBox(height: 4),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppTheme.surfaceWhite,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: AppTheme.shadowLight,
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 10.sp,
              color: AppTheme.neutralDark,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class RouteLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = AppTheme.primaryOrange
          ..strokeWidth = 4
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(30, 40);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.3,
      size.width - 30,
      size.height - 40,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
