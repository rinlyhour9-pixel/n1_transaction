import 'package:flutter/material.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../shared/widgets/date_filter.dart';
import '../../shared/widgets/ui_components.dart';

class _FuelRecord {
  const _FuelRecord({
    required this.driver,
    required this.vehicle,
    required this.amount,
    required this.status,
    required this.statusColor,
    required this.date,
  });
  final String driver, vehicle, amount, status;
  final Color statusColor;
  final DateTime date;
}

class FuelReportsScreen extends StatefulWidget {
  const FuelReportsScreen({super.key});

  @override
  State<FuelReportsScreen> createState() => _FuelReportsScreenState();
}

class _FuelReportsScreenState extends State<FuelReportsScreen> {
  int? day;
  int? month;
  int? year;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final records = [
      _FuelRecord(
        driver: 'Dara Sok',
        vehicle: 'PP 3A-1234',
        amount: '120 L',
        status: l10n.statusApproved,
        statusColor: AppColors.success,
        date: DateTime.now(),
      ),
      _FuelRecord(
        driver: 'Vannak Lim',
        vehicle: 'PP 2D-9090',
        amount: '80 L',
        status: l10n.statusPending,
        statusColor: AppColors.warning,
        date: DateTime(2026, 9, 22, 16, 20),
      ),
      _FuelRecord(
        driver: 'Sochea Ny',
        vehicle: 'PP 5F-2210',
        amount: '100 L',
        status: l10n.statusApproved,
        statusColor: AppColors.success,
        date: DateTime(2026, 9, 9, 8, 0),
      ),
      _FuelRecord(
        driver: 'Dara Sok',
        vehicle: 'PP 3A-1234',
        amount: '60 L',
        status: l10n.statusRejected,
        statusColor: AppColors.error,
        date: DateTime(2026, 8, 14, 10, 5),
      ),
      _FuelRecord(
        driver: 'Vannak Lim',
        vehicle: 'PP 2D-9090',
        amount: '150 L',
        status: l10n.statusApproved,
        statusColor: AppColors.success,
        date: DateTime(2025, 12, 2, 7, 30),
      ),
    ];
    final years = records.map((r) => r.date.year).toSet().toList()
      ..sort((a, b) => b.compareTo(a));
    final filtered = records
        .where((r) =>
            matchesDateFilter(r.date, day: day, month: month, year: year))
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.fuelReports)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          SectionHeader(title: l10n.reportsOverview),
          const SizedBox(height: 8),
          MetricGrid(
            children: [
              MetricCard(
                  value: '620 L',
                  label: l10n.totalIssued,
                  icon: Icons.local_gas_station,
                  color: AppColors.warning),
              MetricCard(
                  value: '06',
                  label: l10n.requestsApproved,
                  icon: Icons.task_alt,
                  color: AppColors.success),
              MetricCard(
                  value: '01',
                  label: l10n.requestsRejected,
                  icon: Icons.cancel_outlined,
                  color: AppColors.error),
            ],
          ),
          const SizedBox(height: 26),
          SectionHeader(title: l10n.recentFuelActivity),
          const SizedBox(height: 10),
          DateFilterBar(
            day: day,
            month: month,
            year: year,
            availableYears: years,
            onDayChanged: (value) => setState(() => day = value),
            onMonthChanged: (value) => setState(() => month = value),
            onYearChanged: (value) => setState(() => year = value),
          ),
          const SizedBox(height: 14),
          if (filtered.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: EmptyState(
                title: l10n.noResultsFound,
                message: l10n.tryDifferentFilter,
              ),
            )
          else
            for (final record in filtered) ...[
              _FuelRecordCard(
                driver: record.driver,
                vehicle: record.vehicle,
                amount: record.amount,
                status: record.status,
                statusColor: record.statusColor,
                date: formatReportDate(context, record.date),
              ),
              const SizedBox(height: 10),
            ],
        ],
      ),
    );
  }
}

class _FuelRecordCard extends StatelessWidget {
  const _FuelRecordCard({
    required this.driver,
    required this.vehicle,
    required this.amount,
    required this.status,
    required this.statusColor,
    required this.date,
  });
  final String driver, vehicle, amount, status, date;
  final Color statusColor;

  @override
  Widget build(BuildContext context) => Card(
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
                color: statusColor.withValues(alpha: .12),
                borderRadius: BorderRadius.circular(12)),
            child: Icon(Icons.local_gas_station, color: statusColor),
          ),
          title: Text('$driver · $amount',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w800)),
          subtitle: Text('$vehicle · $date'),
          trailing: StatusBadge(label: status, color: statusColor),
        ),
      );
}
