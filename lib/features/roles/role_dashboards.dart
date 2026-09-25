import 'package:flutter/material.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../models/models.dart';
import '../../shared/widgets/ui_components.dart';
import '../auth/auth_flow.dart';
import '../home/home_screen.dart' show NotificationsScreen;
import '../profile/profile_screen.dart';
import 'fuel_reports_screen.dart';
import 'trip_adviser_screens.dart';

class RoleShell extends StatefulWidget {
  const RoleShell(
      {super.key,
      required this.role,
      required this.onSwitchRole,
      required this.onThemeChanged,
      required this.locale,
      required this.onLocaleChanged});
  final AppRole role;
  final VoidCallback onSwitchRole, onThemeChanged;
  final Locale locale;
  final ValueChanged<Locale> onLocaleChanged;

  @override
  State<RoleShell> createState() => _RoleShellState();
}

class _RoleShellState extends State<RoleShell> {
  int index = 0;

  void selectTab(int value) => setState(() => index = value);

  @override
  Widget build(BuildContext context) {
    final dashboard = switch (widget.role) {
      AppRole.tripAdviser =>
        TripAdviserDashboard(onSwitchRole: widget.onSwitchRole),
      AppRole.fuelStockManager =>
        FuelStockManagerDashboard(onSwitchRole: widget.onSwitchRole),
      AppRole.ceo => CeoDashboard(onSwitchRole: widget.onSwitchRole),
      AppRole.driver => throw StateError('Drivers use DriverShell'),
    };
    final name = switch (widget.role) {
      AppRole.tripAdviser => 'Sokha Chann',
      AppRole.fuelStockManager => 'Rith Vichea',
      AppRole.ceo => 'N1 Owner',
      AppRole.driver => 'Dara Sok',
    };
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: IndexedStack(index: index, children: [
        dashboard,
        const NotificationsScreen(),
        ProfileScreen(
          name: name,
          accountLabel:
              '${widget.role.label(context)} · ${widget.role.demoAccount}',
          isDriver: false,
          onThemeChanged: widget.onThemeChanged,
          onLogout: widget.onSwitchRole,
          locale: widget.locale,
          onLocaleChanged: widget.onLocaleChanged,
        ),
      ]),
      bottomNavigationBar: AppNavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) => setState(() => index = value),
        destinations: [
          NavigationDestination(
              icon: const Icon(Icons.home_outlined),
              selectedIcon: const Icon(Icons.home),
              label: l10n.navHome),
          NavigationDestination(
              icon: const Icon(Icons.notifications_outlined),
              selectedIcon: const Icon(Icons.notifications),
              label: l10n.navNotifications),
          NavigationDestination(
              icon: const Icon(Icons.person_outline),
              selectedIcon: const Icon(Icons.person),
              label: l10n.navProfile),
        ],
      ),
    );
  }
}

class TripAdviserDashboard extends StatelessWidget {
  const TripAdviserDashboard({super.key, required this.onSwitchRole});
  final VoidCallback onSwitchRole;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        tooltip: l10n.createTrip,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CreateTripScreen()),
        ),
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () async => await Future<void>.delayed(
          const Duration(milliseconds: 600),
        ),
        child: _RoleContent(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            const _RoleHeader(role: AppRole.tripAdviser, name: 'Sokha Chann'),
            const SizedBox(height: 26),
            SectionHeader(title: l10n.todaysTripControl),
            const SizedBox(height: 8),
            MetricGrid(
              children: [
                MetricCard(
                    value: '08',
                    label: l10n.scheduled,
                    icon: Icons.event_note_outlined,
                    color: AppColors.blue),
                MetricCard(
                    value: '05',
                    label: l10n.inTransit,
                    icon: Icons.route_outlined,
                    color: const Color(0xFF7557D9)),
                MetricCard(
                    value: '02',
                    label: l10n.needAction,
                    icon: Icons.error_outline,
                    color: AppColors.warning),
              ],
            ),
            const SizedBox(height: 26),
            SectionHeader(
                title: l10n.activeTrips,
                action: l10n.viewAll,
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l10n.showingLatestTrips)),
                    )),
            const SizedBox(height: 8),
            _TripRow(
              id: 'N1-2034',
              route: 'N1 Factory  →  Construction Site A',
              status: l10n.inTransit,
              statusColor: AppColors.info,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const CreateTripScreen(editing: true)),
              ),
            ),
            const SizedBox(height: 12),
            _TripRow(
              id: 'N1-2029',
              route: 'Factory B  →  Warehouse C',
              status: l10n.completed,
              statusColor: AppColors.success,
            ),
            const SizedBox(height: 26),
            SectionHeader(title: l10n.tripTools),
            const SizedBox(height: 8),
            ActionGrid(
              children: [
                _ToolTile(
                    icon: Icons.add_road_outlined,
                    label: l10n.createTrip,
                    color: AppColors.blue,
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const CreateTripScreen()))),
                _ToolTile(
                    icon: Icons.radar_outlined,
                    label: l10n.trackFleet,
                    color: AppColors.success,
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const TrackFleetScreen()))),
                _ToolTile(
                    icon: Icons.description_outlined,
                    label: l10n.tripReports,
                    color: const Color(0xFF7557D9),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const TripReportsScreen()))),
              ],
            ),
            const SizedBox(height: 88),
          ],
        ),
      ),
    );
  }
}

class CreateTripScreen extends StatefulWidget {
  const CreateTripScreen({super.key, this.editing = false});
  final bool editing;

  @override
  State<CreateTripScreen> createState() => _CreateTripScreenState();
}

class _CreateTripScreenState extends State<CreateTripScreen> {
  String vehicle = 'PP 3A-1234';
  String driver = 'Dara Sok · DR-001';
  String material = 'Cement';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: curvedAppBar(
            widget.editing ? l10n.tripLabel('N1-2034') : l10n.createATrip,
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
            )),
        body: _RoleContent(
          maxWidth: 680,
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [AppColors.navy, Color(0xFF19588F)]),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.local_shipping_rounded,
                        color: Colors.white, size: 23),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l10n.planTheTrip,
                            style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -.3)),
                        const SizedBox(height: 5),
                        Text(l10n.planTheTripSubtitle,
                            style: const TextStyle(
                                color: AppColors.muted, height: 1.35)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 26),
            _FormSectionCard(
              icon: Icons.local_shipping_outlined,
              color: AppColors.blue,
              title: l10n.vehicleAndDriver,
              children: [
                DropdownButtonFormField<String>(
                  initialValue: vehicle,
                  isExpanded: true,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.local_shipping_outlined,
                          color: AppColors.blue)),
                  items: const [
                    DropdownMenuItem(
                        value: 'PP 3A-1234',
                        child: Text('PP 3A-1234 · Cement Truck',
                            overflow: TextOverflow.ellipsis)),
                    DropdownMenuItem(
                        value: 'PP 2D-9090',
                        child: Text('PP 2D-9090 · Dump Truck',
                            overflow: TextOverflow.ellipsis)),
                  ],
                  onChanged: (value) => setState(() => vehicle = value!),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: driver,
                  isExpanded: true,
                  decoration: InputDecoration(
                      prefixIcon:
                          Icon(Icons.person_outline, color: AppColors.blue)),
                  items: const [
                    DropdownMenuItem(
                        value: 'Dara Sok · DR-001',
                        child: Text('Dara Sok · DR-001',
                            overflow: TextOverflow.ellipsis)),
                    DropdownMenuItem(
                        value: 'Vannak Lim · DR-012',
                        child: Text('Vannak Lim · DR-012',
                            overflow: TextOverflow.ellipsis)),
                  ],
                  onChanged: (value) => setState(() => driver = value!),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _FormSectionCard(
              icon: Icons.route_outlined,
              color: AppColors.success,
              title: l10n.route,
              children: [
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(width: 20, child: _RouteConnector()),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          children: [
                            TextField(
                                decoration: InputDecoration(
                                    labelText: l10n.pickupLocation,
                                    hintText: 'N1 Cement Factory',
                                    prefixIcon: Icon(
                                        Icons.radio_button_checked,
                                        color: AppColors.success))),
                            const SizedBox(height: 14),
                            TextField(
                                decoration: InputDecoration(
                                    labelText: l10n.deliveryLocation,
                                    hintText: 'Construction Site A',
                                    prefixIcon: const Icon(
                                        Icons.location_on_outlined,
                                        color: AppColors.error))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _FormSectionCard(
              icon: Icons.inventory_2_outlined,
              color: const Color(0xFF7557D9),
              title: l10n.material,
              children: [
                DropdownButtonFormField<String>(
                  initialValue: material,
                  isExpanded: true,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.inventory_2_outlined,
                          color: Color(0xFF7557D9))),
                  items: const [
                    DropdownMenuItem(value: 'Cement', child: Text('Cement')),
                    DropdownMenuItem(value: 'Soil', child: Text('Soil')),
                  ],
                  onChanged: (value) => setState(() => material = value!),
                ),
                const SizedBox(height: 12),
                TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: l10n.quantity,
                        suffixText: l10n.tons,
                        prefixIcon: const Icon(Icons.scale_outlined,
                            color: Color(0xFF7557D9)))),
                const SizedBox(height: 12),
                TextField(
                    maxLines: 3,
                    decoration: InputDecoration(
                        labelText: l10n.tripNoteOptional,
                        prefixIcon: const Icon(Icons.notes_outlined))),
              ],
            ),
            const SizedBox(height: 28),
            PrimaryButton(
              label: widget.editing
                  ? l10n.saveTripChanges
                  : l10n.sendTripToDriver,
              icon: Icons.send_outlined,
              onPressed: () => _showTripSent(context),
            ),
          ],
        ),
      );
  }
}

/// A titled, icon-badged card used to group related fields on the trip
/// planning form so each step of the workflow reads as a distinct block.
class _FormSectionCard extends StatelessWidget {
  const _FormSectionCard(
      {required this.icon,
      required this.color,
      required this.title,
      required this.children});
  final IconData icon;
  final Color color;
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: .12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icon, color: color, size: 17),
                  ),
                  const SizedBox(width: 10),
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 15)),
                ],
              ),
              const SizedBox(height: 16),
              ...children,
            ],
          ),
        ),
      );
}

/// The pickup-to-delivery timeline glyph shown beside the route fields:
/// a start dot, a connecting line, and an end pin, mirroring the mental
/// model of a map route rather than two unrelated text fields.
class _RouteConnector extends StatelessWidget {
  const _RouteConnector();

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: AppColors.success,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                    color: AppColors.success.withValues(alpha: .35),
                    blurRadius: 4)
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: 2,
              margin: const EdgeInsets.symmetric(vertical: 4),
              color: AppColors.muted.withValues(alpha: .25),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 18),
            child: Icon(Icons.location_on,
                size: 20, color: AppColors.error),
          ),
        ],
      );
}

class FuelStockManagerDashboard extends StatefulWidget {
  const FuelStockManagerDashboard({super.key, required this.onSwitchRole});
  final VoidCallback onSwitchRole;

  @override
  State<FuelStockManagerDashboard> createState() =>
      _FuelStockManagerDashboardState();
}

class _FuelStockManagerDashboardState extends State<FuelStockManagerDashboard> {
  late final requests = List<FuelRequest>.of(demoPendingFuelRequests);

  void _updateStatus(int index, FuelRequestStatus status) {
    final l10n = AppLocalizations.of(context)!;
    final request = requests[index];
    setState(() => requests[index] = request.copyWith(status: status));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(status == FuelRequestStatus.approved
            ? l10n.fuelApprovedMsg('${request.liters} L', request.driverName)
            : l10n.fuelRejectedMsg),
        action: SnackBarAction(
          label: l10n.undo,
          onPressed: () => setState(() => requests[index] =
              request.copyWith(status: FuelRequestStatus.pending)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
        body: _RoleContent(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            const _RoleHeader(
                role: AppRole.fuelStockManager, name: 'Rith Vichea'),
            const SizedBox(height: 24),
            Card(
              color: AppColors.navy,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.mainFuelStock,
                        style: const TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.w800,
                            fontSize: 12)),
                    const SizedBox(height: 10),
                    const Text('8,450 / 12,500 L',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 38,
                            fontWeight: FontWeight.w900)),
                    Text(l10n.availableReserve('68', '20'),
                        style: const TextStyle(color: Colors.white70)),
                    const SizedBox(height: 14),
                    LinearProgressIndicator(
                        value: .68,
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(10),
                        backgroundColor: Colors.white24,
                        color: AppColors.accent),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            SectionHeader(title: l10n.fuelRequestsAwaiting),
            const SizedBox(height: 8),
            for (var i = 0; i < requests.length; i++) ...[
              if (i > 0) const SizedBox(height: 12),
              _FuelRequestCard(
                request: requests[i],
                onApprove: () => _updateStatus(i, FuelRequestStatus.approved),
                onReject: () => _updateStatus(i, FuelRequestStatus.rejected),
              ),
            ],
            const SizedBox(height: 25),
            SectionHeader(title: l10n.todaysIssuingSummary),
            const SizedBox(height: 8),
            MetricGrid(
              children: [
                MetricCard(
                    value: '620 L',
                    label: l10n.issuedToday,
                    icon: Icons.local_gas_station,
                    color: AppColors.warning),
                MetricCard(
                    value: '06',
                    label: l10n.statusApproved,
                    icon: Icons.task_alt,
                    color: AppColors.success),
              ],
            ),
            const SizedBox(height: 25),
            PrimaryButton(
                label: l10n.fuelReports,
                icon: Icons.description_outlined,
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const FuelReportsScreen()))),
          ],
        ),
      );
  }
}

class CeoDashboard extends StatelessWidget {
  const CeoDashboard({super.key, required this.onSwitchRole});
  final VoidCallback onSwitchRole;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
        body: _RoleContent(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            const _RoleHeader(role: AppRole.ceo, name: 'N1 Owner'),
            const SizedBox(height: 24),
            SectionHeader(title: l10n.businessOverview),
            const SizedBox(height: 8),
            MetricGrid(
              children: [
                MetricCard(
                    value: '24',
                    label: l10n.activeVehicles,
                    icon: Icons.local_shipping_outlined,
                    color: AppColors.blue),
                MetricCard(
                    value: '142',
                    label: l10n.tripsThisMonth,
                    icon: Icons.route_outlined,
                    color: AppColors.success),
                MetricCard(
                    value: '96%',
                    label: l10n.onTimeRate,
                    icon: Icons.verified_outlined,
                    color: const Color(0xFF7557D9)),
              ],
            ),
            const SizedBox(height: 26),
            SectionHeader(title: l10n.managementDashboard),
            const SizedBox(height: 8),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.85,
              children: [
                _ManagementTile(
                    icon: Icons.local_shipping_rounded,
                    label: l10n.activeVehicles,
                    color: AppColors.blue,
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const TrackFleetScreen()))),
                _ManagementTile(
                    icon: Icons.local_gas_station_rounded,
                    label: l10n.fuelReports,
                    color: AppColors.warning,
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const FuelReportsScreen()))),
                _ManagementTile(
                    icon: Icons.summarize_rounded,
                    label: l10n.tripReports,
                    color: const Color(0xFF7557D9),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const TripReportsScreen()))),
              ],
            ),
            const SizedBox(height: 26),
            SectionHeader(title: l10n.deliveryPerformance),
            const SizedBox(height: 8),
            const _PerformanceCard(),
          ],
        ),
      );
  }
}

class _RoleContent extends StatelessWidget {
  const _RoleContent(
      {required this.children,
      this.padding = const EdgeInsets.all(AppSpacing.lg),
      this.maxWidth = 1120});
  final List<Widget> children;
  final EdgeInsets padding;
  final double maxWidth;
  @override
  Widget build(BuildContext context) => Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: DashboardContent(padding: padding, children: children),
        ),
      );
}

class _RoleHeader extends StatelessWidget {
  const _RoleHeader({required this.role, required this.name});
  final AppRole role;
  final String name;
  @override
  Widget build(BuildContext context) => WorkspaceHeader(
        name: name,
        workspace: role.shortLabel(context),
        icon: role.icon,
        detail: role.label(context),
        onNotifications: () {
          final shell = context.findAncestorStateOfType<_RoleShellState>();
          shell?.selectTab(1);
        },
        onProfile: () {
          final shell = context.findAncestorStateOfType<_RoleShellState>();
          shell?.selectTab(2);
        },
      );
}

class _TripRow extends StatelessWidget {
  const _TripRow(
      {required this.id,
      required this.route,
      required this.status,
      required this.statusColor,
      this.onTap});
  final String id, route, status;
  final Color statusColor;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) => Card(
      child: ListTile(
          onTap: onTap,
          contentPadding: const EdgeInsets.all(16),
          leading: Icon(Icons.local_shipping_outlined, color: statusColor),
          title: Text(id, style: const TextStyle(fontWeight: FontWeight.w900)),
          subtitle: Text(route),
          trailing: StatusBadge(label: status, color: statusColor)));
}

class _ToolTile extends StatelessWidget {
  const _ToolTile(
      {required this.icon,
      required this.label,
      required this.color,
      required this.onTap});
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Semantics(
        button: true,
        label: label,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Card(
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(18),
              child: SizedBox(
                height: 108,
                child: Padding(
                  padding: const EdgeInsets.all(13),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: color.withValues(alpha: .12),
                                borderRadius: BorderRadius.circular(10)),
                            child: Icon(icon, color: color, size: 20)),
                        const Spacer(),
                        Text(label,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w800))
                      ]),
                ),
              ),
            ),
          ),
        ),
      );
}

class _FuelRequestCard extends StatelessWidget {
  const _FuelRequestCard(
      {required this.request, required this.onApprove, required this.onReject});
  final FuelRequest request;
  final VoidCallback onApprove, onReject;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final pending = request.status == FuelRequestStatus.pending;
    final color = request.status.color;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                      color: color.withValues(alpha: .12),
                      borderRadius: BorderRadius.circular(12)),
                  child: Icon(Icons.local_gas_station, color: color)),
              const SizedBox(width: 11),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text('${request.driverName} · ${request.liters} L',
                        style: const TextStyle(fontWeight: FontWeight.w900)),
                    Text(
                        '${request.vehiclePlate} · ${request.reasonLabel(context)}',
                        style: const TextStyle(
                            color: AppColors.muted, fontSize: 12))
                  ])),
              StatusBadge(label: request.status.label(context), color: color)
            ]),
            if (pending) ...[
              const SizedBox(height: 14),
              Row(children: [
                Expanded(
                    child: OutlinedButton(
                        onPressed: onReject,
                        style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.error,
                            side: const BorderSide(color: AppColors.error)),
                        child: Text(l10n.reject))),
                const SizedBox(width: 10),
                Expanded(
                    child: FilledButton(
                        onPressed: onApprove,
                        style: FilledButton.styleFrom(
                            backgroundColor: AppColors.success),
                        child: Text(l10n.approve)))
              ]),
            ] else if (request.status == FuelRequestStatus.approved) ...[
              const SizedBox(height: 10),
              TextButton.icon(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l10n.fuelIssueRecordedMsg))),
                  icon: const Icon(Icons.inventory_outlined),
                  label: Text(l10n.recordFuelOut)),
            ],
          ],
        ),
      ),
    );
  }
}

class _PerformanceCard extends StatelessWidget {
  const _PerformanceCard();
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(l10n.onTimeCompletion,
                        style: const TextStyle(fontWeight: FontWeight.w900)),
                    const SizedBox(height: 3),
                    Text(l10n.thisWeekTarget('94'),
                        style: const TextStyle(
                            color: AppColors.muted, fontSize: 12))
                  ])),
              const Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text('96%',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
                SizedBox(height: 4),
                StatusBadge(label: '+4.8%', color: AppColors.success)
              ])
            ]),
            const SizedBox(height: 18),
            // The tallest bar is 98 pt; reserve room for its label so it
            // remains inside the card on phone-sized screens.
            SizedBox(
                height: 122,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _ChartBar(height: 46, label: l10n.dayMon),
                      _ChartBar(height: 68, label: l10n.dayTue),
                      _ChartBar(height: 59, label: l10n.dayWed),
                      _ChartBar(height: 90, label: l10n.dayThu),
                      _ChartBar(height: 80, label: l10n.dayFri),
                      _ChartBar(
                          height: 98, label: l10n.daySat, highlighted: true),
                      _ChartBar(height: 67, label: l10n.daySun)
                    ]))
          ]),
        ),
      );
  }
}

class _ChartBar extends StatelessWidget {
  const _ChartBar(
      {required this.height, required this.label, this.highlighted = false});
  final double height;
  final String label;
  final bool highlighted;
  @override
  Widget build(BuildContext context) => Expanded(
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        Container(
            height: height,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
                color: highlighted
                    ? AppColors.success
                    : AppColors.blue.withValues(alpha: .35),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(5)))),
        const SizedBox(height: 5),
        Text(label,
            style: const TextStyle(
                color: AppColors.muted,
                fontSize: 11,
                fontWeight: FontWeight.w600))
      ]));
}

class _ManagementTile extends StatelessWidget {
  const _ManagementTile(
      {required this.icon,
      required this.label,
      required this.color,
      required this.onTap});
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Card(
      child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                            color: color.withValues(alpha: .12),
                            shape: BoxShape.circle),
                        child: Icon(icon, color: color, size: 26)),
                    const SizedBox(height: 10),
                    Text(label,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 12))
                  ]))));
}

void _showTripSent(BuildContext context) {
  final l10n = AppLocalizations.of(context)!;
  showDialog(
    context: context,
    builder: (dialogContext) => AlertDialog(
      icon:
          const Icon(Icons.check_circle, color: AppColors.success, size: 38),
      title: Text(l10n.tripSentTitle),
      content: Text(l10n.tripSentBody),
      actions: [
        FilledButton(
            onPressed: () => Navigator.of(dialogContext)
                .popUntil((route) => route.isFirst),
            child: Text(l10n.done))
      ],
    ),
  );
}
