import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class DocumentsSectionWidget extends StatelessWidget {
  final Map<String, dynamic> documentsData;
  final VoidCallback onUploadLicense;
  final VoidCallback onUploadInsurance;
  final VoidCallback onUploadRegistration;

  const DocumentsSectionWidget({
    super.key,
    required this.documentsData,
    required this.onUploadLicense,
    required this.onUploadInsurance,
    required this.onUploadRegistration,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Documentos',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 3.h),

            _buildDocumentItem(
              context,
              'Licencia de Conducir',
              documentsData['license'] ?? {},
              'description',
              onUploadLicense,
            ),

            Divider(height: 4.h),

            _buildDocumentItem(
              context,
              'Seguro del Vehículo',
              documentsData['insurance'] ?? {},
              'shield',
              onUploadInsurance,
            ),

            Divider(height: 4.h),

            _buildDocumentItem(
              context,
              'Registro del Vehículo',
              documentsData['registration'] ?? {},
              'assignment',
              onUploadRegistration,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentItem(
    BuildContext context,
    String title,
    Map<String, dynamic> documentData,
    String iconName,
    VoidCallback onTap,
  ) {
    final bool isVerified = documentData['verified'] ?? false;
    final String status = documentData['status'] ?? 'pending';
    final String? expiryDate = documentData['expiryDate'];

    Color statusColor;
    String statusText;
    IconData statusIcon;

    switch (status) {
      case 'verified':
        statusColor = AppTheme.successGreen;
        statusText = 'Verificado';
        statusIcon = Icons.check_circle;
        break;
      case 'pending':
        statusColor = AppTheme.warningAmber;
        statusText = 'Pendiente';
        statusIcon = Icons.access_time;
        break;
      case 'rejected':
        statusColor = AppTheme.errorRed;
        statusText = 'Rechazado';
        statusIcon = Icons.error;
        break;
      default:
        statusColor = AppTheme.neutralMedium;
        statusText = 'No subido';
        statusIcon = Icons.upload_file;
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Row(
          children: [
            Container(
              width: 12.w,
              height: 12.w,
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: CustomIconWidget(
                  iconName: iconName,
                  color: statusColor,
                  size: 24,
                ),
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Row(
                    children: [
                      Icon(statusIcon, color: statusColor, size: 16),
                      SizedBox(width: 1.w),
                      Text(
                        statusText,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  if (expiryDate != null && isVerified) ...[
                    SizedBox(height: 0.5.h),
                    Text(
                      'Vence: $expiryDate',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.neutralMedium,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            CustomIconWidget(
              iconName: status == 'verified' ? 'check_circle' : 'upload_file',
              color: statusColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
