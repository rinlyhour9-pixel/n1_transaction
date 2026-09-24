import 'package:flutter/material.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../shared/widgets/date_filter.dart';
import '../../shared/widgets/ui_components.dart';

class TrackFleetScreen extends StatelessWidget {
  const TrackFleetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: curvedAppBar(l10n.trackFleet),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          SectionHeader(title: l10n.fleetOverview),
          const SizedBox(height: 8),
          MetricGrid(
            children: [
              MetricCard(
                  value: '24',
                  label: l10n.activeVehicles,
                  icon: Icons.local_shipping_outlined,
                  color: AppColors.blue),
              MetricCard(
                  value: '05',
                  label: l10n.moving,
                  icon: Icons.navigation_outlined,
                  color: AppColors.success),
              MetricCard(
                  value: '03',
                  label: l10n.idle,
                  icon: Icons.pause_circle_outline,
                  color: AppColors.warning),
            ],
          ),
          const SizedBox(height: 26),
          SectionHeader(title: l10n.fleetVehicles),
          const SizedBox(height: 8),
          _FleetVehicleCard(
            plate: 'PP 3A-1234',
            vehicleType: l10n.cementTruck,
            driver: 'Dara Sok',
            status: l10n.moving,
            statusColor: AppColors.success,
            location: 'National Road 4, 12 km from Construction Site A',
          ),
          const SizedBox(height: 10),
          _FleetVehicleCard(
            plate: 'PP 2D-9090',
            vehicleType: 'Dump Truck',
            driver: 'Vannak Lim',
            status: l10n.idle,
            statusColor: AppColors.warning,
            location: 'N1 Cement Factory yard',
          ),
          const SizedBox(height: 10),
          _FleetVehicleCard(
            plate: 'PP 5F-2210',
            vehicleType: l10n.cementTruck,
            driver: 'Sochea Ny',
            status: l10n.parked,
            statusColor: AppColors.muted,
            location: 'N1 depot, Phnom Penh',
          ),
        ],
      ),
    );
  }
}

class _FleetVehicleCard extends StatelessWidget {
  const _FleetVehicleCard({
    required this.plate,
    required this.vehicleType,
    required this.driver,
    required this.status,
    required this.statusColor,
    required this.location,
  });
  final String plate, vehicleType, driver, status, location;
  final Color statusColor;

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: .12),
                    borderRadius: BorderRadius.circular(12)),
                child: Icon(Icons.local_shipping_outlined, color: statusColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$plate · $vehicleType',
                        style: const TextStyle(fontWeight: FontWeight.w900)),
                    const SizedBox(height: 2),
                    Text(driver,
                        style: const TextStyle(
                            color: AppColors.muted, fontSize: 12)),
                  ],
                ),
              ),
              StatusBadge(label: status, color: statusColor),
            ]),
            const SizedBox(height: 12),
            Row(children: [
              const Icon(Icons.location_on_outlined,
                  size: 18, color: AppColors.muted),
              const SizedBox(width: 6),
              Expanded(
                  child:
                      Text(location, style: const TextStyle(fontSize: 13))),
            ]),
          ]),
        ),
      );
}

class _TripReport {
  const _TripReport({
    required this.id,
    required this.route,
    required this.material,
    required this.status,
    required this.statusColor,
    required this.date,
  });
  final String id, route, material, status;
  final Color statusColor;
  final DateTime date;
}

class TripReportsScreen extends StatefulWidget {
  const TripReportsScreen({super.key});

  @override
  State<TripReportsScreen> createState() => _TripReportsScreenState();
}

class _TripReportsScreenState extends State<TripReportsScreen> {
  int? day;
  int? month;
  int? year;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final reports = [
      _TripReport(
        id: 'N1-2034',
        route: 'N1 Factory  →  Construction Site A',
        material: 'Cement · 25 Tons',
        status: l10n.inTransit,
        statusColor: AppColors.info,
        date: DateTime.now(),
      ),
      _TripReport(
        id: 'N1-2029',
        route: 'Factory B  →  Warehouse C',
        material: 'Cement · 18 Tons',
        status: l10n.completed,
        statusColor: AppColors.success,
        date: DateTime(2026, 9, 20, 15, 10),
      ),
      _TripReport(
        id: 'N1-2027',
        route: 'Factory B  →  Warehouse C',
        material: 'Soil · 22 Tons',
        status: l10n.completed,
        statusColor: AppColors.success,
        date: DateTime(2026, 9, 18, 9, 45),
      ),
      _TripReport(
        id: 'N1-2011',
        route: 'N1 Factory  →  Warehouse C',
        material: 'Cement · 20 Tons',
        status: l10n.completed,
        statusColor: AppColors.success,
        date: DateTime(2026, 8, 4, 11, 20),
      ),
      _TripReport(
        id: 'N1-1958',
        route: 'Factory B  →  Construction Site A',
        material: 'Soil · 16 Tons',
        status: l10n.completed,
        statusColor: AppColors.success,
        date: DateTime(2025, 12, 18, 14, 5),
      ),
    ];
    final years = reports.map((r) => r.date.year).toSet().toList()
      ..sort((a, b) => b.compareTo(a));
    final filtered = reports
        .where((r) =>
            matchesDateFilter(r.date, day: day, month: month, year: year))
        .toList();

    return Scaffold(
      appBar: curvedAppBar(l10n.tripReports),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          SectionHeader(title: l10n.reportsOverview),
          const SizedBox(height: 8),
          MetricGrid(
            children: [
              MetricCard(
                  value: '142',
                  label: l10n.tripsThisMonth,
                  icon: Icons.route_outlined,
                  color: AppColors.blue),
              MetricCard(
                  value: '96%',
                  label: l10n.onTimeRate,
                  icon: Icons.verified_outlined,
                  color: AppColors.success),
              MetricCard(
                  value: '48 min',
                  label: l10n.avgDeliveryTime,
                  icon: Icons.timer_outlined,
                  color: const Color(0xFF7557D9)),
            ],
          ),
          const SizedBox(height: 26),
          SectionHeader(title: l10n.recentReports),
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
                title: l10n.noTripsFound,
                message: l10n.tryAnotherSearch,
              ),
            )
          else
            for (final report in filtered) ...[
              _TripReportCard(
                id: report.id,
                route: report.route,
                material: report.material,
                status: report.status,
                statusColor: report.statusColor,
                date: formatReportDate(context, report.date),
              ),
              const SizedBox(height: 10),
            ],
        ],
      ),
    );
  }
}

class _TripReportCard extends StatelessWidget {
  const _TripReportCard({
    required this.id,
    required this.route,
    required this.material,
    required this.status,
    required this.statusColor,
    required this.date,
  });
  final String id, route, material, status, date;
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
            child: Icon(Icons.description_outlined, color: statusColor),
          ),
          title: Text('$id · $route',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w800)),
          subtitle: Text('$material · $date'),
          trailing: StatusBadge(label: status, color: statusColor),
        ),
      );
}
