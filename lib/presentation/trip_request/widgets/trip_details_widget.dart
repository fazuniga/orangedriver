import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class TripDetailsWidget extends StatelessWidget {
  final Map<String, dynamic> tripData;
  final bool isExpanded;
  final VoidCallback onToggle;

  const TripDetailsWidget({
    super.key,
    required this.tripData,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.neutralLight, width: 1),
      ),
      child: Column(
        children: [
          // Header
          GestureDetector(
            onTap: onToggle,
            child: Container(
              padding: EdgeInsets.all(4.w),
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'info_outline',
                    color: AppTheme.primaryOrange,
                    size: 20,
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Text(
                      'Trip Details',
                      style: AppTheme.lightTheme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: CustomIconWidget(
                      iconName: 'keyboard_arrow_down',
                      color: AppTheme.neutralMedium,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Expandable content
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: isExpanded ? null : 0,
            child:
                isExpanded
                    ? Container(
                      padding: EdgeInsets.fromLTRB(4.w, 0, 4.w, 4.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(color: AppTheme.neutralLight, thickness: 1),
                          SizedBox(height: 2.h),

                          // Destination
                          if (tripData['destination']?['address'] != null)
                            _buildDetailRow(
                              icon: 'flag',
                              label: 'Destination',
                              value: tripData['destination']['address'],
                              color: AppTheme.successGreen,
                            ),

                          SizedBox(height: 2.h),

                          // Trip type
                          _buildDetailRow(
                            icon: 'directions_car',
                            label: 'Trip Type',
                            value: tripData['tripType'] ?? 'Standard',
                            color: AppTheme.accentBlue,
                          ),

                          SizedBox(height: 2.h),

                          // Estimated duration
                          _buildDetailRow(
                            icon: 'schedule',
                            label: 'Estimated Duration',
                            value: tripData['estimatedDuration'] ?? 'Unknown',
                            color: AppTheme.warningAmber,
                          ),

                          // Special requests
                          if (tripData['specialRequests'] != null &&
                              (tripData['specialRequests'] as List)
                                  .isNotEmpty) ...[
                            SizedBox(height: 2.h),
                            _buildSpecialRequests(),
                          ],

                          SizedBox(height: 2.h),

                          // Trip ID
                          _buildDetailRow(
                            icon: 'confirmation_number',
                            label: 'Trip ID',
                            value: tripData['id'] ?? 'Unknown',
                            color: AppTheme.neutralMedium,
                          ),
                        ],
                      ),
                    )
                    : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required String icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: CustomIconWidget(iconName: icon, color: color, size: 18),
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                  color: AppTheme.neutralMedium,
                ),
              ),
              SizedBox(height: 0.5.h),
              Text(
                value,
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSpecialRequests() {
    final requests = tripData['specialRequests'] as List;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: AppTheme.warningAmber.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomIconWidget(
                iconName: 'priority_high',
                color: AppTheme.warningAmber,
                size: 18,
              ),
            ),
            SizedBox(width: 3.w),
            Text(
              'Special Requests',
              style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                color: AppTheme.neutralMedium,
              ),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        Wrap(
          spacing: 2.w,
          runSpacing: 1.h,
          children:
              requests.map((request) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color: AppTheme.warningAmber.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppTheme.warningAmber.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    request.toString(),
                    style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                      color: AppTheme.warningAmber,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}
