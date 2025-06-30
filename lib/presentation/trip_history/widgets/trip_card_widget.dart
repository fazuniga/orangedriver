import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../localization/app_localizations.dart';
import '../../../theme/app_theme.dart';

enum TripStatus { completed, cancelled, disputed }

class TripCardWidget extends StatefulWidget {
  final Map<String, dynamic> tripData;
  final VoidCallback? onTap;
  final VoidCallback? onDisputePressed;

  const TripCardWidget({
    super.key,
    required this.tripData,
    this.onTap,
    this.onDisputePressed,
  });

  @override
  State<TripCardWidget> createState() => _TripCardWidgetState();
}

class _TripCardWidgetState extends State<TripCardWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final tripStatus = _getTripStatus(widget.tripData['status']);

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
              widget.onTap?.call();
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                children: [
                  _buildTripHeader(tripStatus),
                  SizedBox(height: 2.h),
                  _buildTripDetails(),
                ],
              ),
            ),
          ),
          if (_isExpanded) _buildExpandedContent(),
        ],
      ),
    );
  }

  Widget _buildTripHeader(TripStatus status) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.tripData['date'],
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppTheme.neutralDark,
              ),
            ),
            Text(
              widget.tripData['passengerName'],
              style: TextStyle(fontSize: 14.sp, color: AppTheme.neutralMedium),
            ),
          ],
        ),
        Row(
          children: [
            _buildStatusBadge(status),
            SizedBox(width: 2.w),
            Icon(
              _isExpanded ? Icons.expand_less : Icons.expand_more,
              color: AppTheme.neutralMedium,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusBadge(TripStatus status) {
    Color color;
    String text;

    switch (status) {
      case TripStatus.completed:
        color = AppTheme.successGreen;
        text = AppLocalizations.get('completed');
        break;
      case TripStatus.cancelled:
        color = AppTheme.neutralMedium;
        text = AppLocalizations.get('cancelled');
        break;
      case TripStatus.disputed:
        color = AppTheme.errorRed;
        text = AppLocalizations.get('disputed');
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }

  Widget _buildTripDetails() {
    return Column(
      children: [
        _buildAddressRow(
          icon: Icons.my_location,
          address: widget.tripData['pickupAddress'],
          color: AppTheme.successGreen,
        ),
        SizedBox(height: 1.h),
        _buildAddressRow(
          icon: Icons.location_on,
          address: widget.tripData['dropoffAddress'],
          color: AppTheme.errorRed,
        ),
        SizedBox(height: 2.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildInfoChip(
              icon: Icons.star,
              text: widget.tripData['rating'].toString(),
              color: AppTheme.warningAmber,
            ),
            _buildInfoChip(
              icon: Icons.attach_money,
              text: widget.tripData['fare'],
              color: AppTheme.successGreen,
            ),
            _buildInfoChip(
              icon: Icons.access_time,
              text: widget.tripData['duration'],
              color: AppTheme.accentBlue,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAddressRow({
    required IconData icon,
    required String address,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(icon, color: color, size: 16),
        SizedBox(width: 2.w),
        Expanded(
          child: Text(
            address,
            style: TextStyle(fontSize: 12.sp, color: AppTheme.neutralMedium),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 14),
          SizedBox(width: 1.w),
          Text(
            text,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedContent() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.neutralLight,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMapPreview(),
          SizedBox(height: 2.h),
          _buildFareBreakdown(),
          if (widget.tripData['passengerFeedback'] != null) ...[
            SizedBox(height: 2.h),
            _buildPassengerFeedback(),
          ],
          SizedBox(height: 2.h),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildMapPreview() {
    return Container(
      height: 15.h,
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.neutralMedium.withValues(alpha: 0.2),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.route, size: 32, color: AppTheme.neutralMedium),
            SizedBox(height: 1.h),
            Text(
              'Ruta del viaje',
              style: TextStyle(fontSize: 12.sp, color: AppTheme.neutralMedium),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFareBreakdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.get('fare_breakdown'),
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppTheme.neutralDark,
          ),
        ),
        SizedBox(height: 1.h),
        _buildFareRow('Tarifa base', '\$${widget.tripData['baseFare']}'),
        _buildFareRow('Distancia', '\$${widget.tripData['distanceFare']}'),
        _buildFareRow('Tiempo', '\$${widget.tripData['timeFare']}'),
        if (widget.tripData['surgeMultiplier'] > 1.0)
          _buildFareRow(
            '${AppLocalizations.get('surge_multiplier')} (${widget.tripData['surgeMultiplier']}x)',
            '\$${widget.tripData['surgeFare']}',
          ),
        Divider(),
        _buildFareRow('Total', widget.tripData['fare'], isTotal: true),
      ],
    );
  }

  Widget _buildFareRow(String label, String amount, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
              color: AppTheme.neutralMedium,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
              color: isTotal ? AppTheme.neutralDark : AppTheme.neutralMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPassengerFeedback() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.get('passenger_feedback'),
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppTheme.neutralDark,
          ),
        ),
        SizedBox(height: 1.h),
        Container(
          padding: EdgeInsets.all(3.w),
          decoration: BoxDecoration(
            color: AppTheme.surfaceWhite,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppTheme.neutralMedium.withValues(alpha: 0.2),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ...List.generate(5, (index) {
                    return Icon(
                      Icons.star,
                      size: 16,
                      color:
                          index < widget.tripData['rating']
                              ? AppTheme.warningAmber
                              : AppTheme.neutralMedium.withValues(alpha: 0.3),
                    );
                  }),
                  SizedBox(width: 2.w),
                  Text(
                    widget.tripData['rating'].toString(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.neutralMedium,
                    ),
                  ),
                ],
              ),
              if (widget.tripData['passengerFeedback'] != null) ...[
                SizedBox(height: 1.h),
                Text(
                  widget.tripData['passengerFeedback'],
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppTheme.neutralMedium,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        if (widget.tripData['status'] == 'completed')
          Expanded(
            child: OutlinedButton.icon(
              onPressed: widget.onDisputePressed,
              icon: Icon(Icons.report_problem, size: 16),
              label: Text(AppLocalizations.get('dispute_trip')),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.errorRed,
                side: BorderSide(color: AppTheme.errorRed),
              ),
            ),
          ),
        if (widget.tripData['passengerFeedback'] != null) ...[
          if (widget.tripData['status'] == 'completed') SizedBox(width: 2.w),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // Open response dialog
              },
              icon: Icon(Icons.reply, size: 16),
              label: Text(AppLocalizations.get('respond_to_feedback')),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.accentBlue,
              ),
            ),
          ),
        ],
      ],
    );
  }

  TripStatus _getTripStatus(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return TripStatus.completed;
      case 'cancelled':
        return TripStatus.cancelled;
      case 'disputed':
        return TripStatus.disputed;
      default:
        return TripStatus.completed;
    }
  }
}
