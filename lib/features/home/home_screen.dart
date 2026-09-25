import 'package:flutter/material.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../models/models.dart';
import '../../shared/widgets/ui_components.dart';
import '../../shared/widgets/trip_presentation.dart';
import '../fuel/fuel_screens.dart';
import '../profile/profile_screen.dart';
import '../roles/fuel_reports_screen.dart';
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
            name: demoVehicle.driverName,
            workspace: l10n.roleDriverShort,
            icon: Icons.local_shipping_outlined,
            detail: '${demoVehicle.driverId} · ${l10n.onDuty}',
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

enum _NotifFilter { all, unread, read }

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});
  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  var filter = _NotifFilter.all;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final items = demoNotifications.where((n) => switch (filter) {
          _NotifFilter.all => true,
          _NotifFilter.unread => n.unread,
          _NotifFilter.read => !n.unread,
        });
    return Scaffold(
      appBar: curvedAppBar(
        l10n.notifications,
        toolbarHeight: 92,
        backgroundImage: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              right: -22,
              bottom: -8,
              child: Image.asset(
                'assets/image/background_header.png',
                height: 104,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Wrap(spacing: 8, children: [
            for (final value in _NotifFilter.values)
              ChoiceChip(
                label: Text(switch (value) {
                  _NotifFilter.all => l10n.filterAll,
                  _NotifFilter.unread => l10n.notifFilterUnread,
                  _NotifFilter.read => l10n.notifFilterReads,
                }),
                selected: filter == value,
                onSelected: (_) => setState(() => filter = value),
              ),
          ]),
          const SizedBox(height: 20),
          if (items.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 48),
              child: EmptyState(
                  title: l10n.notifNoneTitle, message: l10n.notifNoneMessage),
            )
          else ...[
            Text(
              l10n.todaySectionLabel,
              style: const TextStyle(
                  color: AppColors.muted,
                  fontWeight: FontWeight.w800,
                  fontSize: 12),
            ),
            const SizedBox(height: 10),
            for (final notification in items) ...[
              _NotificationCard(
                notification: notification,
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => switch (notification.type) {
                              NotificationType.newTrip =>
                                const TripDetailScreen(),
                              NotificationType.fuelApproved =>
                                const FuelReportsScreen(),
                            })),
              ),
              const SizedBox(height: 12),
            ],
          ],
        ],
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({required this.notification, this.onTap});
  final NotificationItem notification;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final unread = notification.unread;
    return Material(
      color: unread
          ? AppColors.accent.withValues(alpha: dark ? .16 : .08)
          : (dark ? const Color(0xFF242424) : Colors.white),
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: AppColors.accent.withValues(alpha: .15),
                  child: Icon(notification.icon, color: AppColors.navy),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(notification.title(context),
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 15)),
                      const SizedBox(height: 4),
                      Text(notification.subtitle(context),
                          style: const TextStyle(
                              color: AppColors.muted, fontSize: 12.5)),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      Text(notification.time.label(context),
                          style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color:
                                  unread ? AppColors.blue : AppColors.muted)),
                      if (unread) ...[
                        const SizedBox(width: 5),
                        Container(
                            width: 7,
                            height: 7,
                            decoration: const BoxDecoration(
                                color: AppColors.blue, shape: BoxShape.circle)),
                      ],
                    ]),
                    const Icon(Icons.chevron_right,
                        color: AppColors.muted, size: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
