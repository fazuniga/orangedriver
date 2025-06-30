import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../localization/app_localizations.dart';
import '../../theme/app_theme.dart';
import './widgets/trip_card_widget.dart';
import './widgets/trip_filter_widget.dart';
import './widgets/trip_statistics_widget.dart';

class TripHistory extends StatefulWidget {
  const TripHistory({super.key});

  @override
  State<TripHistory> createState() => _TripHistoryState();
}

class _TripHistoryState extends State<TripHistory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedDateRange = 'Esta semana';
  String _searchQuery = '';
  List<Map<String, dynamic>> _filteredTrips = [];
  bool _isLoading = false;

  // Mock trip data
  final List<Map<String, dynamic>> _mockTrips = [
    {
      'id': '1',
      'date': '15 Nov 2024, 14:30',
      'passengerName': 'María González',
      'pickupAddress': 'Av. Insurgentes 1234, Roma Norte',
      'dropoffAddress': 'Aeropuerto Internacional CDMX',
      'fare': '\$280.00',
      'rating': 5.0,
      'duration': '35 min',
      'distance': '24.5 km',
      'status': 'completed',
      'baseFare': '50.00',
      'distanceFare': '180.00',
      'timeFare': '35.00',
      'surgeMultiplier': 1.1,
      'surgeFare': '15.00',
      'passengerFeedback': 'Excelente conductor, muy puntual y amable.',
    },
    {
      'id': '2',
      'date': '15 Nov 2024, 09:15',
      'passengerName': 'Carlos López',
      'pickupAddress': 'Polanco, Ciudad de México',
      'dropoffAddress': 'Santa Fe, Ciudad de México',
      'fare': '\$145.50',
      'rating': 4.5,
      'duration': '28 min',
      'distance': '18.2 km',
      'status': 'completed',
      'baseFare': '50.00',
      'distanceFare': '85.50',
      'timeFare': '10.00',
      'surgeMultiplier': 1.0,
      'surgeFare': '0.00',
      'passengerFeedback': null,
    },
    {
      'id': '3',
      'date': '14 Nov 2024, 19:45',
      'passengerName': 'Ana Martínez',
      'pickupAddress': 'Condesa, Ciudad de México',
      'dropoffAddress': 'Coyoacán, Ciudad de México',
      'fare': '\$95.00',
      'rating': 4.8,
      'duration': '22 min',
      'distance': '12.8 km',
      'status': 'cancelled',
      'baseFare': '50.00',
      'distanceFare': '45.00',
      'timeFare': '0.00',
      'surgeMultiplier': 1.0,
      'surgeFare': '0.00',
      'passengerFeedback': null,
    },
    {
      'id': '4',
      'date': '14 Nov 2024, 16:20',
      'passengerName': 'Roberto Silva',
      'pickupAddress': 'Zona Rosa, Ciudad de México',
      'dropoffAddress': 'Del Valle, Ciudad de México',
      'fare': '\$120.00',
      'rating': 3.5,
      'duration': '18 min',
      'distance': '8.5 km',
      'status': 'disputed',
      'baseFare': '50.00',
      'distanceFare': '50.00',
      'timeFare': '20.00',
      'surgeMultiplier': 1.0,
      'surgeFare': '0.00',
      'passengerFeedback':
          'El conductor tomó una ruta más larga de lo necesario.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _filteredTrips = List.from(_mockTrips);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleDateRangeChange(String dateRange) {
    setState(() {
      _selectedDateRange = dateRange;
      _isLoading = true;
    });

    // Simulate loading
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _filterTrips();
        });
      }
    });
  }

  void _handleSearchChange(String query) {
    setState(() {
      _searchQuery = query;
      _filterTrips();
    });
  }

  void _filterTrips() {
    setState(() {
      _filteredTrips =
          _mockTrips.where((trip) {
            final matchesSearch =
                _searchQuery.isEmpty ||
                trip['passengerName'].toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ) ||
                trip['pickupAddress'].toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ) ||
                trip['dropoffAddress'].toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                );

            // Add date range filtering logic here
            return matchesSearch;
          }).toList();
    });
  }

  void _handleExportTrips() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(AppLocalizations.get('export_trips')),
            content: Text(
              '¿Deseas exportar los viajes filtrados en formato PDF o CSV?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(AppLocalizations.get('cancel')),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _exportTripsPDF();
                },
                child: Text('PDF'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _exportTripsCSV();
                },
                child: Text('CSV'),
              ),
            ],
          ),
    );
  }

  void _exportTripsPDF() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Exportando viajes en formato PDF...'),
        backgroundColor: AppTheme.successGreen,
      ),
    );
  }

  void _exportTripsCSV() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Exportando viajes en formato CSV...'),
        backgroundColor: AppTheme.successGreen,
      ),
    );
  }

  void _handleTripDispute(Map<String, dynamic> tripData) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(AppLocalizations.get('dispute_trip')),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Viaje: ${tripData['id']}'),
                Text('Pasajero: ${tripData['passengerName']}'),
                Text('Tarifa: ${tripData['fare']}'),
                SizedBox(height: 2.h),
                Text(
                  '¿Deseas disputar este viaje? Se enviará a revisión del equipo de soporte.',
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(AppLocalizations.get('cancel')),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _submitDispute(tripData);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.errorRed,
                ),
                child: Text('Disputar'),
              ),
            ],
          ),
    );
  }

  void _submitDispute(Map<String, dynamic> tripData) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Disputa enviada para el viaje ${tripData['id']}'),
        backgroundColor: AppTheme.warningAmber,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.get('trip_history')),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: AppLocalizations.get('trips')),
            Tab(text: 'Estadísticas'),
          ],
        ),
      ),
      body: Column(
        children: [
          TripFilterWidget(
            selectedDateRange: _selectedDateRange,
            searchQuery: _searchQuery,
            onDateRangeChanged: _handleDateRangeChange,
            onSearchChanged: _handleSearchChange,
            onExportPressed: _handleExportTrips,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [_buildTripsTab(), _buildStatisticsTab()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTripsTab() {
    if (_isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: AppTheme.primaryOrange),
            SizedBox(height: 2.h),
            Text(
              AppLocalizations.get('loading'),
              style: TextStyle(fontSize: 14.sp, color: AppTheme.neutralMedium),
            ),
          ],
        ),
      );
    }

    if (_filteredTrips.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, size: 64, color: AppTheme.neutralMedium),
            SizedBox(height: 2.h),
            Text(
              'No se encontraron viajes',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppTheme.neutralMedium,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              'Ajusta los filtros para ver más resultados',
              style: TextStyle(
                fontSize: 12.sp,
                color: AppTheme.neutralMedium.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          _isLoading = true;
        });
        await Future.delayed(const Duration(seconds: 1));
        setState(() {
          _isLoading = false;
          _filterTrips();
        });
      },
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 2.h),
        itemCount: _filteredTrips.length,
        itemBuilder: (context, index) {
          final trip = _filteredTrips[index];
          return TripCardWidget(
            tripData: trip,
            onDisputePressed: () => _handleTripDispute(trip),
          );
        },
      ),
    );
  }

  Widget _buildStatisticsTab() {
    final completedTrips =
        _filteredTrips.where((trip) => trip['status'] == 'completed').toList();
    final totalEarnings = completedTrips.fold<double>(0, (sum, trip) {
      final fareString = trip['fare'].replaceAll('\$', '').replaceAll(',', '');
      return sum + double.parse(fareString);
    });

    final averageRating =
        completedTrips.isEmpty
            ? 0.0
            : completedTrips.fold<double>(
                  0,
                  (sum, trip) => sum + trip['rating'],
                ) /
                completedTrips.length;

    return SingleChildScrollView(
      child: Column(
        children: [
          TripStatisticsWidget(
            totalTrips: _filteredTrips.length,
            averageRating: averageRating,
            totalEarnings: '\$${totalEarnings.toStringAsFixed(2)}',
            earningsTrends: {
              'week1': 850.0,
              'week2': 920.0,
              'week3': 1100.0,
              'week4': 980.0,
            },
          ),
        ],
      ),
    );
  }
}
