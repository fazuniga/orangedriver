import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../localization/app_localizations.dart';
import '../../../theme/app_theme.dart';

class TripFilterWidget extends StatelessWidget {
  final String selectedDateRange;
  final String searchQuery;
  final Function(String) onDateRangeChanged;
  final Function(String) onSearchChanged;
  final VoidCallback onExportPressed;

  const TripFilterWidget({
    super.key,
    required this.selectedDateRange,
    required this.searchQuery,
    required this.onDateRangeChanged,
    required this.onSearchChanged,
    required this.onExportPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildSearchField()),
              SizedBox(width: 3.w),
              _buildExportButton(),
            ],
          ),
          SizedBox(height: 2.h),
          _buildDateRangeSelector(),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      decoration: InputDecoration(
        hintText: AppLocalizations.get('search_trips'),
        prefixIcon: Icon(Icons.search, color: AppTheme.neutralMedium),
        filled: true,
        fillColor: AppTheme.neutralLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
      ),
      onChanged: onSearchChanged,
    );
  }

  Widget _buildExportButton() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.primaryOrange,
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        onPressed: onExportPressed,
        icon: Icon(Icons.download, color: AppTheme.surfaceWhite),
      ),
    );
  }

  Widget _buildDateRangeSelector() {
    final dateRanges = [
      'Hoy',
      'Esta semana',
      'Este mes',
      'Últimos 3 meses',
      'Personalizado',
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children:
            dateRanges.map((range) {
              final isSelected = selectedDateRange == range;
              return Padding(
                padding: EdgeInsets.only(right: 2.w),
                child: GestureDetector(
                  onTap: () => onDateRangeChanged(range),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                      vertical: 1.h,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? AppTheme.primaryOrange
                              : AppTheme.neutralLight,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color:
                            isSelected
                                ? AppTheme.primaryOrange
                                : AppTheme.neutralMedium.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      range,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color:
                            isSelected
                                ? AppTheme.surfaceWhite
                                : AppTheme.neutralDark,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
