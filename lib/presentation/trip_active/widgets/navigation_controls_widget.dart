import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class NavigationControlsWidget extends StatelessWidget {
  final bool isVoiceGuidanceEnabled;
  final VoidCallback onVoiceToggle;
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;
  final VoidCallback onShowAlternatives;
  final VoidCallback onRecenter;

  const NavigationControlsWidget({
    super.key,
    required this.isVoiceGuidanceEnabled,
    required this.onVoiceToggle,
    required this.onZoomIn,
    required this.onZoomOut,
    required this.onShowAlternatives,
    required this.onRecenter,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 4.w,
      top: 25.h,
      child: Column(
        children: [
          _buildControlButton(
            icon: isVoiceGuidanceEnabled ? Icons.volume_up : Icons.volume_off,
            isActive: isVoiceGuidanceEnabled,
            onPressed: onVoiceToggle,
          ),
          SizedBox(height: 2.h),
          _buildControlButton(icon: Icons.add, onPressed: onZoomIn),
          SizedBox(height: 1.h),
          _buildControlButton(icon: Icons.remove, onPressed: onZoomOut),
          SizedBox(height: 2.h),
          _buildControlButton(
            icon: Icons.alt_route,
            onPressed: onShowAlternatives,
          ),
          SizedBox(height: 1.h),
          _buildControlButton(icon: Icons.my_location, onPressed: onRecenter),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onPressed,
    bool isActive = false,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: isActive ? AppTheme.primaryOrange : AppTheme.surfaceWhite,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppTheme.shadowLight,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: isActive ? AppTheme.surfaceWhite : AppTheme.neutralDark,
          size: 24,
        ),
      ),
    );
  }
}
