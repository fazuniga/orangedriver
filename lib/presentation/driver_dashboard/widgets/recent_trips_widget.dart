import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class RecentTripsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> trips;

  const RecentTripsWidget({super.key, required this.trips});

  void _showTripDetails(BuildContext context, Map<String, dynamic> trip) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            height: 60.h,
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.cardColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            padding: EdgeInsets.all(6.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle bar
                Center(
                  child: Container(
                    width: 12.w,
                    height: 0.5.h,
                    decoration: BoxDecoration(
                      color: AppTheme.neutralMedium,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  'Trip Details',
                  style: AppTheme.lightTheme.textTheme.titleLarge,
                ),
                SizedBox(height: 3.h),
                _buildDetailRow('Trip ID', trip["id"] as String),
                _buildDetailRow('Passenger', trip["passengerName"] as String),
                _buildDetailRow('Pickup', trip["pickup"] as String),
                _buildDetailRow('Drop-off', trip["dropoff"] as String),
                _buildDetailRow('Duration', trip["duration"] as String),
                _buildDetailRow('Earnings', trip["earnings"] as String),
                _buildDetailRow('Rating', '${trip["rating"]} stars'),
                _buildDetailRow('Completed', trip["timestamp"] as String),
                SizedBox(height: 3.h),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Close'),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Contacting support...')),
                          );
                        },
                        child: Text('Contact Support'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 25.w,
            child: Text(
              label,
              style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                color: AppTheme.neutralMedium,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _contactSupport(BuildContext context, Map<String, dynamic> trip) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Contacting support for trip ${trip["id"]}...'),
        backgroundColor: AppTheme.primaryOrange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          trips
              .map(
                (trip) => Dismissible(
                  key: Key(trip["id"] as String),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 4.w),
                    margin: EdgeInsets.only(bottom: 2.h),
                    decoration: BoxDecoration(
                      color: AppTheme.accentBlue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIconWidget(
                          iconName: 'support_agent',
                          color: AppTheme.onPrimaryLight,
                          size: 24,
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          'Support',
                          style: AppTheme.lightTheme.textTheme.labelSmall
                              ?.copyWith(color: AppTheme.onPrimaryLight),
                        ),
                      ],
                    ),
                  ),
                  confirmDismiss: (direction) async {
                    _contactSupport(context, trip);
                    return false; // Don't actually dismiss
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 2.h),
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppTheme.dividerLight,
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.shadowLight,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () => _showTripDetails(context, trip),
                      borderRadius: BorderRadius.circular(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  trip["passengerName"] as String,
                                  style: AppTheme
                                      .lightTheme
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 2.w,
                                  vertical: 0.5.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppTheme.successGreen.withValues(
                                    alpha: 0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  trip["earnings"] as String,
                                  style: AppTheme
                                      .lightTheme
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                        color: AppTheme.successGreen,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 1.h),

                          // Trip Route
                          Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 3.w,
                                    height: 3.w,
                                    decoration: BoxDecoration(
                                      color: AppTheme.primaryOrange,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Container(
                                    width: 1,
                                    height: 4.h,
                                    color: AppTheme.dividerLight,
                                  ),
                                  Container(
                                    width: 3.w,
                                    height: 3.w,
                                    decoration: BoxDecoration(
                                      color: AppTheme.successGreen,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 3.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      trip["pickup"] as String,
                                      style:
                                          AppTheme
                                              .lightTheme
                                              .textTheme
                                              .bodyMedium,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 3.h),
                                    Text(
                                      trip["dropoff"] as String,
                                      style:
                                          AppTheme
                                              .lightTheme
                                              .textTheme
                                              .bodyMedium,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),

                          // Trip Stats
                          Row(
                            children: [
                              // Rating
                              Row(
                                children: [
                                  CustomIconWidget(
                                    iconName: 'star',
                                    color: AppTheme.warningAmber,
                                    size: 16,
                                  ),
                                  SizedBox(width: 1.w),
                                  Text(
                                    '${trip["rating"]}',
                                    style: AppTheme
                                        .lightTheme
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              SizedBox(width: 4.w),
                              // Duration
                              Row(
                                children: [
                                  CustomIconWidget(
                                    iconName: 'access_time',
                                    color: AppTheme.neutralMedium,
                                    size: 16,
                                  ),
                                  SizedBox(width: 1.w),
                                  Text(
                                    trip["duration"] as String,
                                    style:
                                        AppTheme
                                            .lightTheme
                                            .textTheme
                                            .labelMedium,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Text(
                                trip["timestamp"] as String,
                                style: AppTheme.lightTheme.textTheme.labelSmall
                                    ?.copyWith(color: AppTheme.neutralMedium),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
    );
  }
}
