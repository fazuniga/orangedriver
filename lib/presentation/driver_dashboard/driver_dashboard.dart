import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../localization/app_localizations.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_icon_widget.dart';
import '../../widgets/custom_image_widget.dart';
import './widgets/earnings_summary_widget.dart';
import './widgets/location_card_widget.dart';
import './widgets/quick_stats_widget.dart';
import './widgets/recent_trips_widget.dart';
import './widgets/status_toggle_widget.dart';

// lib/presentation/driver_dashboard/driver_dashboard.dart

class DriverDashboard extends StatefulWidget {
  const DriverDashboard({super.key});

  @override
  State<DriverDashboard> createState() => _DriverDashboardState();
}

class _DriverDashboardState extends State<DriverDashboard>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isOnline = false;
  bool _isRefreshing = false;
  int _currentIndex = 0;

  // Mock data for dashboard
  final Map<String, dynamic> _dashboardData = {
    "driverStatus": {
      "isOnline": false,
      "currentLocation":
          "Distrito Comercial del Centro, Calle Principal y 5ta Avenida",
      "gpsAccuracy": "Alta (3m)",
      "batteryLevel": 85,
      "gpsSignal": "Fuerte",
    },
    "todayEarnings": {
      "amount": "\$127.50",
      "tripsCompleted": 8,
      "hoursOnline": "6.5 hrs",
    },
    "weeklyStats": {
      "weeklyEarnings": "\$892.30",
      "rating": "4.8",
      "acceptanceRate": "94%",
    },
    "recentTrips": [
      {
        "id": "TR001",
        "passengerName": "Sarah Johnson",
        "pickup": "Terminal 2 del Aeropuerto",
        "dropoff": "Hotel del Centro",
        "earnings": "\$24.50",
        "rating": 5,
        "duration": "35 min",
        "timestamp": "hace 2 horas",
      },
      {
        "id": "TR002",
        "passengerName": "Michael Chen",
        "pickup": "Centro Comercial",
        "dropoff": "Campus Universitario",
        "earnings": "\$18.75",
        "rating": 4,
        "duration": "22 min",
        "timestamp": "hace 4 horas",
      },
      {
        "id": "TR003",
        "passengerName": "Emma Davis",
        "pickup": "Centro de Negocios",
        "dropoff": "Área Residencial",
        "earnings": "\$16.25",
        "rating": 5,
        "duration": "28 min",
        "timestamp": "hace 5 horas",
      },
      {
        "id": "TR004",
        "passengerName": "James Wilson",
        "pickup": "Estación de Tren",
        "dropoff": "Centro de la Ciudad",
        "earnings": "\$12.80",
        "rating": 4,
        "duration": "18 min",
        "timestamp": "hace 6 horas",
      },
      {
        "id": "TR005",
        "passengerName": "Lisa Anderson",
        "pickup": "Hospital",
        "dropoff": "Farmacia",
        "earnings": "\$8.90",
        "rating": 5,
        "duration": "12 min",
        "timestamp": "hace 7 horas",
      },
    ],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _isOnline = _dashboardData["driverStatus"]["isOnline"] as bool;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _refreshDashboard() async {
    setState(() {
      _isRefreshing = true;
    });

    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 2));

    // Update mock data (simulate fresh data)
    _dashboardData["todayEarnings"]["amount"] =
        "\$${(127.50 + (DateTime.now().millisecond % 10)).toStringAsFixed(2)}";
    _dashboardData["driverStatus"]["gpsAccuracy"] =
        DateTime.now().second % 2 == 0 ? "Alta (3m)" : "Media (8m)";

    setState(() {
      _isRefreshing = false;
    });
  }

  void _toggleOnlineStatus() {
    setState(() {
      _isOnline = !_isOnline;
      _dashboardData["driverStatus"]["isOnline"] = _isOnline;
    });
  }

  void _showPanicDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            AppLocalizations.get('emergency_assistance'),
            style: AppTheme.lightTheme.textTheme.titleLarge,
          ),
          content: Text(
            AppLocalizations.get('emergency_message'),
            style: AppTheme.lightTheme.textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppLocalizations.get('cancel')),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Handle emergency action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.errorRed,
              ),
              child: Text(AppLocalizations.get('call_emergency')),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCurrentScreen() {
    switch (_currentIndex) {
      case 0:
        return _buildDashboardTab();
      case 1:
        return _buildTripsTab();
      case 2:
        return _buildEarningsTab();
      case 3:
        return _buildProfileTab();
      default:
        return _buildDashboardTab();
    }
  }

  Widget _buildDashboardTab() {
    return RefreshIndicator(
      onRefresh: _refreshDashboard,
      color: AppTheme.primaryOrange,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Online/Offline Status Strip
            Container(
              width: double.infinity,
              height: 1.h,
              decoration: BoxDecoration(
                color: _isOnline ? AppTheme.successGreen : AppTheme.errorRed,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            SizedBox(height: 2.h),

            // Online/Offline Toggle Section
            StatusToggleWidget(
              isOnline: _isOnline,
              onToggle: _toggleOnlineStatus,
            ),
            SizedBox(height: 3.h),

            // Location Card
            LocationCardWidget(
              currentLocation:
                  _dashboardData["driverStatus"]["currentLocation"] as String,
              gpsAccuracy:
                  _dashboardData["driverStatus"]["gpsAccuracy"] as String,
            ),
            SizedBox(height: 3.h),

            // Earnings Summary
            EarningsSummaryWidget(
              todayEarnings:
                  _dashboardData["todayEarnings"] as Map<String, dynamic>,
            ),
            SizedBox(height: 3.h),

            // Quick Stats Grid
            QuickStatsWidget(
              weeklyStats:
                  _dashboardData["weeklyStats"] as Map<String, dynamic>,
            ),
            SizedBox(height: 3.h),

            // Recent Trips Section
            Text(
              AppLocalizations.get('recent_trips'),
              style: AppTheme.lightTheme.textTheme.titleLarge,
            ),
            SizedBox(height: 1.h),
            RecentTripsWidget(
              trips:
                  (_dashboardData["recentTrips"] as List)
                      .cast<Map<String, dynamic>>(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTripsTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'directions_car',
            color: AppTheme.neutralMedium,
            size: 64,
          ),
          SizedBox(height: 2.h),
          Text(
            AppLocalizations.get('trips'),
            style: AppTheme.lightTheme.textTheme.headlineSmall,
          ),
          SizedBox(height: 1.h),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/trip-request'),
            child: Text(AppLocalizations.get('trip_request')),
          ),
        ],
      ),
    );
  }

  Widget _buildEarningsTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'attach_money',
            color: AppTheme.neutralMedium,
            size: 64,
          ),
          SizedBox(height: 2.h),
          Text(
            AppLocalizations.get('earnings'),
            style: AppTheme.lightTheme.textTheme.headlineSmall,
          ),
          SizedBox(height: 1.h),
          TextButton(
            onPressed:
                () => Navigator.pushNamed(context, '/earnings-dashboard'),
            child: Text(AppLocalizations.get('view_detailed_earnings')),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'person',
            color: AppTheme.neutralMedium,
            size: 64,
          ),
          SizedBox(height: 2.h),
          Text(
            AppLocalizations.get('profile'),
            style: AppTheme.lightTheme.textTheme.headlineSmall,
          ),
          SizedBox(height: 1.h),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/driver-login'),
            child: Text(AppLocalizations.get('login')),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.lightTheme.appBarTheme.backgroundColor,
        elevation: AppTheme.lightTheme.appBarTheme.elevation,
        title: Row(
          children: [
            Container(
              width: 8.w,
              height: 4.h,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CustomImageWidget(
                  imageUrl: 'assets/images/no-image.jpg',
                  width: 8.w,
                  height: 4.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 3.w),
            Text(
              AppLocalizations.get('app_title'),
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                color: AppTheme.primaryOrange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          // GPS Signal Indicator
          Container(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: 'gps_fixed',
                  color: AppTheme.successGreen,
                  size: 16,
                ),
                SizedBox(width: 1.w),
                Text(
                  _dashboardData["driverStatus"]["gpsSignal"] as String,
                  style: AppTheme.lightTheme.textTheme.labelSmall,
                ),
              ],
            ),
          ),
          // Battery Level
          Container(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: 'battery_full',
                  color:
                      (_dashboardData["driverStatus"]["batteryLevel"] as int) >
                              20
                          ? AppTheme.successGreen
                          : AppTheme.errorRed,
                  size: 16,
                ),
                SizedBox(width: 1.w),
                Text(
                  '${_dashboardData["driverStatus"]["batteryLevel"]}%',
                  style: AppTheme.lightTheme.textTheme.labelSmall,
                ),
              ],
            ),
          ),
          // Emergency Panic Button
          IconButton(
            onPressed: _showPanicDialog,
            icon: CustomIconWidget(
              iconName: 'emergency',
              color: AppTheme.errorRed,
              size: 24,
            ),
          ),
        ],
      ),
      body: _buildCurrentScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppTheme.primaryOrange,
        unselectedItemColor: AppTheme.neutralMedium,
        items: [
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'dashboard',
              color:
                  _currentIndex == 0
                      ? AppTheme.primaryOrange
                      : AppTheme.neutralMedium,
              size: 20,
            ),
            label: AppLocalizations.get('dashboard'),
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'directions_car',
              color:
                  _currentIndex == 1
                      ? AppTheme.primaryOrange
                      : AppTheme.neutralMedium,
              size: 20,
            ),
            label: AppLocalizations.get('trips'),
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'attach_money',
              color:
                  _currentIndex == 2
                      ? AppTheme.primaryOrange
                      : AppTheme.neutralMedium,
              size: 20,
            ),
            label: AppLocalizations.get('earnings'),
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'person',
              color:
                  _currentIndex == 3
                      ? AppTheme.primaryOrange
                      : AppTheme.neutralMedium,
              size: 20,
            ),
            label: AppLocalizations.get('profile'),
          ),
        ],
      ),
      floatingActionButton:
          _isOnline
              ? null
              : FloatingActionButton.extended(
                onPressed: _toggleOnlineStatus,
                backgroundColor: AppTheme.primaryOrange,
                foregroundColor: AppTheme.onPrimaryLight,
                icon: CustomIconWidget(
                  iconName: 'power_settings_new',
                  color: AppTheme.onPrimaryLight,
                  size: 24,
                ),
                label: Text(
                  AppLocalizations.get('go_online'),
                  style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                    color: AppTheme.onPrimaryLight,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
    );
  }
}
