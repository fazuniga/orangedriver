import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_image_widget.dart';

class PassengerInfoCardWidget extends StatelessWidget {
  final String passengerName;
  final String passengerPhoto;
  final double rating;
  final VoidCallback onCall;
  final VoidCallback onMessage;

  const PassengerInfoCardWidget({
    super.key,
    required this.passengerName,
    required this.passengerPhoto,
    required this.rating,
    required this.onCall,
    required this.onMessage,
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
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildPassengerAvatar(),
          SizedBox(width: 4.w),
          Expanded(child: _buildPassengerInfo()),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildPassengerAvatar() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppTheme.primaryOrange, width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: CustomImageWidget(
          imagePath: passengerPhoto,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildPassengerInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          passengerName,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppTheme.neutralDark,
          ),
        ),
        SizedBox(height: 0.5.h),
        Row(
          children: [
            Icon(Icons.star, color: AppTheme.warningAmber, size: 16),
            SizedBox(width: 1.w),
            Text(
              rating.toStringAsFixed(1),
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppTheme.neutralMedium,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        _buildActionButton(
          icon: Icons.phone,
          color: AppTheme.successGreen,
          onPressed: onCall,
        ),
        SizedBox(width: 2.w),
        _buildActionButton(
          icon: Icons.message,
          color: AppTheme.accentBlue,
          onPressed: onMessage,
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color, width: 1),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }
}
