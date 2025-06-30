import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../localization/app_localizations.dart';
import '../../../theme/app_theme.dart';

enum TripPhase { arriving, pickup, active, completed }

class TripActionButtonsWidget extends StatelessWidget {
  final TripPhase currentPhase;
  final VoidCallback? onArrivedPressed;
  final VoidCallback? onStartTripPressed;
  final VoidCallback? onEndTripPressed;
  final VoidCallback? onNotifyPassenger;
  final VoidCallback? onPanicButton;

  const TripActionButtonsWidget({
    super.key,
    required this.currentPhase,
    this.onArrivedPressed,
    this.onStartTripPressed,
    this.onEndTripPressed,
    this.onNotifyPassenger,
    this.onPanicButton,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildMainActionButton(),
          if (currentPhase == TripPhase.arriving) ...[
            SizedBox(height: 2.h),
            _buildSecondaryButton(
              text: AppLocalizations.get('call_passenger'),
              icon: Icons.phone,
              onPressed: onNotifyPassenger,
              color: AppTheme.accentBlue,
            ),
          ],
          SizedBox(height: 2.h),
          _buildPanicButton(),
        ],
      ),
    );
  }

  Widget _buildMainActionButton() {
    String buttonText;
    Color buttonColor;
    VoidCallback? onPressed;

    switch (currentPhase) {
      case TripPhase.arriving:
        buttonText = AppLocalizations.get('i_have_arrived');
        buttonColor = AppTheme.primaryOrange;
        onPressed = onArrivedPressed;
        break;
      case TripPhase.pickup:
        buttonText = AppLocalizations.get('start_trip');
        buttonColor = AppTheme.successGreen;
        onPressed = onStartTripPressed;
        break;
      case TripPhase.active:
        buttonText = AppLocalizations.get('end_trip');
        buttonColor = AppTheme.errorRed;
        onPressed = onEndTripPressed;
        break;
      case TripPhase.completed:
        buttonText = AppLocalizations.get('completed');
        buttonColor = AppTheme.neutralMedium;
        onPressed = null;
        break;
    }

    return SizedBox(
      width: double.infinity,
      height: 6.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: AppTheme.surfaceWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton({
    required String text,
    required IconData icon,
    required VoidCallback? onPressed,
    required Color color,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 5.h,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 20),
        label: Text(text),
        style: OutlinedButton.styleFrom(
          foregroundColor: color,
          side: BorderSide(color: color),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildPanicButton() {
    return SizedBox(
      width: double.infinity,
      height: 5.h,
      child: OutlinedButton.icon(
        onPressed: onPanicButton,
        icon: Icon(Icons.warning, size: 20),
        label: Text(AppLocalizations.get('panic_button')),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppTheme.errorRed,
          side: BorderSide(color: AppTheme.errorRed),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
