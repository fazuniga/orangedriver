import 'package:flutter/material.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/driver_registration/driver_registration.dart';
import '../presentation/driver_login/driver_login.dart';
import '../presentation/earnings_dashboard/earnings_dashboard.dart';
import '../presentation/driver_dashboard/driver_dashboard.dart';
import '../presentation/trip_request/trip_request.dart';
import '../presentation/driver_profile/driver_profile.dart';

class AppRoutes {
  static const String initial = '/';
  static const String splashScreen = '/splash-screen';
  static const String driverLogin = '/driver-login';
  static const String driverRegistration = '/driver-registration';
  static const String driverDashboard = '/driver-dashboard';
  static const String tripRequest = '/trip-request';
  static const String earningsDashboard = '/earnings-dashboard';
  static const String driverProfile = '/driver-profile';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const SplashScreen(),
    splashScreen: (context) => const SplashScreen(),
    driverLogin: (context) => const DriverLogin(),
    driverRegistration: (context) => const DriverRegistration(),
    driverDashboard: (context) => const DriverDashboard(),
    tripRequest: (context) => const TripRequest(),
    earningsDashboard: (context) => const EarningsDashboard(),
    driverProfile: (context) => const DriverProfile(),
  };
}
