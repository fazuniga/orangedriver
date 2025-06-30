import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../localization/app_localizations.dart';
import '../../theme/app_theme.dart';
import './widgets/navigation_controls_widget.dart';
import './widgets/passenger_info_card_widget.dart';
import './widgets/trip_action_buttons_widget.dart';
import './widgets/trip_map_widget.dart';
import './widgets/trip_status_bar_widget.dart';

class TripActive extends StatefulWidget {
  const TripActive({super.key});

  @override
  State<TripActive> createState() => _TripActiveState();
}

class _TripActiveState extends State<TripActive> {
  TripPhase _currentPhase = TripPhase.arriving;
  bool _isVoiceGuidanceEnabled = true;
  String _elapsedTime = '00:00';
  String _currentFare = '\$12.50';
  double _tripProgress = 0.3;
  bool _showGpsWarning = false;

  // Mock trip data
  final Map<String, dynamic> _tripData = {
    'passenger': {
      'name': 'María González',
      'photo':
          'https://images.unsplash.com/photo-1494790108755-2616c2a27c94?w=150&h=150&fit=crop&crop=face',
      'rating': 4.8,
      'phone': '+1234567890',
    },
    'pickup': {
      'address': 'Av. Insurgentes 1234, Roma Norte',
      'lat': 19.4326,
      'lng': -99.1332,
    },
    'destination': {
      'address': 'Aeropuerto Internacional CDMX',
      'lat': 19.4363,
      'lng': -99.0721,
    },
    'estimatedFare': 280.0,
    'distance': '24.5 km',
    'duration': '35 min',
  };

  @override
  void initState() {
    super.initState();
    _startTripTimer();
    _simulateGpsWarning();
  }

  void _startTripTimer() {
    // Simulate trip timer
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          final minutes = (_tripProgress * 35).round();
          _elapsedTime =
              '${(minutes ~/ 60).toString().padLeft(2, '0')}:${(minutes % 60).toString().padLeft(2, '0')}';
          _currentFare =
              '\$${(12.50 + (_tripProgress * 267.50)).toStringAsFixed(2)}';
        });
        _startTripTimer();
      }
    });
  }

  void _simulateGpsWarning() {
    Future.delayed(const Duration(seconds: 10), () {
      if (mounted) {
        setState(() {
          _showGpsWarning = true;
        });
        Future.delayed(const Duration(seconds: 5), () {
          if (mounted) {
            setState(() {
              _showGpsWarning = false;
            });
          }
        });
      }
    });
  }

  void _handleArrivedPressed() {
    setState(() {
      _currentPhase = TripPhase.pickup;
      _tripProgress = 0.5;
    });
    _showArrivalNotification();
  }

  void _handleStartTripPressed() {
    setState(() {
      _currentPhase = TripPhase.active;
      _tripProgress = 0.6;
    });
  }

  void _handleEndTripPressed() {
    setState(() {
      _currentPhase = TripPhase.completed;
      _tripProgress = 1.0;
    });
    _showTripSummary();
  }

  void _showArrivalNotification() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Pasajero notificado de tu llegada'),
        backgroundColor: AppTheme.successGreen,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showTripSummary() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildTripSummarySheet(),
    );
  }

  void _handleCallPassenger() {
    // Implement call functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Llamando a ${_tripData['passenger']['name']}...'),
        backgroundColor: AppTheme.accentBlue,
      ),
    );
  }

  void _handleMessagePassenger() {
    // Implement messaging functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Abriendo chat con ${_tripData['passenger']['name']}...'),
        backgroundColor: AppTheme.accentBlue,
      ),
    );
  }

  void _handlePanicButton() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(AppLocalizations.get('emergency_assistance')),
            content: Text(AppLocalizations.get('emergency_message')),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(AppLocalizations.get('cancel')),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Implement emergency call
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.errorRed,
                ),
                child: Text(AppLocalizations.get('call_emergency')),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Full-screen map
          TripMapWidget(
            pickupAddress: _tripData['pickup']['address'],
            destinationAddress: _tripData['destination']['address'],
            showGpsWarning: _showGpsWarning,
            warningMessage:
                _showGpsWarning
                    ? AppLocalizations.get('gps_accuracy_warning')
                    : null,
          ),

          // Top status bar
          SafeArea(
            child: TripStatusBarWidget(
              status: _getStatusText(),
              elapsedTime: _elapsedTime,
              currentFare: _currentFare,
              progress: _tripProgress,
            ),
          ),

          // Navigation controls
          NavigationControlsWidget(
            isVoiceGuidanceEnabled: _isVoiceGuidanceEnabled,
            onVoiceToggle: () {
              setState(() {
                _isVoiceGuidanceEnabled = !_isVoiceGuidanceEnabled;
              });
            },
            onZoomIn: () {
              // Implement map zoom in
            },
            onZoomOut: () {
              // Implement map zoom out
            },
            onShowAlternatives: () {
              // Implement route alternatives
            },
            onRecenter: () {
              // Implement map recenter
            },
          ),

          // Passenger info card (slides up from bottom)
          Positioned(
            bottom: 20.h,
            left: 0,
            right: 0,
            child: PassengerInfoCardWidget(
              passengerName: _tripData['passenger']['name'],
              passengerPhoto: _tripData['passenger']['photo'],
              rating: _tripData['passenger']['rating'],
              onCall: _handleCallPassenger,
              onMessage: _handleMessagePassenger,
            ),
          ),

          // Bottom action buttons
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: TripActionButtonsWidget(
              currentPhase: _currentPhase,
              onArrivedPressed: _handleArrivedPressed,
              onStartTripPressed: _handleStartTripPressed,
              onEndTripPressed: _handleEndTripPressed,
              onNotifyPassenger: _handleCallPassenger,
              onPanicButton: _handlePanicButton,
            ),
          ),
        ],
      ),
    );
  }

  String _getStatusText() {
    switch (_currentPhase) {
      case TripPhase.arriving:
        return AppLocalizations.get('arriving');
      case TripPhase.pickup:
        return 'En ubicación de recogida';
      case TripPhase.active:
        return AppLocalizations.get('trip_started');
      case TripPhase.completed:
        return AppLocalizations.get('completed');
    }
  }

  Widget _buildTripSummarySheet() {
    return Container(
      height: 60.h,
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.neutralMedium,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              'Viaje Completado',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: AppTheme.neutralDark,
              ),
            ),
            SizedBox(height: 3.h),
            _buildSummaryRow('Tarifa Total', _currentFare),
            _buildSummaryRow('Duración', _elapsedTime),
            _buildSummaryRow('Distancia', _tripData['distance']),
            SizedBox(height: 4.h),
            SizedBox(
              width: double.infinity,
              height: 6.h,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/driver-dashboard');
                },
                child: Text('Finalizar Viaje'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 14.sp, color: AppTheme.neutralMedium),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppTheme.neutralDark,
            ),
          ),
        ],
      ),
    );
  }
}
