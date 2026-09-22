import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/models/trip.dart';
import '../../shared/widgets/ui_components.dart';
import '../fuel/fuel_screens.dart';
import '../trips/trip_screens.dart';

class VehicleScreen extends StatelessWidget {
  const VehicleScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('My vehicle')),
        body: Center(
            child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680),
          child: ListView(padding: const EdgeInsets.all(20), children: [
            Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                    color: AppColors.navy,
                    borderRadius: BorderRadius.circular(26)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.local_shipping_outlined,
                          color: Colors.white, size: 64),
                      const SizedBox(height: 24),
                      const Text('ASSIGNED VEHICLE',
                          style: TextStyle(
                              color: Colors.white60,
                              fontSize: 11,
                              letterSpacing: 1.4)),
                      const SizedBox(height: 8),
                      Text(demoTrip.vehicle,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w700)),
                      const SizedBox(height: 4),
                      const Text('Cement Truck',
                          style: TextStyle(color: Colors.white70)),
                    ])),
            const SizedBox(height: 24),
            const SectionHeader(title: 'Vehicle assignment'),
            const SizedBox(height: 12),
            const Card(
                child: Padding(
                    padding: EdgeInsets.all(18),
                    child: Column(children: [
                      InfoRow(
                          icon: Icons.person_outline,
                          label: 'Driver',
                          value: 'Dara Sok'),
                      Divider(),
                      InfoRow(
                          icon: Icons.badge_outlined,
                          label: 'Driver ID',
                          value: 'DR-001'),
                    ]))),
            const SizedBox(height: 24),
            const SectionHeader(title: 'Vehicle activity'),
            const SizedBox(height: 12),
            Card(
                child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading:
                        const Icon(Icons.route_outlined, color: AppColors.blue),
                    title: Text('Assigned trip · ${demoTrip.id}'),
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
                    title: const Text('Fuel requests'),
                    subtitle: const Text('View requests and fuel activity'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const FuelScreen())))),
            const SizedBox(height: 24),
            PrimaryButton(
                label: 'Request fuel',
                icon: Icons.add,
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const FuelRequestScreen()))),
          ]),
        )),
      );
}
