import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class DeclineReasonSheet extends StatefulWidget {
  final Function(String) onReasonSelected;

  const DeclineReasonSheet({super.key, required this.onReasonSelected});

  @override
  State<DeclineReasonSheet> createState() => _DeclineReasonSheetState();
}

class _DeclineReasonSheetState extends State<DeclineReasonSheet> {
  String? _selectedReason;

  final List<Map<String, dynamic>> _declineReasons = [
    {
      "id": "too_far",
      "title": "Too far from pickup",
      "icon": "directions",
      "description": "Pickup location is too far away",
    },
    {
      "id": "wrong_direction",
      "title": "Going wrong direction",
      "icon": "wrong_location",
      "description": "Trip doesn't match my preferred route",
    },
    {
      "id": "break_time",
      "title": "Taking a break",
      "icon": "pause_circle",
      "description": "Need to take a short break",
    },
    {
      "id": "low_fare",
      "title": "Fare too low",
      "icon": "money_off",
      "description": "Trip fare doesn't meet expectations",
    },
    {
      "id": "traffic",
      "title": "Heavy traffic",
      "icon": "traffic",
      "description": "Too much traffic in pickup area",
    },
    {
      "id": "personal",
      "title": "Personal reason",
      "icon": "person",
      "description": "Other personal reasons",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: 2.h),
            width: 12.w,
            height: 0.5.h,
            decoration: BoxDecoration(
              color: AppTheme.neutralLight,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              children: [
                Text(
                  'Why are you declining?',
                  style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  'Help us improve by letting us know why you\'re declining this trip',
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.neutralMedium,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Reasons list
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              itemCount: _declineReasons.length,
              separatorBuilder: (context, index) => SizedBox(height: 1.h),
              itemBuilder: (context, index) {
                final reason = _declineReasons[index];
                final isSelected = _selectedReason == reason['id'];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedReason = reason['id'];
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? AppTheme.primaryOrange.withValues(alpha: 0.1)
                              : AppTheme.lightTheme.cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color:
                            isSelected
                                ? AppTheme.primaryOrange
                                : AppTheme.neutralLight,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(2.w),
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? AppTheme.primaryOrange.withValues(
                                      alpha: 0.2,
                                    )
                                    : AppTheme.neutralLight,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CustomIconWidget(
                            iconName: reason['icon'],
                            color:
                                isSelected
                                    ? AppTheme.primaryOrange
                                    : AppTheme.neutralMedium,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                reason['title'],
                                style: AppTheme.lightTheme.textTheme.titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color:
                                          isSelected
                                              ? AppTheme.primaryOrange
                                              : AppTheme.neutralDark,
                                    ),
                              ),
                              SizedBox(height: 0.5.h),
                              Text(
                                reason['description'],
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(color: AppTheme.neutralMedium),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected)
                          CustomIconWidget(
                            iconName: 'check_circle',
                            color: AppTheme.primaryOrange,
                            size: 24,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Action buttons
          Container(
            padding: EdgeInsets.all(4.w),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel'),
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed:
                          _selectedReason != null
                              ? () {
                                widget.onReasonSelected(_selectedReason!);
                                Navigator.pop(context);
                              }
                              : null,
                      child: Text('Confirm Decline'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
