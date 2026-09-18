import 'package:flutter/material.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/models/trip.dart';
import '../../shared/widgets/ui_components.dart';
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
            child: wide
                ? Row(
                    children: [
                      NavigationRail(
                        selectedIndex: index,
                        onDestinationSelected: (value) =>
                            setState(() => index = value),
                        labelType: NavigationRailLabelType.all,
                        leading: const Padding(
                          padding: EdgeInsets.only(bottom: 22, top: 10),
                          child: _N1RailMark(),
                        ),
                        destinations: const [
                          NavigationRailDestination(
                              icon: Icon(Icons.home_outlined),
                              selectedIcon: Icon(Icons.home),
                              label: Text('Home')),
                          NavigationRailDestination(
                              icon: Icon(Icons.local_shipping_outlined),
                              selectedIcon: Icon(Icons.local_shipping),
                              label: Text('Trips')),
                          NavigationRailDestination(
                              icon: Icon(Icons.local_gas_station_outlined),
                              selectedIcon: Icon(Icons.local_gas_station),
                              label: Text('Fuel')),
                          NavigationRailDestination(
                              icon: Icon(Icons.person_outline),
                              selectedIcon: Icon(Icons.person),
                              label: Text('Profile')),
                        ],
                      ),
                      const VerticalDivider(width: 1),
                      Expanded(
                          child: Center(
                              child: ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(maxWidth: 1120),
                                  child: page))),
                    ],
                  )
                : Center(
                    child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 720),
                        child: page)),
          ),
          bottomNavigationBar: wide
              ? null
              : NavigationBar(
                  selectedIndex: index,
                  onDestinationSelected: (value) =>
                      setState(() => index = value),
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

class _N1RailMark extends StatelessWidget {
  const _N1RailMark();
  @override
  Widget build(BuildContext context) => Container(
        width: 42,
        height: 42,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: AppColors.navy, borderRadius: BorderRadius.circular(13)),
        child: const Text('N1',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
      );
}

class Dashboard extends StatelessWidget {
  const Dashboard({
    super.key,
    required this.onTrip,
    required this.onFuel,
    required this.onNotifications,
  });
  final VoidCallback onTrip, onFuel, onNotifications;
  @override
  Widget build(BuildContext context) => RefreshIndicator(
        onRefresh: () async =>
            await Future<void>.delayed(const Duration(milliseconds: 700)),
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.navy,
                  child: Text(
                    'DS',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Good morning,',
                        style: TextStyle(color: AppColors.muted),
                      ),
                      Row(
                        children: const [
                          Flexible(
                            child: Text(
                              'Dara Sok · DR-001',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          StatusBadge(
                            label: 'On duty',
                            color: AppColors.success,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onNotifications,
                  icon: const Badge(child: Icon(Icons.notifications_outlined)),
                  tooltip: 'Notifications',
                ),
              ],
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
  Widget build(BuildContext context) => Card(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                          color: AppColors.blue.withValues(alpha: .12),
                          borderRadius: BorderRadius.circular(13)),
                      child: const Icon(Icons.local_shipping_outlined,
                          color: AppColors.blue),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ready to depart',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w900)),
                            Text('${demoTrip.id} · Starts at 08:30 AM',
                                style: const TextStyle(
                                    color: AppColors.muted, fontSize: 12))
                          ]),
                    ),
                    const StatusBadge(label: 'Assigned'),
                  ],
                ),
                const SizedBox(height: 22),
                const _TripRoute(),
                const SizedBox(height: 18),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      const Icon(Icons.inventory_2_outlined,
                          size: 19, color: AppColors.muted),
                      const SizedBox(width: 8),
                      Expanded(
                          child: Text(
                              '${demoTrip.material} · ${demoTrip.quantity}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700))),
                      const Icon(Icons.straighten_outlined,
                          size: 18, color: AppColors.muted),
                      const SizedBox(width: 5),
                      Text(demoTrip.distance,
                          style: const TextStyle(
                              color: AppColors.muted,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                PrimaryButton(
                    label: 'Start trip',
                    onPressed: onTap,
                    icon: Icons.play_arrow_rounded),
              ],
            ),
          ),
        ),
      );
}

class _TripRoute extends StatelessWidget {
  const _TripRoute();
  @override
  Widget build(BuildContext context) => const Column(
        children: [
          _RouteStop(
              icon: Icons.radio_button_checked,
              color: AppColors.blue,
              label: 'Pickup',
              location: 'N1 Cement Factory',
              detail: '08:30 AM · National Road 5'),
          Padding(
              padding: EdgeInsets.only(left: 9),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                      height: 24,
                      child:
                          VerticalDivider(width: 1, color: AppColors.muted)))),
          _RouteStop(
              icon: Icons.location_on,
              color: AppColors.error,
              label: 'Delivery',
              location: 'Construction Site A',
              detail: 'Estimated 10:00 AM'),
        ],
      );
}

class _RouteStop extends StatelessWidget {
  const _RouteStop(
      {required this.icon,
      required this.color,
      required this.label,
      required this.location,
      required this.detail});
  final IconData icon;
  final Color color;
  final String label, location, detail;
  @override
  Widget build(BuildContext context) =>
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 11),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label.toUpperCase(),
              style: const TextStyle(
                  color: AppColors.muted,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: .7)),
          const SizedBox(height: 2),
          Text(location, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 2),
          Text(detail,
              style: const TextStyle(color: AppColors.muted, fontSize: 12))
        ]))
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
