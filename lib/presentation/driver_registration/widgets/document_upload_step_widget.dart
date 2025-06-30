import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class DocumentUploadStepWidget extends StatefulWidget {
  final Function(Map<String, dynamic>) onDataChanged;
  final Map<String, dynamic> initialData;

  const DocumentUploadStepWidget({
    super.key,
    required this.onDataChanged,
    required this.initialData,
  });

  @override
  State<DocumentUploadStepWidget> createState() =>
      _DocumentUploadStepWidgetState();
}

class _DocumentUploadStepWidgetState extends State<DocumentUploadStepWidget> {
  Map<String, String?> _uploadedDocuments = {};

  final List<Map<String, dynamic>> _requiredDocuments = [
    {
      'key': 'driverLicense',
      'title': 'Driver\'s License',
      'description': 'Upload a clear photo of your valid driver\'s license',
      'icon': 'credit_card',
      'tips': [
        'Ensure all text is clearly visible',
        'Avoid glare and shadows',
        'Include all four corners of the license',
      ],
    },
    {
      'key': 'vehicleRegistration',
      'title': 'Vehicle Registration',
      'description': 'Upload your current vehicle registration document',
      'icon': 'description',
      'tips': [
        'Document must be current and valid',
        'All vehicle details should be visible',
        'Ensure document is not expired',
      ],
    },
    {
      'key': 'insurance',
      'title': 'Insurance Certificate',
      'description': 'Upload proof of valid vehicle insurance',
      'icon': 'security',
      'tips': [
        'Insurance must cover commercial use',
        'Policy should be active and current',
        'Include policy number and dates',
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _uploadedDocuments = Map<String, String?>.from(widget.initialData);
  }

  void _uploadDocument(String documentKey) {
    // Simulate document upload with camera integration
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildUploadOptionsSheet(documentKey),
    );
  }

  Widget _buildUploadOptionsSheet(String documentKey) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.all(4.w),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12.w,
              height: 0.5.h,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.outline,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              'Upload Document',
              style: AppTheme.lightTheme.textTheme.titleLarge,
            ),
            SizedBox(height: 3.h),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'camera_alt',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 24,
              ),
              title: Text(
                'Take Photo',
                style: AppTheme.lightTheme.textTheme.bodyLarge,
              ),
              subtitle: Text(
                'Use camera to capture document',
                style: AppTheme.lightTheme.textTheme.bodySmall,
              ),
              onTap: () {
                Navigator.pop(context);
                _simulateDocumentCapture(documentKey, 'camera');
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'photo_library',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 24,
              ),
              title: Text(
                'Choose from Gallery',
                style: AppTheme.lightTheme.textTheme.bodyLarge,
              ),
              subtitle: Text(
                'Select from existing photos',
                style: AppTheme.lightTheme.textTheme.bodySmall,
              ),
              onTap: () {
                Navigator.pop(context);
                _simulateDocumentCapture(documentKey, 'gallery');
              },
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  void _simulateDocumentCapture(String documentKey, String source) {
    // Simulate document capture and processing
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  color: AppTheme.lightTheme.colorScheme.primary,
                ),
                SizedBox(height: 2.h),
                Text(
                  'Processing document...',
                  style: AppTheme.lightTheme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
      setState(() {
        _uploadedDocuments[documentKey] =
            'mock_document_${documentKey}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      });
      widget.onDataChanged(_uploadedDocuments);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Document uploaded successfully'),
          backgroundColor: AppTheme.successGreen,
        ),
      );
    });
  }

  void _previewDocument(String documentKey) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            child: Container(
              padding: EdgeInsets.all(4.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Document Preview',
                        style: AppTheme.lightTheme.textTheme.titleMedium,
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: CustomIconWidget(
                          iconName: 'close',
                          color: AppTheme.lightTheme.colorScheme.onSurface,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Container(
                    height: 30.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color:
                          AppTheme
                              .lightTheme
                              .colorScheme
                              .surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppTheme.lightTheme.colorScheme.outline,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIconWidget(
                          iconName: 'description',
                          color: AppTheme.lightTheme.colorScheme.primary,
                          size: 48,
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'Document Preview',
                          style: AppTheme.lightTheme.textTheme.bodyLarge,
                        ),
                        Text(
                          _uploadedDocuments[documentKey] ?? '',
                          style: AppTheme.lightTheme.textTheme.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _uploadDocument(documentKey);
                          },
                          child: Text('Retake'),
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Looks Good'),
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Upload Required Documents',
            style: AppTheme.lightTheme.textTheme.headlineSmall,
          ),
          SizedBox(height: 1.h),
          Text(
            'Please upload clear photos of the following documents. Make sure all text is readable.',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 4.h),

          ..._requiredDocuments.map((document) {
            final isUploaded = _uploadedDocuments[document['key']] != null;
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
                                  isUploaded
                                      ? AppTheme.successGreen.withValues(
                                        alpha: 0.1,
                                      )
                                      : AppTheme.lightTheme.colorScheme.primary
                                          .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: CustomIconWidget(
                              iconName:
                                  isUploaded
                                      ? 'check_circle'
                                      : document['icon'],
                              color:
                                  isUploaded
                                      ? AppTheme.successGreen
                                      : AppTheme.lightTheme.colorScheme.primary,
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
                                  style:
                                      AppTheme.lightTheme.textTheme.titleMedium,
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

                      // Tips Section
                      ExpansionTile(
                        title: Text(
                          'Photo Tips',
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        leading: CustomIconWidget(
                          iconName: 'lightbulb',
                          color: AppTheme.warningAmber,
                          size: 20,
                        ),
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Column(
                              children:
                                  (document['tips'] as List<String>).map((tip) {
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 1.h),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomIconWidget(
                                            iconName: 'fiber_manual_record',
                                            color:
                                                AppTheme
                                                    .lightTheme
                                                    .colorScheme
                                                    .onSurfaceVariant,
                                            size: 8,
                                          ),
                                          SizedBox(width: 2.w),
                                          Expanded(
                                            child: Text(
                                              tip,
                                              style:
                                                  AppTheme
                                                      .lightTheme
                                                      .textTheme
                                                      .bodySmall,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 2.h),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child:
                                isUploaded
                                    ? OutlinedButton.icon(
                                      onPressed:
                                          () =>
                                              _previewDocument(document['key']),
                                      icon: CustomIconWidget(
                                        iconName: 'visibility',
                                        color:
                                            AppTheme
                                                .lightTheme
                                                .colorScheme
                                                .primary,
                                        size: 16,
                                      ),
                                      label: Text('Preview'),
                                    )
                                    : ElevatedButton.icon(
                                      onPressed:
                                          () =>
                                              _uploadDocument(document['key']),
                                      icon: CustomIconWidget(
                                        iconName: 'camera_alt',
                                        color:
                                            AppTheme
                                                .lightTheme
                                                .colorScheme
                                                .onPrimary,
                                        size: 16,
                                      ),
                                      label: Text('Upload'),
                                    ),
                          ),
                          if (isUploaded) ...[
                            SizedBox(width: 2.w),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed:
                                    () => _uploadDocument(document['key']),
                                icon: CustomIconWidget(
                                  iconName: 'refresh',
                                  color:
                                      AppTheme.lightTheme.colorScheme.primary,
                                  size: 16,
                                ),
                                label: Text('Retake'),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),

          // Information Card
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
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: 'security',
                  color: AppTheme.lightTheme.colorScheme.primary,
                  size: 20,
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Text(
                    'Your documents are securely encrypted and used only for verification purposes. We comply with all data protection regulations.',
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
