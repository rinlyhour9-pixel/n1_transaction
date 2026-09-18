import 'package:flutter/material.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/ui_components.dart';
import '../auth/auth_flow.dart';

class TripAdviserDashboard extends StatelessWidget {
  const TripAdviserDashboard({super.key, required this.onSwitchRole});
  final VoidCallback onSwitchRole;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _roleAppBar(AppRole.tripAdviser, onSwitchRole),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreateTripScreen()),
          ),
          icon: const Icon(Icons.add),
          label: const Text('Create trip'),
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
              const SectionHeader(title: 'Today’s trip control'),
              const SizedBox(height: 8),
              const MetricGrid(
                children: [
                  MetricCard(
                      value: '08',
                      label: 'Scheduled',
                      icon: Icons.event_note_outlined,
                      color: AppColors.blue),
                  MetricCard(
                      value: '05',
                      label: 'In transit',
                      icon: Icons.route_outlined,
                      color: Color(0xFF7557D9)),
                  MetricCard(
                      value: '02',
                      label: 'Need action',
                      icon: Icons.error_outline,
                      color: AppColors.warning),
                ],
              ),
              const SizedBox(height: 26),
              SectionHeader(
                  title: 'Active trips',
                  action: 'View all',
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Showing the latest active trips.')),
                      )),
              const SizedBox(height: 8),
              _TripRow(
                id: 'N1-2034',
                route: 'N1 Factory  →  Construction Site A',
                status: 'In transit',
                statusColor: AppColors.info,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const CreateTripScreen(editing: true)),
                ),
              ),
              const SizedBox(height: 12),
              const _TripRow(
                id: 'N1-2029',
                route: 'Factory B  →  Warehouse C',
                status: 'Completed',
                statusColor: AppColors.success,
              ),
              const SizedBox(height: 26),
              const SectionHeader(title: 'Trip tools'),
              const SizedBox(height: 8),
              ActionGrid(
                children: [
                  _ToolTile(
                      icon: Icons.add_road_outlined,
                      label: 'Create trip',
                      color: AppColors.blue,
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const CreateTripScreen()))),
                  _ToolTile(
                      icon: Icons.radar_outlined,
                      label: 'Track fleet',
                      color: AppColors.success,
                      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Fleet tracking view is ready for live location data.')),
                          )),
                  _ToolTile(
                      icon: Icons.description_outlined,
                      label: 'Trip reports',
                      color: const Color(0xFF7557D9),
                      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Trip reports are prepared from completed trips.')),
                          )),
                ],
              ),
              const SizedBox(height: 88),
            ],
          ),
        ),
      );
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
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            title: Text(widget.editing ? 'Trip N1-2034' : 'Create a trip')),
        body: _RoleContent(
          maxWidth: 680,
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            const Text('Plan the trip',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900)),
            const SizedBox(height: 6),
            const Text(
                'Assign the vehicle and driver, then define the route and material.',
                style: TextStyle(color: AppColors.muted)),
            const SizedBox(height: 24),
            const _FieldTitle('Vehicle & driver'),
            DropdownButtonFormField<String>(
              initialValue: vehicle,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.local_shipping_outlined)),
              items: const [
                DropdownMenuItem(
                    value: 'PP 3A-1234',
                    child: Text('PP 3A-1234 · Cement Truck')),
                DropdownMenuItem(
                    value: 'PP 2D-9090',
                    child: Text('PP 2D-9090 · Dump Truck')),
              ],
              onChanged: (value) => setState(() => vehicle = value!),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: driver,
              decoration:
                  const InputDecoration(prefixIcon: Icon(Icons.person_outline)),
              items: const [
                DropdownMenuItem(
                    value: 'Dara Sok · DR-001',
                    child: Text('Dara Sok · DR-001')),
                DropdownMenuItem(
                    value: 'Vannak Lim · DR-012',
                    child: Text('Vannak Lim · DR-012')),
              ],
              onChanged: (value) => setState(() => driver = value!),
            ),
            const SizedBox(height: 24),
            const _FieldTitle('Route'),
            const TextField(
                decoration: InputDecoration(
                    labelText: 'Pickup location',
                    hintText: 'N1 Cement Factory',
                    prefixIcon: Icon(Icons.radio_button_checked))),
            const SizedBox(height: 12),
            const TextField(
                decoration: InputDecoration(
                    labelText: 'Delivery location',
                    hintText: 'Construction Site A',
                    prefixIcon: Icon(Icons.location_on_outlined))),
            const SizedBox(height: 24),
            const _FieldTitle('Material'),
            DropdownButtonFormField<String>(
              initialValue: material,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.inventory_2_outlined)),
              items: const [
                DropdownMenuItem(value: 'Cement', child: Text('Cement')),
                DropdownMenuItem(value: 'Soil', child: Text('Soil')),
              ],
              onChanged: (value) => setState(() => material = value!),
            ),
            const SizedBox(height: 12),
            const TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Quantity',
                    suffixText: 'Tons',
                    prefixIcon: Icon(Icons.scale_outlined))),
            const SizedBox(height: 12),
            const TextField(
                maxLines: 3,
                decoration: InputDecoration(
                    labelText: 'Trip note (optional)',
                    prefixIcon: Icon(Icons.notes_outlined))),
            const SizedBox(height: 28),
            PrimaryButton(
              label:
                  widget.editing ? 'Save trip changes' : 'Send trip to driver',
              icon: Icons.send_outlined,
              onPressed: () => _showTripSent(context),
            ),
          ],
        ),
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
  String firstStatus = 'Pending';

  void _updateFirstStatus(String status) {
    setState(() => firstStatus = status);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(status == 'Approved'
            ? '120 L approved for Dara Sok. Fuel stock will be updated on issue.'
            : 'Fuel request rejected.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () => setState(() => firstStatus = 'Pending'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _roleAppBar(AppRole.fuelStockManager, widget.onSwitchRole),
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
                    const Text('MAIN FUEL STOCK',
                        style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.w800,
                            fontSize: 12)),
                    const SizedBox(height: 10),
                    const Text('8,450 / 12,500 L',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 38,
                            fontWeight: FontWeight.w900)),
                    const Text('68% available · Reserve threshold: 20%',
                        style: TextStyle(color: Colors.white70)),
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
            const SectionHeader(title: 'Fuel requests awaiting action'),
            const SizedBox(height: 8),
            _FuelRequestCard(
              driver: 'Dara Sok',
              vehicle: 'PP 3A-1234',
              amount: '120 L',
              reason: 'Current Trip · N1-2034',
              status: firstStatus,
              onApprove: () => _updateFirstStatus('Approved'),
              onReject: () => _updateFirstStatus('Rejected'),
            ),
            const SizedBox(height: 12),
            _FuelRequestCard(
              driver: 'Vannak Lim',
              vehicle: 'PP 2D-9090',
              amount: '80 L',
              reason: 'Low fuel',
              status: 'Pending',
              onApprove: () {},
              onReject: () {},
            ),
            const SizedBox(height: 25),
            const SectionHeader(title: 'Today’s issuing summary'),
            const SizedBox(height: 8),
            const MetricGrid(
              children: [
                MetricCard(
                    value: '620 L',
                    label: 'Issued today',
                    icon: Icons.local_gas_station,
                    color: AppColors.warning),
                MetricCard(
                    value: '06',
                    label: 'Approved',
                    icon: Icons.task_alt,
                    color: AppColors.success),
              ],
            ),
          ],
        ),
      );
}

class CeoDashboard extends StatelessWidget {
  const CeoDashboard({super.key, required this.onSwitchRole});
  final VoidCallback onSwitchRole;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _roleAppBar(AppRole.ceo, onSwitchRole),
        body: _RoleContent(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            const _RoleHeader(role: AppRole.ceo, name: 'N1 Owner'),
            const SizedBox(height: 8),
            const Text('Live operational performance across N1 Logistic.',
                style: TextStyle(color: AppColors.muted)),
            const SizedBox(height: 24),
            const SectionHeader(title: 'Business overview'),
            const SizedBox(height: 8),
            const MetricGrid(
              children: [
                MetricCard(
                    value: '24',
                    label: 'Active vehicles',
                    icon: Icons.local_shipping_outlined,
                    color: AppColors.blue),
                MetricCard(
                    value: '142',
                    label: 'Trips this month',
                    icon: Icons.route_outlined,
                    color: AppColors.success),
                MetricCard(
                    value: '96%',
                    label: 'On-time rate',
                    icon: Icons.verified_outlined,
                    color: Color(0xFF7557D9)),
              ],
            ),
            const SizedBox(height: 26),
            const SectionHeader(title: 'Delivery performance'),
            const SizedBox(height: 8),
            const _PerformanceCard(),
            const SizedBox(height: 26),
            const SectionHeader(title: 'Management dashboard'),
            const SizedBox(height: 8),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: MediaQuery.sizeOf(context).width >= 700 ? 3 : 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.3,
              children: const [
                _ManagementTile(
                    icon: Icons.local_shipping_outlined,
                    label: 'Active vehicles',
                    color: AppColors.blue),
                _ManagementTile(
                    icon: Icons.water_drop_outlined,
                    label: 'Fuel usage',
                    color: AppColors.warning),
                _ManagementTile(
                    icon: Icons.inventory_2_outlined,
                    label: 'Material delivery',
                    color: AppColors.success),
                _ManagementTile(
                    icon: Icons.person_outline,
                    label: 'Driver performance',
                    color: Color(0xFF7557D9)),
                _ManagementTile(
                    icon: Icons.account_balance_wallet_outlined,
                    label: 'Expenses & cost',
                    color: AppColors.warning),
                _ManagementTile(
                    icon: Icons.manage_accounts_outlined,
                    label: 'Users & permissions',
                    color: AppColors.navy),
              ],
            ),
            const SizedBox(height: 30),
            PrimaryButton(
                label: 'View reports',
                icon: Icons.assessment_outlined,
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              'Reports workspace is ready for live operational data.')),
                    )),
          ],
        ),
      );
}

PreferredSizeWidget _roleAppBar(AppRole role, VoidCallback onSwitchRole) =>
    AppBar(
      title: Row(
        children: [
          Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                  color: role.color.withValues(alpha: .13),
                  borderRadius: BorderRadius.circular(8)),
              child: Icon(role.icon, color: role.color, size: 17)),
          const SizedBox(width: 9),
          Text(role.label),
        ],
      ),
      actions: [
        IconButton(
            onPressed: onSwitchRole,
            tooltip: 'Switch role',
            icon: const Icon(Icons.switch_account_outlined)),
        const SizedBox(width: 6)
      ],
    );

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
          child: ListView(padding: padding, children: children),
        ),
      );
}

class _RoleHeader extends StatelessWidget {
  const _RoleHeader({required this.role, required this.name});
  final AppRole role;
  final String name;
  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 430;
          final badge = StatusBadge(label: role.shortLabel, color: role.color);
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                  radius: 23,
                  backgroundColor: role.color,
                  child: Text(
                      name.split(' ').map((word) => word[0]).take(2).join(),
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w800))),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Good morning,',
                        style: TextStyle(color: AppColors.muted)),
                    Text(name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w900)),
                    if (compact) ...[const SizedBox(height: 7), badge],
                  ],
                ),
              ),
              if (!compact) ...[const SizedBox(width: 8), badge],
            ],
          );
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

class _FieldTitle extends StatelessWidget {
  const _FieldTitle(this.label);
  final String label;
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w900)));
}

class _FuelRequestCard extends StatelessWidget {
  const _FuelRequestCard(
      {required this.driver,
      required this.vehicle,
      required this.amount,
      required this.reason,
      required this.status,
      required this.onApprove,
      required this.onReject});
  final String driver, vehicle, amount, reason, status;
  final VoidCallback onApprove, onReject;
  @override
  Widget build(BuildContext context) {
    final pending = status == 'Pending';
    final color = status == 'Approved'
        ? AppColors.success
        : status == 'Rejected'
            ? AppColors.error
            : AppColors.warning;
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
                    Text('$driver · $amount',
                        style: const TextStyle(fontWeight: FontWeight.w900)),
                    Text('$vehicle · $reason',
                        style: const TextStyle(
                            color: AppColors.muted, fontSize: 12))
                  ])),
              StatusBadge(label: status, color: color)
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
                        child: const Text('Reject'))),
                const SizedBox(width: 10),
                Expanded(
                    child: FilledButton(
                        onPressed: onApprove,
                        style: FilledButton.styleFrom(
                            backgroundColor: AppColors.success),
                        child: const Text('Approve')))
              ]),
            ] else if (status == 'Approved') ...[
              const SizedBox(height: 10),
              TextButton.icon(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                              Text('Fuel issue recorded and stock updated.'))),
                  icon: const Icon(Icons.inventory_outlined),
                  label: const Text('Record fuel out')),
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
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Row(children: [
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text('On-time completion',
                        style: TextStyle(fontWeight: FontWeight.w900)),
                    SizedBox(height: 3),
                    Text('This week · Target 94%',
                        style: TextStyle(color: AppColors.muted, fontSize: 12))
                  ])),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
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
                    children: const [
                      _ChartBar(height: 46, label: 'Mon'),
                      _ChartBar(height: 68, label: 'Tue'),
                      _ChartBar(height: 59, label: 'Wed'),
                      _ChartBar(height: 90, label: 'Thu'),
                      _ChartBar(height: 80, label: 'Fri'),
                      _ChartBar(height: 98, label: 'Sat', highlighted: true),
                      _ChartBar(height: 67, label: 'Sun')
                    ]))
          ]),
        ),
      );
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
      {required this.icon, required this.label, required this.color});
  final IconData icon;
  final String label;
  final Color color;
  @override
  Widget build(BuildContext context) => Card(
      child: InkWell(
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                        '$label insights will appear here as live data connects.')),
              ),
          borderRadius: BorderRadius.circular(18),
          child: Padding(
              padding: const EdgeInsets.all(13),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(icon, color: color),
                    const Spacer(),
                    Text(label,
                        style: const TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 12))
                  ]))));
}

void _showTripSent(BuildContext context) => showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon:
            const Icon(Icons.check_circle, color: AppColors.success, size: 38),
        title: const Text('Trip sent to driver'),
        content: const Text(
            'The driver can now see the assigned vehicle, route, material, and delivery instructions.'),
        actions: [
          FilledButton(
              onPressed: () => Navigator.of(dialogContext)
                  .popUntil((route) => route.isFirst),
              child: const Text('Done'))
        ],
      ),
    );
