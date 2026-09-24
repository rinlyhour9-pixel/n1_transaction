import 'package:flutter/material.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../shared/models/trip.dart';
import '../../shared/widgets/ui_components.dart';
import '../../shared/widgets/trip_presentation.dart';
import '../fuel/fuel_screens.dart';
import '../profile/profile_screen.dart';
import '../trips/trip_screens.dart';
import 'vehicle_screen.dart';

class DriverShell extends StatefulWidget {
  const DriverShell({
    super.key,
    required this.onThemeChanged,
    this.onLogout,
    required this.locale,
    required this.onLocaleChanged,
  });
  final VoidCallback onThemeChanged;
  final VoidCallback? onLogout;
  final Locale locale;
  final ValueChanged<Locale> onLocaleChanged;
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
        locale: widget.locale,
        onLocaleChanged: widget.onLocaleChanged,
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
            destinations: [
              NavigationDestination(
                  icon: const Icon(Icons.home_outlined),
                  selectedIcon: const Icon(Icons.home),
                  label: AppLocalizations.of(context)!.navHome),
              NavigationDestination(
                  icon: const Icon(Icons.local_shipping_outlined),
                  selectedIcon: const Icon(Icons.local_shipping),
                  label: AppLocalizations.of(context)!.navTrips),
              NavigationDestination(
                  icon: const Icon(Icons.local_gas_station_outlined),
                  selectedIcon: const Icon(Icons.local_gas_station),
                  label: AppLocalizations.of(context)!.navFuel),
              NavigationDestination(
                  icon: const Icon(Icons.person_outline),
                  selectedIcon: const Icon(Icons.person),
                  label: AppLocalizations.of(context)!.navProfile),
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
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return RefreshIndicator(
      onRefresh: () async =>
          await Future<void>.delayed(const Duration(milliseconds: 700)),
      child: DashboardContent(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          WorkspaceHeader(
            name: 'Dara Sok',
            workspace: l10n.roleDriverShort,
            icon: Icons.local_shipping_outlined,
            detail: 'DR-001 · ${l10n.onDuty}',
            onNotifications: onNotifications,
            onProfile: onProfile,
          ),
          const SizedBox(height: 28),
          SectionHeader(title: l10n.todaysTrip),
          const SizedBox(height: 8),
          _TripCard(onTap: onTrip),
          const SizedBox(height: 28),
          SectionHeader(title: l10n.quickActions),
          const SizedBox(height: 8),
          ActionGrid(
            children: [
              _QuickAction(
                icon: Icons.local_gas_station_outlined,
                label: l10n.requestFuel,
                color: AppColors.warning,
                onTap: onFuel,
              ),
              _QuickAction(
                icon: Icons.history,
                label: l10n.tripHistory,
                color: AppColors.blue,
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => TripsScreen(
                            title: l10n.tripHistory,
                            initialFilter: 'Completed'))),
              ),
              _QuickAction(
                icon: Icons.directions_car_outlined,
                label: l10n.myVehicle,
                color: AppColors.navy,
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const VehicleScreen())),
              ),
            ],
          ),
          const SizedBox(height: 28),
          SectionHeader(title: l10n.todayAtGlance),
          const SizedBox(height: 8),
          MetricGrid(
            children: [
              InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              const TripsScreen(initialFilter: 'Today'))),
                  borderRadius: BorderRadius.circular(22),
                  child: MetricCard(
                    value: '02',
                    label: l10n.todaysTrips,
                    icon: Icons.route_outlined,
                    color: AppColors.blue,
                  )),
              InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ActiveTripScreen())),
                  borderRadius: BorderRadius.circular(22),
                  child: MetricCard(
                    value: '01',
                    label: l10n.activeTrips,
                    icon: Icons.timer_outlined,
                    color: AppColors.warning,
                  )),
              InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => TripsScreen(
                              title: l10n.completedTripsTitle,
                              initialFilter: 'Completed'))),
                  borderRadius: BorderRadius.circular(22),
                  child: MetricCard(
                    value: '18',
                    label: l10n.completed,
                    icon: Icons.check_circle_outline,
                    color: AppColors.success,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}

class _TripCard extends StatelessWidget {
  const _TripCard({required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => ValueListenableBuilder<int>(
      valueListenable: currentTripStage,
      builder: (context, stage, _) => Column(children: [
            TripSummaryCard(
                id: demoTrip.id,
                pickup: demoTrip.pickup,
                destination: demoTrip.destination,
                material: '${demoTrip.material} · ${demoTrip.quantity}',
                schedule: demoTrip.time,
                distance: demoTrip.distance,
                progress: stage / (totalTripStages - 1),
                onTap: onTap),
            const SizedBox(height: 12),
            PrimaryButton(
                label: AppLocalizations.of(context)!.startTrip,
                onPressed: onTap,
                icon: Icons.play_arrow_rounded),
          ]));
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
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
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
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: curvedAppBar(l10n.notifications),
      body: ListView(
        children: [
          ListTile(
            leading: const CircleAvatar(child: Icon(Icons.route)),
            title: Text(l10n.notifNewTripTitle),
            subtitle: Text(l10n.notifNewTripSubtitle('N1-2034', '08:30 AM')),
            trailing: Text(l10n.notifNow),
          ),
          const Divider(),
          ListTile(
            leading:
                const CircleAvatar(child: Icon(Icons.local_gas_station)),
            title: Text(l10n.notifFuelApprovedTitle),
            subtitle:
                Text(l10n.notifFuelApprovedSubtitle('120 L', 'PP 3A-1234')),
            trailing: Text(l10n.notif2h),
          ),
        ],
      ),
    );
  }
}
