import 'package:flutter/material.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/models/trip.dart';
import '../../shared/widgets/ui_components.dart';
import '../../shared/widgets/trip_presentation.dart';
import '../fuel/fuel_screens.dart';
import '../profile/profile_screen.dart';
import '../trips/trip_screens.dart';

class DriverShell extends StatefulWidget {
  const DriverShell({super.key, required this.onThemeChanged, this.onLogout});
  final VoidCallback onThemeChanged;
  final VoidCallback? onLogout;
  @override
  State<DriverShell> createState() => _DriverShellState();
}

class _DriverShellState extends State<DriverShell> {
  var index = 0;
  @override
  Widget build(BuildContext context) {
    final pages = [
      Dashboard(
        onProfile: () => setState(() => index = 3),
        onTrip: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const TripDetailScreen()),
        ),
        onFuel: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const FuelRequestScreen()),
        ),
        onNotifications: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const NotificationsScreen()),
        ),
      ),
      const TripsScreen(),
      const FuelScreen(),
      ProfileScreen(
        onThemeChanged: widget.onThemeChanged,
        onLogout: widget.onLogout,
      ),
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 900;
        final page = AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: KeyedSubtree(key: ValueKey(index), child: pages[index]),
        );
        return Scaffold(
          body: SafeArea(
            top: index != 3 && index != 0,
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: wide ? 1120 : 720),
                child: page,
              ),
            ),
          ),
          bottomNavigationBar: AppNavigationBar(
            selectedIndex: index,
            onDestinationSelected: (value) => setState(() => index = value),
            destinations: const [
              NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Home'),
              NavigationDestination(
                  icon: Icon(Icons.local_shipping_outlined),
                  selectedIcon: Icon(Icons.local_shipping),
                  label: 'Trips'),
              NavigationDestination(
                  icon: Icon(Icons.local_gas_station_outlined),
                  selectedIcon: Icon(Icons.local_gas_station),
                  label: 'Fuel'),
              NavigationDestination(
                  icon: Icon(Icons.person_outline),
                  selectedIcon: Icon(Icons.person),
                  label: 'Profile'),
            ],
          ),
        );
      },
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({
    super.key,
    required this.onTrip,
    required this.onFuel,
    required this.onNotifications,
    required this.onProfile,
  });
  final VoidCallback onTrip, onFuel, onNotifications, onProfile;
  @override
  Widget build(BuildContext context) => RefreshIndicator(
        onRefresh: () async =>
            await Future<void>.delayed(const Duration(milliseconds: 700)),
        child: DashboardContent(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            WorkspaceHeader(
              name: 'Dara Sok',
              workspace: 'Driver operations',
              icon: Icons.local_shipping_outlined,
              detail: 'DR-001 · On duty',
              onNotifications: onNotifications,
              onProfile: onProfile,
            ),
            const SizedBox(height: 28),
            const SectionHeader(title: "Today's assigned trip"),
            const SizedBox(height: 8),
            _TripCard(onTap: onTrip),
            const SizedBox(height: 28),
            const SectionHeader(title: 'Quick actions'),
            const SizedBox(height: 8),
            ActionGrid(
              children: [
                _QuickAction(
                  icon: Icons.local_gas_station_outlined,
                  label: 'Request fuel',
                  color: AppColors.warning,
                  onTap: onFuel,
                ),
                _QuickAction(
                  icon: Icons.history,
                  label: 'Trip history',
                  color: AppColors.blue,
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            'Trip history is available from the Trips tab.')),
                  ),
                ),
                _QuickAction(
                  icon: Icons.directions_car_outlined,
                  label: 'My vehicle',
                  color: AppColors.navy,
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                            Text('Vehicle details: PP 3A-1234 · Cement Truck')),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            const SectionHeader(title: 'Today at a glance'),
            const SizedBox(height: 8),
            const MetricGrid(
              children: [
                MetricCard(
                  value: '02',
                  label: "Today's trips",
                  icon: Icons.route_outlined,
                  color: AppColors.blue,
                ),
                MetricCard(
                  value: '01',
                  label: 'Active trips',
                  icon: Icons.timer_outlined,
                  color: AppColors.warning,
                ),
                MetricCard(
                  value: '18',
                  label: 'Completed',
                  icon: Icons.check_circle_outline,
                  color: AppColors.success,
                ),
              ],
            ),
          ],
        ),
      );
}

class _TripCard extends StatelessWidget {
  const _TripCard({required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Column(children: [
        TripSummaryCard(
            id: demoTrip.id,
            pickup: demoTrip.pickup,
            destination: demoTrip.destination,
            material: '${demoTrip.material} · ${demoTrip.quantity}',
            schedule: demoTrip.time,
            distance: demoTrip.distance,
            onTap: onTap),
        const SizedBox(height: 12),
        PrimaryButton(
            label: 'Start trip',
            onPressed: onTap,
            icon: Icons.play_arrow_rounded),
      ]);
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          child: Container(
            height: 108,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: color),
                const Spacer(),
                Text(
                  label,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
      );
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Notifications')),
        body: ListView(
          children: const [
            ListTile(
              leading: CircleAvatar(child: Icon(Icons.route)),
              title: Text('New trip assigned'),
              subtitle: Text('Trip N1-2034 starts at 08:30 AM'),
              trailing: Text('Now'),
            ),
            Divider(),
            ListTile(
              leading: CircleAvatar(child: Icon(Icons.local_gas_station)),
              title: Text('Fuel request approved'),
              subtitle: Text('120 L for PP 3A-1234'),
              trailing: Text('2h'),
            ),
          ],
        ),
      );
}
