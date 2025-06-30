import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/earnings_breakdown_widget.dart';
import './widgets/earnings_chart_widget.dart';
import './widgets/earnings_hero_card_widget.dart';
import './widgets/goals_section_widget.dart';
import './widgets/metrics_scroll_widget.dart';
import './widgets/recent_payouts_widget.dart';
import './widgets/tax_summary_widget.dart';

class EarningsDashboard extends StatefulWidget {
  const EarningsDashboard({super.key});

  @override
  State<EarningsDashboard> createState() => _EarningsDashboardState();
}

class _EarningsDashboardState extends State<EarningsDashboard>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String _selectedPeriod = 'Weekly';
  bool _isRefreshing = false;

  // Mock data for earnings dashboard
  final Map<String, dynamic> _mockEarningsData = {
    "currentPeriodEarnings": 1247.50,
    "previousPeriodEarnings": 1156.25,
    "percentageChange": 7.9,
    "breakdown": {
      "tripFares": 987.50,
      "tips": 156.75,
      "bonuses": 78.25,
      "surgeEarnings": 25.00,
    },
    "chartData": [
      {"day": "Mon", "earnings": 178.50},
      {"day": "Tue", "earnings": 203.25},
      {"day": "Wed", "earnings": 156.75},
      {"day": "Thu", "earnings": 234.50},
      {"day": "Fri", "earnings": 289.75},
      {"day": "Sat", "earnings": 184.75},
      {"day": "Sun", "earnings": 0.00},
    ],
    "metrics": {
      "totalTrips": 47,
      "averageFare": 21.01,
      "highestEarningDay": "Friday - \$289.75",
      "hoursOnline": 32.5,
    },
    "goals": {
      "weeklyTarget": 1500.00,
      "monthlyTarget": 6000.00,
      "weeklyProgress": 0.83,
      "monthlyProgress": 0.67,
    },
    "recentPayouts": [
      {
        "date": "2024-01-15",
        "amount": 1156.25,
        "status": "Completed",
        "bankAccount": "****1234",
      },
      {
        "date": "2024-01-08",
        "amount": 1089.50,
        "status": "Completed",
        "bankAccount": "****1234",
      },
      {
        "date": "2024-01-01",
        "amount": 1247.50,
        "status": "Pending",
        "bankAccount": "****1234",
      },
    ],
    "taxSummary": {
      "yearToDateEarnings": 15678.90,
      "estimatedTaxes": 3135.78,
      "deductibleExpenses": 2456.32,
    },
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _isRefreshing = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isRefreshing = false;
    });
  }

  void _onPeriodChanged(String period) {
    setState(() {
      _selectedPeriod = period;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppTheme.lightTheme.appBarTheme.backgroundColor,
      elevation: AppTheme.lightTheme.appBarTheme.elevation,
      title: Text(
        'Earnings',
        style: AppTheme.lightTheme.appBarTheme.titleTextStyle,
      ),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: CustomIconWidget(
          iconName: 'arrow_back',
          color: AppTheme.lightTheme.colorScheme.onSurface,
          size: 24,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            // Export functionality
            _showExportDialog();
          },
          icon: CustomIconWidget(
            iconName: 'file_download',
            color: AppTheme.lightTheme.colorScheme.onSurface,
            size: 24,
          ),
        ),
      ],
      bottom: TabBar(
        controller: _tabController,
        tabs: const [
          Tab(text: 'Dashboard'),
          Tab(text: 'Earnings'),
          Tab(text: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildPlaceholderTab('Dashboard'),
        _buildEarningsTab(),
        _buildPlaceholderTab('Profile'),
      ],
    );
  }

  Widget _buildPlaceholderTab(String tabName) {
    return Center(
      child: Text(
        '$tabName Content',
        style: AppTheme.lightTheme.textTheme.titleLarge,
      ),
    );
  }

  Widget _buildEarningsTab() {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      color: AppTheme.lightTheme.colorScheme.primary,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPeriodSelector(),
            SizedBox(height: 3.h),
            EarningsHeroCardWidget(
              currentEarnings:
                  _mockEarningsData["currentPeriodEarnings"] as double,
              percentageChange: _mockEarningsData["percentageChange"] as double,
              period: _selectedPeriod,
              isRefreshing: _isRefreshing,
            ),
            SizedBox(height: 3.h),
            EarningsBreakdownWidget(
              breakdown: _mockEarningsData["breakdown"] as Map<String, dynamic>,
            ),
            SizedBox(height: 3.h),
            EarningsChartWidget(
              chartData:
                  (_mockEarningsData["chartData"] as List)
                      .map((item) => item as Map<String, dynamic>)
                      .toList(),
              period: _selectedPeriod,
            ),
            SizedBox(height: 3.h),
            MetricsScrollWidget(
              metrics: _mockEarningsData["metrics"] as Map<String, dynamic>,
            ),
            SizedBox(height: 3.h),
            GoalsSectionWidget(
              goals: _mockEarningsData["goals"] as Map<String, dynamic>,
            ),
            SizedBox(height: 3.h),
            RecentPayoutsWidget(
              payouts:
                  (_mockEarningsData["recentPayouts"] as List)
                      .map((item) => item as Map<String, dynamic>)
                      .toList(),
            ),
            SizedBox(height: 3.h),
            TaxSummaryWidget(
              taxSummary:
                  _mockEarningsData["taxSummary"] as Map<String, dynamic>,
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodSelector() {
    final periods = ['Daily', 'Weekly', 'Monthly'];

    return Container(
      padding: EdgeInsets.all(1.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline,
          width: 1,
        ),
      ),
      child: Row(
        children:
            periods.map((period) {
              final isSelected = period == _selectedPeriod;
              return Expanded(
                child: GestureDetector(
                  onTap: () => _onPeriodChanged(period),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? AppTheme.lightTheme.colorScheme.primary
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      period,
                      textAlign: TextAlign.center,
                      style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                        color:
                            isSelected
                                ? AppTheme.lightTheme.colorScheme.onPrimary
                                : AppTheme.lightTheme.colorScheme.onSurface,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }

  void _showExportDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Export Earnings Report',
            style: AppTheme.lightTheme.textTheme.titleLarge,
          ),
          content: Text(
            'Generate a tax-ready PDF report of your earnings?',
            style: AppTheme.lightTheme.textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Implement export functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Earnings report exported successfully'),
                    backgroundColor: AppTheme.lightTheme.colorScheme.primary,
                  ),
                );
              },
              child: Text('Export PDF'),
            ),
          ],
        );
      },
    );
  }
}
