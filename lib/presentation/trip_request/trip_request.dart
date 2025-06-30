import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/action_buttons_widget.dart';
import './widgets/countdown_timer_widget.dart';
import './widgets/decline_reason_sheet.dart';
import './widgets/fare_display_widget.dart';
import './widgets/map_preview_widget.dart';
import './widgets/passenger_info_widget.dart';
import './widgets/trip_details_widget.dart';

class TripRequest extends StatefulWidget {
  const TripRequest({super.key});

  @override
  State<TripRequest> createState() => _TripRequestState();
}

class _TripRequestState extends State<TripRequest>
    with TickerProviderStateMixin {
  late AnimationController _countdownController;
  late AnimationController _fadeController;
  late Timer _countdownTimer;

  int _remainingSeconds = 15;
  bool _isAcceptLoading = false;
  bool _canInteract = false;
  bool _isExpanded = false;

  // Mock trip data
  final Map<String, dynamic> _tripData = {
    "id": "TR123456",
    "passenger": {
      "name": "Sarah Johnson",
      "rating": 4.8,
      "tripCount": 127,
      "profileImage":
          "https://images.unsplash.com/photo-1494790108755-2616b612b786?w=150&h=150&fit=crop&crop=face",
    },
    "pickup": {
      "address": "123 Main Street, Downtown",
      "coordinates": {"lat": 40.7128, "lng": -74.0060},
      "distance": "0.8 km",
      "eta": "3 min",
    },
    "destination": {
      "address": "456 Oak Avenue, Uptown",
      "coordinates": {"lat": 40.7589, "lng": -73.9851},
    },
    "fare": {"base": 12.50, "surge": 1.2, "total": 15.00, "currency": "\$"},
    "tripType": "Standard",
    "specialRequests": ["Pet-friendly", "Extra stop requested"],
    "estimatedDuration": "18 min",
  };

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startCountdown();
    _enableInteractionAfterDelay();
  }

  void _initializeAnimations() {
    _countdownController = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _countdownController.forward();
    _fadeController.forward();
  }

  void _startCountdown() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _autoDecline();
      }
    });
  }

  void _enableInteractionAfterDelay() {
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _canInteract = true;
      });
    });
  }

  void _autoDecline() {
    _countdownTimer.cancel();
    HapticFeedback.lightImpact();
    Navigator.pushNamed(context, '/driver-dashboard');
  }

  void _handleAccept() async {
    if (!_canInteract || _isAcceptLoading) return;

    setState(() {
      _isAcceptLoading = true;
    });

    HapticFeedback.mediumImpact();
    _countdownTimer.cancel();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      Navigator.pushNamed(context, '/driver-dashboard');
    }
  }

  void _handleDecline() {
    if (!_canInteract) return;

    _showDeclineReasonSheet();
  }

  void _showDeclineReasonSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => DeclineReasonSheet(
            onReasonSelected: (reason) {
              _countdownTimer.cancel();
              Navigator.pushNamed(context, '/driver-dashboard');
            },
          ),
    );
  }

  @override
  void dispose() {
    _countdownController.dispose();
    _fadeController.dispose();
    _countdownTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withValues(alpha: 0.7),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeController,
          child: Container(
            margin: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppTheme.primaryOrange, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                // Header with countdown
                CountdownTimerWidget(
                  remainingSeconds: _remainingSeconds,
                  controller: _countdownController,
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 2.h),

                        // Passenger info
                        PassengerInfoWidget(
                          passengerData: _tripData['passenger'],
                        ),

                        SizedBox(height: 3.h),

                        // Pickup location
                        _buildPickupLocation(),

                        SizedBox(height: 3.h),

                        // Map preview
                        MapPreviewWidget(
                          pickupLocation: _tripData['pickup'],
                          destination: _tripData['destination'],
                        ),

                        SizedBox(height: 3.h),

                        // Fare display
                        FareDisplayWidget(fareData: _tripData['fare']),

                        SizedBox(height: 2.h),

                        // Expandable trip details
                        TripDetailsWidget(
                          tripData: _tripData,
                          isExpanded: _isExpanded,
                          onToggle: () {
                            setState(() {
                              _isExpanded = !_isExpanded;
                            });
                          },
                        ),

                        SizedBox(height: 4.h),
                      ],
                    ),
                  ),
                ),

                // Action buttons
                ActionButtonsWidget(
                  canInteract: _canInteract,
                  isAcceptLoading: _isAcceptLoading,
                  onAccept: _handleAccept,
                  onDecline: _handleDecline,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPickupLocation() {
    final pickup = _tripData['pickup'];

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.cardColor,
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
            children: [
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: AppTheme.primaryOrange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomIconWidget(
                  iconName: 'location_on',
                  color: AppTheme.primaryOrange,
                  size: 20,
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pickup Location',
                      style: AppTheme.lightTheme.textTheme.labelMedium
                          ?.copyWith(color: AppTheme.neutralMedium),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      pickup['address'],
                      style: AppTheme.lightTheme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              _buildInfoChip(
                icon: 'directions',
                label: pickup['distance'],
                color: AppTheme.accentBlue,
              ),
              SizedBox(width: 3.w),
              _buildInfoChip(
                icon: 'schedule',
                label: pickup['eta'],
                color: AppTheme.successGreen,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip({
    required String icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomIconWidget(iconName: icon, color: color, size: 16),
          SizedBox(width: 1.w),
          Text(
            label,
            style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
