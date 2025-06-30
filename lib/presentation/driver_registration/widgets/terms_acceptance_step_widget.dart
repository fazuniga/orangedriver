import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class TermsAcceptanceStepWidget extends StatefulWidget {
  final Function(bool) onAcceptanceChanged;
  final bool initialAccepted;

  const TermsAcceptanceStepWidget({
    super.key,
    required this.onAcceptanceChanged,
    required this.initialAccepted,
  });

  @override
  State<TermsAcceptanceStepWidget> createState() =>
      _TermsAcceptanceStepWidgetState();
}

class _TermsAcceptanceStepWidgetState extends State<TermsAcceptanceStepWidget> {
  bool _termsAccepted = false;
  bool _privacyAccepted = false;
  bool _backgroundCheckAccepted = false;
  bool _insuranceAccepted = false;

  final List<Map<String, dynamic>> _legalDocuments = [
    {
      'title': 'Terms of Service',
      'description': 'Driver agreement and service terms',
      'content':
          ''' ORANGEDRIVER TERMS OF SERVICE 1. ACCEPTANCE OF TERMS By registering as a driver with OrangeDriver, you agree to be bound by these Terms of Service. 2. DRIVER REQUIREMENTS - Must be at least 21 years old - Valid driver's license for at least 3 years - Clean driving record - Vehicle meeting our standards - Commercial insurance coverage 3. SERVICE OBLIGATIONS - Provide safe and professional transportation - Maintain vehicle in good condition - Follow all traffic laws and regulations - Treat passengers with respect and courtesy 4. COMPENSATION - Drivers receive a percentage of each fare - Payment processed weekly - Additional bonuses may apply during peak hours 5. TERMINATION Either party may terminate this agreement with 30 days notice. 6. LIABILITY Drivers are independent contractors responsible for their own actions. Last updated: December 2024 ''',
    },
    {
      'title': 'Privacy Policy',
      'description': 'How we collect and use your data',
      'content':
          ''' ORANGEDRIVER PRIVACY POLICY 1. INFORMATION WE COLLECT - Personal identification information - Location data during trips - Vehicle and insurance information - Trip history and earnings data 2. HOW WE USE YOUR INFORMATION - To provide ride-hailing services - To process payments - To ensure safety and security - To improve our services 3. INFORMATION SHARING We do not sell your personal information to third parties. 4. DATA SECURITY We implement appropriate security measures to protect your information. 5. YOUR RIGHTS You have the right to access, update, or delete your personal information. 6. CONTACT US For privacy concerns, contact us at privacy@orangedriver.com Last updated: December 2024 ''',
    },
    {
      'title': 'Background Check Authorization',
      'description': 'Permission for background verification',
      'content':
          ''' BACKGROUND CHECK AUTHORIZATION I hereby authorize OrangeDriver and its designated agents to conduct a comprehensive background check including: 1. CRIMINAL HISTORY CHECK - National and local criminal records - Sex offender registry check - Terrorist watch list screening 2. DRIVING RECORD CHECK - Motor vehicle records - Traffic violations - License status verification 3. EMPLOYMENT VERIFICATION - Previous employment history - Professional references 4. CONSENT I understand that this background check is required for driver approval and may be repeated periodically. 5. ACCURACY I certify that all information provided is true and accurate. 6. RIGHTS I understand my rights under the Fair Credit Reporting Act. By checking the box below, I provide my consent for this background check. ''',
    },
    {
      'title': 'Insurance Requirements',
      'description': 'Commercial insurance obligations',
      'content':
          ''' INSURANCE REQUIREMENTS 1. REQUIRED COVERAGE All drivers must maintain commercial auto insurance with minimum coverage: - \$1,000,000 liability coverage - \$1,000,000 uninsured/underinsured motorist coverage - Comprehensive and collision coverage 2. ADDITIONAL COVERAGE OrangeDriver provides supplemental coverage during active trips. 3. VERIFICATION Insurance certificates must be submitted and verified before activation. 4. CONTINUOUS COVERAGE Coverage must be maintained throughout your time as an OrangeDriver. 5. CLAIMS PROCESS Report all incidents immediately to both your insurance and OrangeDriver. 6. COMPLIANCE Failure to maintain required insurance will result in immediate deactivation. I acknowledge that I understand and will comply with these insurance requirements. ''',
    },
  ];

  @override
  void initState() {
    super.initState();
    _termsAccepted = widget.initialAccepted;
    _privacyAccepted = widget.initialAccepted;
    _backgroundCheckAccepted = widget.initialAccepted;
    _insuranceAccepted = widget.initialAccepted;
  }

  void _updateAcceptance() {
    final allAccepted =
        _termsAccepted &&
        _privacyAccepted &&
        _backgroundCheckAccepted &&
        _insuranceAccepted;
    widget.onAcceptanceChanged(allAccepted);
  }

  void _showLegalDocument(Map<String, dynamic> document) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => DraggableScrollableSheet(
            initialChildSize: 0.9,
            maxChildSize: 0.95,
            minChildSize: 0.5,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.surface,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppTheme.lightTheme.dividerColor,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              document['title'],
                              style: AppTheme.lightTheme.textTheme.titleLarge,
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: CustomIconWidget(
                              iconName: 'close',
                              color: AppTheme.lightTheme.colorScheme.onSurface,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        padding: EdgeInsets.all(4.w),
                        child: Text(
                          document['content'],
                          style: AppTheme.lightTheme.textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Terms & Conditions',
            style: AppTheme.lightTheme.textTheme.headlineSmall,
          ),
          SizedBox(height: 1.h),
          Text(
            'Please review and accept the following terms to complete your registration.',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 4.h),

          // Terms of Service
          _buildLegalDocumentCard(
            document: _legalDocuments[0],
            isAccepted: _termsAccepted,
            onAcceptanceChanged: (value) {
              setState(() {
                _termsAccepted = value;
              });
              _updateAcceptance();
            },
          ),

          // Privacy Policy
          _buildLegalDocumentCard(
            document: _legalDocuments[1],
            isAccepted: _privacyAccepted,
            onAcceptanceChanged: (value) {
              setState(() {
                _privacyAccepted = value;
              });
              _updateAcceptance();
            },
          ),

          // Background Check Authorization
          _buildLegalDocumentCard(
            document: _legalDocuments[2],
            isAccepted: _backgroundCheckAccepted,
            onAcceptanceChanged: (value) {
              setState(() {
                _backgroundCheckAccepted = value;
              });
              _updateAcceptance();
            },
          ),

          // Insurance Requirements
          _buildLegalDocumentCard(
            document: _legalDocuments[3],
            isAccepted: _insuranceAccepted,
            onAcceptanceChanged: (value) {
              setState(() {
                _insuranceAccepted = value;
              });
              _updateAcceptance();
            },
          ),

          SizedBox(height: 4.h),

          // Summary Card
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.primaryContainer
                  .withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.lightTheme.colorScheme.primary.withValues(
                  alpha: 0.2,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'info',
                      color: AppTheme.lightTheme.colorScheme.primary,
                      size: 20,
                    ),
                    SizedBox(width: 3.w),
                    Text(
                      'Important Information',
                      style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Text(
                  'By accepting these terms, you agree to:',
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 1.h),
                ...[
                  'Operate as an independent contractor',
                  'Maintain required insurance coverage',
                  'Submit to background checks',
                  'Follow all safety protocols',
                  'Provide professional service',
                ].map((item) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 0.5.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomIconWidget(
                          iconName: 'check',
                          color: AppTheme.successGreen,
                          size: 16,
                        ),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: Text(
                            item,
                            style: AppTheme.lightTheme.textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegalDocumentCard({
    required Map<String, dynamic> document,
    required bool isAccepted,
    required Function(bool) onAcceptanceChanged,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 3.h),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color:
                          isAccepted
                              ? AppTheme.successGreen.withValues(alpha: 0.1)
                              : AppTheme.lightTheme.colorScheme.outline
                                  .withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CustomIconWidget(
                      iconName: isAccepted ? 'check_circle' : 'description',
                      color:
                          isAccepted
                              ? AppTheme.successGreen
                              : AppTheme
                                  .lightTheme
                                  .colorScheme
                                  .onSurfaceVariant,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          document['title'],
                          style: AppTheme.lightTheme.textTheme.titleMedium,
                        ),
                        Text(
                          document['description'],
                          style: AppTheme.lightTheme.textTheme.bodySmall
                              ?.copyWith(
                                color:
                                    AppTheme
                                        .lightTheme
                                        .colorScheme
                                        .onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _showLegalDocument(document),
                      icon: CustomIconWidget(
                        iconName: 'visibility',
                        color: AppTheme.lightTheme.colorScheme.primary,
                        size: 16,
                      ),
                      label: Text('Read Document'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),

              // Acceptance Checkbox
              Row(
                children: [
                  Checkbox(
                    value: isAccepted,
                    onChanged: (value) => onAcceptanceChanged(value ?? false),
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => onAcceptanceChanged(!isAccepted),
                      child: Text(
                        'I have read and agree to the ${document['title']}',
                        style: AppTheme.lightTheme.textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
