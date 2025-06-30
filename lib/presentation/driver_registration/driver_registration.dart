import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/basic_info_step_widget.dart';
import './widgets/document_upload_step_widget.dart';
import './widgets/progress_indicator_widget.dart';
import './widgets/success_step_widget.dart';
import './widgets/terms_acceptance_step_widget.dart';
import './widgets/vehicle_details_step_widget.dart';

class DriverRegistration extends StatefulWidget {
  const DriverRegistration({super.key});

  @override
  State<DriverRegistration> createState() => _DriverRegistrationState();
}

class _DriverRegistrationState extends State<DriverRegistration>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _progressAnimationController;
  late Animation<double> _progressAnimation;

  int _currentStep = 0;
  final int _totalSteps = 4;
  bool _isLoading = false;

  // Form data storage
  final Map<String, dynamic> _registrationData = {
    'basicInfo': {},
    'documents': {},
    'vehicleDetails': {},
    'termsAccepted': false,
  };

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _progressAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _progressAnimationController,
        curve: Curves.easeInOut,
      ),
    );
    _updateProgress();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _progressAnimationController.dispose();
    super.dispose();
  }

  void _updateProgress() {
    final progress = (_currentStep + 1) / _totalSteps;
    _progressAnimationController.animateTo(progress);
  }

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      setState(() {
        _currentStep++;
        _isLoading = true;
      });

      _pageController
          .nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          )
          .then((_) {
            setState(() {
              _isLoading = false;
            });
            _updateProgress();
          });
    } else {
      _completeRegistration();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
        _isLoading = true;
      });

      _pageController
          .previousPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          )
          .then((_) {
            setState(() {
              _isLoading = false;
            });
            _updateProgress();
          });
    }
  }

  void _completeRegistration() {
    setState(() {
      _isLoading = true;
    });

    // Simulate registration process
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _currentStep = _totalSteps;
        _isLoading = false;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void _updateStepData(String stepKey, Map<String, dynamic> data) {
    setState(() {
      _registrationData[stepKey] = data;
    });
    _saveProgressLocally();
  }

  void _saveProgressLocally() {
    // Simulate local storage save
    // In real implementation, use SharedPreferences or local database
  }

  bool _canProceedToNextStep() {
    switch (_currentStep) {
      case 0:
        final basicInfo =
            _registrationData['basicInfo'] as Map<String, dynamic>?;
        return basicInfo != null &&
            basicInfo['fullName']?.isNotEmpty == true &&
            basicInfo['email']?.isNotEmpty == true &&
            basicInfo['phone']?.isNotEmpty == true &&
            basicInfo['password']?.isNotEmpty == true;
      case 1:
        final documents =
            _registrationData['documents'] as Map<String, dynamic>?;
        return documents != null &&
            documents['driverLicense'] != null &&
            documents['vehicleRegistration'] != null &&
            documents['insurance'] != null;
      case 2:
        final vehicleDetails =
            _registrationData['vehicleDetails'] as Map<String, dynamic>?;
        return vehicleDetails != null &&
            vehicleDetails['make']?.isNotEmpty == true &&
            vehicleDetails['model']?.isNotEmpty == true &&
            vehicleDetails['year'] != null &&
            vehicleDetails['color']?.isNotEmpty == true &&
            vehicleDetails['licensePlate']?.isNotEmpty == true;
      case 3:
        return _registrationData['termsAccepted'] == true;
      default:
        return false;
    }
  }

  String _getStepTitle() {
    switch (_currentStep) {
      case 0:
        return 'Basic Information';
      case 1:
        return 'Document Upload';
      case 2:
        return 'Vehicle Details';
      case 3:
        return 'Terms & Conditions';
      default:
        return 'Registration Complete';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: _currentStep < _totalSteps ? _buildAppBar() : null,
      body: Column(
        children: [
          if (_currentStep < _totalSteps) ...[
            ProgressIndicatorWidget(
              currentStep: _currentStep + 1,
              totalSteps: _totalSteps,
              animation: _progressAnimation,
            ),
            SizedBox(height: 2.h),
          ],
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                BasicInfoStepWidget(
                  onDataChanged: (data) => _updateStepData('basicInfo', data),
                  initialData:
                      _registrationData['basicInfo'] as Map<String, dynamic>? ??
                      {},
                ),
                DocumentUploadStepWidget(
                  onDataChanged: (data) => _updateStepData('documents', data),
                  initialData:
                      _registrationData['documents'] as Map<String, dynamic>? ??
                      {},
                ),
                VehicleDetailsStepWidget(
                  onDataChanged:
                      (data) => _updateStepData('vehicleDetails', data),
                  initialData:
                      _registrationData['vehicleDetails']
                          as Map<String, dynamic>? ??
                      {},
                ),
                TermsAcceptanceStepWidget(
                  onAcceptanceChanged:
                      (accepted) => _updateStepData('termsAccepted', {
                        'accepted': accepted,
                      }),
                  initialAccepted:
                      _registrationData['termsAccepted'] as bool? ?? false,
                ),
                const SuccessStepWidget(),
              ],
            ),
          ),
          if (_currentStep < _totalSteps) _buildBottomActions(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      elevation: 0,
      leading:
          _currentStep > 0
              ? IconButton(
                onPressed: _previousStep,
                icon: CustomIconWidget(
                  iconName: 'arrow_back',
                  color: AppTheme.lightTheme.colorScheme.onSurface,
                  size: 24,
                ),
              )
              : IconButton(
                onPressed: () => Navigator.pop(context),
                icon: CustomIconWidget(
                  iconName: 'close',
                  color: AppTheme.lightTheme.colorScheme.onSurface,
                  size: 24,
                ),
              ),
      title: Text(
        _getStepTitle(),
        style: AppTheme.lightTheme.textTheme.titleLarge,
      ),
      centerTitle: true,
      actions: [
        if (_currentStep < 2)
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/driver-login');
            },
            child: Text(
              'Skip for Now',
              style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                color: AppTheme.lightTheme.colorScheme.primary,
              ),
            ),
          ),
        SizedBox(width: 2.w),
      ],
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        border: Border(
          top: BorderSide(color: AppTheme.lightTheme.dividerColor, width: 1),
        ),
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed:
                _isLoading || !_canProceedToNextStep() ? null : _nextStep,
            style: AppTheme.lightTheme.elevatedButtonTheme.style?.copyWith(
              minimumSize: WidgetStateProperty.all(Size(double.infinity, 6.h)),
            ),
            child:
                _isLoading
                    ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppTheme.lightTheme.colorScheme.onPrimary,
                        ),
                      ),
                    )
                    : Text(
                      _currentStep == _totalSteps - 1
                          ? 'Complete Registration'
                          : 'Continue',
                      style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onPrimary,
                      ),
                    ),
          ),
        ),
      ),
    );
  }
}
