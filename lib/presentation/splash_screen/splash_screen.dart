import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../localization/app_localizations.dart';
import '../../theme/app_theme.dart';
import './widgets/splash_loading_widget.dart';
import './widgets/splash_logo_widget.dart';

// lib/presentation/splash_screen/splash_screen.dart

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoAnimationController;
  late AnimationController _fadeAnimationController;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _fadeAnimation;

  bool _showRetryOption = false;
  bool _isInitializing = true;

  // Mock authentication and initialization data
  final Map<String, dynamic> _mockDriverData = {
    "isAuthenticated": true,
    "hasActiveTrip": false,
    "isOnline": true,
    "driverId": "DRV001",
    "vehicleProfile": {
      "make": "Toyota",
      "model": "Camry",
      "year": 2022,
      "plateNumber": "ABC123",
    },
    "lastKnownLocation": {"latitude": 37.7749, "longitude": -122.4194},
  };

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startInitialization();
  }

  void _initializeAnimations() {
    _logoAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _logoScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoAnimationController,
        curve: Curves.elasticOut,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _fadeAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _logoAnimationController.forward();
  }

  Future<void> _startInitialization() async {
    try {
      setState(() {
        _isInitializing = true;
        _showRetryOption = false;
      });

      // Simulate initialization tasks
      await Future.wait([
        _checkDriverAuthentication(),
        _loadVehicleProfile(),
        _fetchActiveTripData(),
        _initializeGPSServices(),
        _prepareCachedEarningsData(),
      ]);

      // Minimum splash display time
      await Future.delayed(const Duration(milliseconds: 2500));

      if (mounted) {
        await _navigateToNextScreen();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isInitializing = false;
          _showRetryOption = true;
        });

        // Auto-retry after 5 seconds
        Future.delayed(const Duration(seconds: 5), () {
          if (mounted && _showRetryOption) {
            _startInitialization();
          }
        });
      }
    }
  }

  Future<void> _checkDriverAuthentication() async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Simulate authentication check
  }

  Future<void> _loadVehicleProfile() async {
    await Future.delayed(const Duration(milliseconds: 300));
    // Simulate vehicle profile loading
  }

  Future<void> _fetchActiveTripData() async {
    await Future.delayed(const Duration(milliseconds: 400));
    // Simulate active trip data fetching
  }

  Future<void> _initializeGPSServices() async {
    await Future.delayed(const Duration(milliseconds: 600));
    // Simulate GPS initialization
  }

  Future<void> _prepareCachedEarningsData() async {
    await Future.delayed(const Duration(milliseconds: 350));
    // Simulate earnings data preparation
  }

  Future<void> _navigateToNextScreen() async {
    _fadeAnimationController.forward();

    await Future.delayed(const Duration(milliseconds: 400));

    if (!mounted) return;

    // Navigation logic based on driver status
    final bool isAuthenticated = _mockDriverData["isAuthenticated"] as bool;
    final bool hasActiveTrip = _mockDriverData["hasActiveTrip"] as bool;
    final bool isOnline = _mockDriverData["isOnline"] as bool;

    String nextRoute;

    if (!isAuthenticated) {
      nextRoute = '/driver-login';
    } else if (hasActiveTrip) {
      nextRoute = '/trip-request';
    } else if (isOnline) {
      nextRoute = '/driver-dashboard';
    } else {
      nextRoute = '/driver-dashboard';
    }

    Navigator.pushReplacementNamed(context, nextRoute);
  }

  void _retryInitialization() {
    _startInitialization();
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _fadeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.primaryOrange,
              AppTheme.secondaryOrange,
              AppTheme.primaryOrange.withValues(alpha: 0.8),
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Center(
                    child: SplashLogoWidget(
                      scaleAnimation: _logoScaleAnimation,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _isInitializing
                          ? SplashLoadingWidget()
                          : _showRetryOption
                          ? _buildRetrySection()
                          : SizedBox.shrink(),
                      SizedBox(height: 4.h),
                      _buildVersionInfo(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRetrySection() {
    return Column(
      children: [
        Text(
          AppLocalizations.get('connection_timeout'),
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.surfaceWhite,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 2.h),
        ElevatedButton(
          onPressed: _retryInitialization,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.surfaceWhite,
            foregroundColor: AppTheme.primaryOrange,
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.5.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            AppLocalizations.get('retry'),
            style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
              color: AppTheme.primaryOrange,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVersionInfo() {
    return Text(
      '${AppLocalizations.get('app_title')} v1.0.0',
      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
        color: AppTheme.surfaceWhite.withValues(alpha: 0.8),
        fontSize: 10.sp,
      ),
    );
  }
}
