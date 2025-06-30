import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../localization/app_localizations.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/account_section_widget.dart';
import './widgets/documents_section_widget.dart';
import './widgets/profile_header_widget.dart';
import './widgets/settings_section_widget.dart';
import './widgets/vehicle_info_widget.dart';

class DriverProfile extends StatefulWidget {
  const DriverProfile({super.key});

  @override
  State<DriverProfile> createState() => _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isDarkMode = false;
  bool _notificationsEnabled = true;
  String _selectedLanguage = 'Español';

  // Mock driver data
  final Map<String, dynamic> _driverData = {
    "profile": {
      "name": "Carlos Rodriguez",
      "photo":
          "https://images.pexels.com/photos/2182970/pexels-photo-2182970.jpeg?w=400",
      "rating": 4.8,
      "totalTrips": 1247,
      "memberSince": "Enero 2022",
      "phone": "+1 (555) 123-4567",
      "email": "carlos.rodriguez@email.com",
    },
    "vehicle": {
      "make": "Toyota",
      "model": "Corolla",
      "year": 2020,
      "color": "Blanco",
      "plateNumber": "ABC-123",
      "photo":
          "https://images.unsplash.com/photo-1549924231-f129b911e442?w=800",
    },
    "documents": {
      "license": {
        "verified": true,
        "status": "verified",
        "expiryDate": "2025-12-15",
      },
      "insurance": {
        "verified": true,
        "status": "verified",
        "expiryDate": "2024-08-20",
      },
      "registration": {
        "verified": false,
        "status": "pending",
        "expiryDate": null,
      },
    },
    "ratings": {
      "overall": 4.8,
      "breakdown": {"5": 78, "4": 15, "3": 5, "2": 1, "1": 1},
      "recentFeedback": [
        "Excelente conductor, muy puntual",
        "Vehículo limpio y cómodo",
        "Conducción suave y segura",
      ],
    },
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.index = 3; // Profile tab active by default
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showPhotoOptions() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (context) => SafeArea(
            child: Wrap(
              children: [
                Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Actualizar Foto de Perfil',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 3.h),
                      ListTile(
                        leading: CustomIconWidget(
                          iconName: 'camera_alt',
                          color: AppTheme.primaryOrange,
                          size: 24,
                        ),
                        title: Text('Tomar Foto'),
                        onTap: () {
                          Navigator.pop(context);
                          // Handle camera capture
                        },
                      ),
                      ListTile(
                        leading: CustomIconWidget(
                          iconName: 'photo_library',
                          color: AppTheme.primaryOrange,
                          size: 24,
                        ),
                        title: Text('Elegir de Galería'),
                        onTap: () {
                          Navigator.pop(context);
                          // Handle gallery selection
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

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            AppLocalizations.get('logout'),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: Text(
            '¿Estás seguro de que quieres cerrar sesión?',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppLocalizations.get('cancel')),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.driverLogin,
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.errorRed,
              ),
              child: Text(AppLocalizations.get('logout')),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCurrentScreen() {
    switch (_tabController.index) {
      case 0:
        return _buildDashboardPlaceholder();
      case 1:
        return _buildTripsPlaceholder();
      case 2:
        return _buildEarningsPlaceholder();
      case 3:
        return _buildProfileTab();
      default:
        return _buildProfileTab();
    }
  }

  Widget _buildDashboardPlaceholder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'dashboard',
            color: AppTheme.neutralMedium,
            size: 64,
          ),
          SizedBox(height: 2.h),
          Text(
            AppLocalizations.get('dashboard'),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 1.h),
          TextButton(
            onPressed:
                () => Navigator.pushNamed(context, AppRoutes.driverDashboard),
            child: Text('Ir al Dashboard'),
          ),
        ],
      ),
    );
  }

  Widget _buildTripsPlaceholder() {
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
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 1.h),
          TextButton(
            onPressed:
                () => Navigator.pushNamed(context, AppRoutes.tripRequest),
            child: Text('Ver Solicitudes de Viaje'),
          ),
        ],
      ),
    );
  }

  Widget _buildEarningsPlaceholder() {
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
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 1.h),
          TextButton(
            onPressed:
                () => Navigator.pushNamed(context, AppRoutes.earningsDashboard),
            child: Text('Ver Ganancias Detalladas'),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        children: [
          // Profile Header
          ProfileHeaderWidget(
            driverName: _driverData["profile"]["name"],
            driverPhoto: _driverData["profile"]["photo"],
            rating: _driverData["profile"]["rating"].toDouble(),
            totalTrips: _driverData["profile"]["totalTrips"],
            onPhotoTap: _showPhotoOptions,
          ),
          SizedBox(height: 3.h),

          // Vehicle Information
          VehicleInfoWidget(
            vehicleData: _driverData["vehicle"],
            onEdit: () {
              // Navigate to vehicle edit screen
            },
          ),
          SizedBox(height: 3.h),

          // Settings Section
          SettingsSectionWidget(
            isDarkMode: _isDarkMode,
            notificationsEnabled: _notificationsEnabled,
            selectedLanguage: _selectedLanguage,
            onDarkModeToggle: (value) {
              setState(() {
                _isDarkMode = value;
              });
            },
            onNotificationToggle: (value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
            onLanguagePress: () {
              // Show language selection dialog
            },
            onPrivacyPress: () {
              // Navigate to privacy settings
            },
          ),
          SizedBox(height: 3.h),

          // Documents Section
          DocumentsSectionWidget(
            documentsData: _driverData["documents"],
            onUploadLicense: () {
              // Handle license upload
            },
            onUploadInsurance: () {
              // Handle insurance upload
            },
            onUploadRegistration: () {
              // Handle registration upload
            },
          ),
          SizedBox(height: 3.h),

          // Account Section
          AccountSectionWidget(
            onPaymentMethods: () {
              // Navigate to payment methods
            },
            onTaxDocuments: () {
              // Navigate to tax documents
            },
            onReferralProgram: () {
              // Navigate to referral program
            },
            onSupport: () {
              // Navigate to support
            },
            onLogout: _showLogoutDialog,
          ),
          SizedBox(height: 4.h),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: Theme.of(context).appBarTheme.elevation,
        title: Text(
          AppLocalizations.get('profile'),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppTheme.primaryOrange,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Show profile edit screen
            },
            icon: CustomIconWidget(
              iconName: 'edit',
              color: AppTheme.primaryOrange,
              size: 24,
            ),
          ),
        ],
      ),
      body: _buildCurrentScreen(),
      bottomNavigationBar: BottomNavigationBar(
        controller: _tabController,
        currentIndex: _tabController.index,
        onTap: (index) {
          setState(() {
            _tabController.index = index;
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
                  _tabController.index == 0
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
                  _tabController.index == 1
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
                  _tabController.index == 2
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
                  _tabController.index == 3
                      ? AppTheme.primaryOrange
                      : AppTheme.neutralMedium,
              size: 20,
            ),
            label: AppLocalizations.get('profile'),
          ),
        ],
      ),
    );
  }
}
