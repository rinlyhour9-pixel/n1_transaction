import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/models/trip.dart';
import '../../shared/widgets/ui_components.dart';
import '../../l10n/generated/app_localizations.dart';
import '../fuel/fuel_screens.dart';
import '../trips/trip_screens.dart';

class VehicleScreen extends StatelessWidget {
  const VehicleScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: curvedAppBar(l10n.myVehicle),
        body: Center(
            child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680),
          child: ListView(padding: const EdgeInsets.all(20), children: [
            Card(
                child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                  color: AppColors.navy.withValues(alpha: .1),
                                  borderRadius: BorderRadius.circular(16)),
                              child: const Icon(Icons.local_shipping_outlined,
                                  color: AppColors.navy, size: 32)),
                          const SizedBox(height: 20),
                          Text(l10n.assignedVehicle,
                              style: const TextStyle(
                                  color: AppColors.muted,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.4)),
                          const SizedBox(height: 8),
                          Text(demoTrip.vehicle,
                              style: const TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.w800)),
                          const SizedBox(height: 4),
                          Text(l10n.cementTruck,
                              style: const TextStyle(color: AppColors.muted)),
                        ]))),
            const SizedBox(height: 24),
            SectionHeader(title: l10n.vehicleAssignment),
            const SizedBox(height: 12),
            Card(
                child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(children: [
                      InfoRow(
                          icon: Icons.person_outline,
                          label: l10n.driverLabel,
                          value: 'Dara Sok'),
                      const Divider(),
                      InfoRow(
                          icon: Icons.badge_outlined,
                          label: l10n.driverIdLabel,
                          value: 'DR-001'),
                    ]))),
            const SizedBox(height: 24),
            SectionHeader(title: l10n.vehicleActivity),
            const SizedBox(height: 12),
            Card(
                child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading:
                        const Icon(Icons.route_outlined, color: AppColors.blue),
                    title: Text(l10n.assignedTripLabel(demoTrip.id)),
                    subtitle:
                        Text('${demoTrip.material} · ${demoTrip.quantity}'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const TripDetailScreen())))),
            const SizedBox(height: 12),
            Card(
                child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: const Icon(Icons.local_gas_station_outlined,
                        color: AppColors.warning),
                    title: Text(l10n.fuelRequestsLabel),
                    subtitle: Text(l10n.viewRequestsSubtitle),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const FuelScreen())))),
            const SizedBox(height: 24),
            PrimaryButton(
                label: l10n.requestFuel,
                icon: Icons.add,
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const FuelRequestScreen()))),
          ]),
        )),
      );
  }
}
