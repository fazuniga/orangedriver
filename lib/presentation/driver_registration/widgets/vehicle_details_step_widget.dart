import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class VehicleDetailsStepWidget extends StatefulWidget {
  final Function(Map<String, dynamic>) onDataChanged;
  final Map<String, dynamic> initialData;

  const VehicleDetailsStepWidget({
    super.key,
    required this.onDataChanged,
    required this.initialData,
  });

  @override
  State<VehicleDetailsStepWidget> createState() =>
      _VehicleDetailsStepWidgetState();
}

class _VehicleDetailsStepWidgetState extends State<VehicleDetailsStepWidget> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _licensePlateController;

  String? _selectedMake;
  String? _selectedModel;
  int? _selectedYear;
  String? _selectedColor;

  final List<String> _vehicleMakes = [
    'Toyota',
    'Honda',
    'Ford',
    'Chevrolet',
    'Nissan',
    'BMW',
    'Mercedes-Benz',
    'Audi',
    'Volkswagen',
    'Hyundai',
    'Kia',
    'Mazda',
    'Subaru',
    'Lexus',
    'Acura',
    'Infiniti',
    'Cadillac',
    'Lincoln',
    'Buick',
    'GMC',
    'Jeep',
    'Ram',
    'Chrysler',
    'Dodge',
    'Mitsubishi',
    'Volvo',
    'Jaguar',
    'Land Rover',
    'Porsche',
    'Tesla',
    'Other',
  ];

  final Map<String, List<String>> _vehicleModels = {
    'Toyota': [
      'Camry',
      'Corolla',
      'Prius',
      'RAV4',
      'Highlander',
      'Sienna',
      'Avalon',
      'Other',
    ],
    'Honda': [
      'Civic',
      'Accord',
      'CR-V',
      'Pilot',
      'Odyssey',
      'Fit',
      'HR-V',
      'Other',
    ],
    'Ford': [
      'F-150',
      'Escape',
      'Explorer',
      'Focus',
      'Fusion',
      'Edge',
      'Expedition',
      'Other',
    ],
    'Chevrolet': [
      'Silverado',
      'Equinox',
      'Malibu',
      'Traverse',
      'Tahoe',
      'Suburban',
      'Impala',
      'Other',
    ],
    'Nissan': [
      'Altima',
      'Sentra',
      'Rogue',
      'Pathfinder',
      'Murano',
      'Maxima',
      'Armada',
      'Other',
    ],
    'Other': ['Other'],
  };

  final List<String> _vehicleColors = [
    'White',
    'Black',
    'Silver',
    'Gray',
    'Red',
    'Blue',
    'Green',
    'Brown',
    'Orange',
    'Yellow',
    'Purple',
    'Pink',
    'Gold',
    'Beige',
    'Maroon',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    _licensePlateController = TextEditingController(
      text: widget.initialData['licensePlate'] ?? '',
    );
    _selectedMake = widget.initialData['make'];
    _selectedModel = widget.initialData['model'];
    _selectedYear = widget.initialData['year'];
    _selectedColor = widget.initialData['color'];

    _licensePlateController.addListener(_updateData);
  }

  @override
  void dispose() {
    _licensePlateController.dispose();
    super.dispose();
  }

  void _updateData() {
    final data = {
      'make': _selectedMake,
      'model': _selectedModel,
      'year': _selectedYear,
      'color': _selectedColor,
      'licensePlate': _licensePlateController.text,
    };
    widget.onDataChanged(data);
  }

  List<int> _getYearsList() {
    final currentYear = DateTime.now().year;
    return List.generate(30, (index) => currentYear - index);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Vehicle Information',
              style: AppTheme.lightTheme.textTheme.headlineSmall,
            ),
            SizedBox(height: 1.h),
            Text(
              'Please provide details about the vehicle you\'ll be using for rides.',
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 4.h),

            // Vehicle Make Dropdown
            DropdownButtonFormField<String>(
              value: _selectedMake,
              decoration: InputDecoration(
                labelText: 'Vehicle Make',
                hintText: 'Select vehicle make',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(3.w),
                  child: CustomIconWidget(
                    iconName: 'directions_car',
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                ),
              ),
              items:
                  _vehicleMakes.map((make) {
                    return DropdownMenuItem<String>(
                      value: make,
                      child: Text(make),
                    );
                  }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedMake = value;
                  _selectedModel = null; // Reset model when make changes
                });
                _updateData();
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select vehicle make';
                }
                return null;
              },
            ),
            SizedBox(height: 3.h),

            // Vehicle Model Dropdown
            DropdownButtonFormField<String>(
              value: _selectedModel,
              decoration: InputDecoration(
                labelText: 'Vehicle Model',
                hintText: 'Select vehicle model',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(3.w),
                  child: CustomIconWidget(
                    iconName: 'car_rental',
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                ),
              ),
              items:
                  _selectedMake != null
                      ? (_vehicleModels[_selectedMake] ?? ['Other']).map((
                        model,
                      ) {
                        return DropdownMenuItem<String>(
                          value: model,
                          child: Text(model),
                        );
                      }).toList()
                      : [],
              onChanged:
                  _selectedMake != null
                      ? (value) {
                        setState(() {
                          _selectedModel = value;
                        });
                        _updateData();
                      }
                      : null,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select vehicle model';
                }
                return null;
              },
            ),
            SizedBox(height: 3.h),

            // Vehicle Year and Color Row
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: _selectedYear,
                    decoration: InputDecoration(
                      labelText: 'Year',
                      hintText: 'Select year',
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(3.w),
                        child: CustomIconWidget(
                          iconName: 'calendar_today',
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                          size: 20,
                        ),
                      ),
                    ),
                    items:
                        _getYearsList().map((year) {
                          return DropdownMenuItem<int>(
                            value: year,
                            child: Text(year.toString()),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedYear = value;
                      });
                      _updateData();
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select year';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedColor,
                    decoration: InputDecoration(
                      labelText: 'Color',
                      hintText: 'Select color',
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(3.w),
                        child: CustomIconWidget(
                          iconName: 'palette',
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                          size: 20,
                        ),
                      ),
                    ),
                    items:
                        _vehicleColors.map((color) {
                          return DropdownMenuItem<String>(
                            value: color,
                            child: Text(color),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedColor = value;
                      });
                      _updateData();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select color';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.h),

            // License Plate Field
            TextFormField(
              controller: _licensePlateController,
              decoration: InputDecoration(
                labelText: 'License Plate Number',
                hintText: 'Enter license plate number',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(3.w),
                  child: CustomIconWidget(
                    iconName: 'confirmation_number',
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                ),
              ),
              textCapitalization: TextCapitalization.characters,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9]')),
                LengthLimitingTextInputFormatter(10),
              ],
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter license plate number';
                }
                if (value.length < 3) {
                  return 'License plate must be at least 3 characters';
                }
                return null;
              },
            ),
            SizedBox(height: 4.h),

            // Vehicle Preview Card
            if (_selectedMake != null &&
                _selectedModel != null &&
                _selectedYear != null &&
                _selectedColor != null) ...[
              Card(
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CustomIconWidget(
                            iconName: 'directions_car',
                            color: AppTheme.lightTheme.colorScheme.primary,
                            size: 24,
                          ),
                          SizedBox(width: 3.w),
                          Text(
                            'Vehicle Summary',
                            style: AppTheme.lightTheme.textTheme.titleMedium,
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      _buildSummaryRow('Make', _selectedMake!),
                      _buildSummaryRow('Model', _selectedModel!),
                      _buildSummaryRow('Year', _selectedYear!.toString()),
                      _buildSummaryRow('Color', _selectedColor!),
                      if (_licensePlateController.text.isNotEmpty)
                        _buildSummaryRow(
                          'License Plate',
                          _licensePlateController.text.toUpperCase(),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 4.h),
            ],

            // Requirements Card
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: AppTheme.warningAmber.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.warningAmber.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'warning',
                        color: AppTheme.warningAmber,
                        size: 20,
                      ),
                      SizedBox(width: 3.w),
                      Text(
                        'Vehicle Requirements',
                        style: AppTheme.lightTheme.textTheme.titleSmall
                            ?.copyWith(
                              color: AppTheme.warningAmber,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  ...[
                    'Vehicle must be 2010 or newer',
                    'Must have 4 doors and seat at least 4 passengers',
                    'Vehicle must pass safety inspection',
                    'Commercial insurance required',
                    'Clean driving record required',
                  ].map((requirement) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 1.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomIconWidget(
                            iconName: 'check_circle',
                            color: AppTheme.successGreen,
                            size: 16,
                          ),
                          SizedBox(width: 2.w),
                          Expanded(
                            child: Text(
                              requirement,
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
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
          ),
          Text(
            value,
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
