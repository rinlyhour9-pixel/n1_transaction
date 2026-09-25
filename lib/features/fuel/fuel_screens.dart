import 'package:flutter/material.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../models/models.dart';
import '../../shared/widgets/ui_components.dart';
import '../../l10n/generated/app_localizations.dart';
import '../auth/auth_flow.dart';
import '../home/home_screen.dart' show NotificationsScreen;

class FuelScreen extends StatelessWidget {
  const FuelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final vehicle = demoVehicle;
    final requests = demoFuelRequests;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: DashboardContent(
        children: [
          _FuelHeader(
              onNotifications: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          const NotificationsScreen(role: AppRole.driver)))),
          const SizedBox(height: 24),
          _FuelGaugeCard(vehicle: vehicle),
          const SizedBox(height: 16),
          _RequestFuelBanner(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const FuelRequestScreen()))),
          const SizedBox(height: 26),
          SectionHeader(title: l10n.latestRequest),
          const SizedBox(height: 8),
          _RequestCard(request: requests.first),
          const SizedBox(height: 22),
          SectionHeader(title: l10n.requestHistory),
          for (final request in requests.skip(1)) ...[
            const SizedBox(height: 8),
            _RequestCard(request: request),
          ],
        ],
      ),
    );
  }
}

/// A compact greeting header — just an icon, "Good morning," and the
/// driver's name, matching the same top row used on the home Dashboard's
/// WorkspaceHeader, without its status pill / title / artwork below it.
class _FuelHeader extends StatelessWidget {
  const _FuelHeader({required this.onNotifications});
  final VoidCallback onNotifications;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // FuelScreen normally lives as a bottom-nav tab inside DriverShell (no
    // route to pop), but it's also pushed standalone from VehicleScreen's
    // "Fuel Requests" tile — show a back button only in that pushed case,
    // since there's no other way out of a route with no AppBar.
    final canPop = Navigator.canPop(context);
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(26)),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.navy, Color(0xFF19588F)]),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 18),
          child: Row(
            children: [
              if (canPop) ...[
                IconButton.filled(
                    onPressed: () => Navigator.pop(context),
                    tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                    style: IconButton.styleFrom(
                        backgroundColor: Colors.white.withValues(alpha: .12),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(38, 38),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13))),
                    icon: const Icon(Icons.arrow_back, size: 20)),
                const SizedBox(width: 10),
              ],
              const Icon(Icons.local_gas_station_outlined,
                  color: Color(0xFFAFD4F2), size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.goodMorning,
                        style: const TextStyle(
                            color: Color(0xFFB4CEE5), fontSize: 11)),
                    const SizedBox(height: 3),
                    Text(demoVehicle.driverName,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15)),
                  ],
                ),
              ),
              IconButton.filled(
                  onPressed: onNotifications,
                  tooltip: l10n.navNotifications,
                  style: IconButton.styleFrom(
                      backgroundColor: Colors.white.withValues(alpha: .12),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(38, 38),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13))),
                  icon: const Icon(Icons.notifications_outlined, size: 20)),
            ],
          ),
        ),
      ),
    );
  }
}

class _FuelGaugeCard extends StatelessWidget {
  const _FuelGaugeCard({required this.vehicle});
  final Vehicle vehicle;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final percent = vehicle.fuelPercent;
    final lowFuel = vehicle.isLowFuel;
    final gaugeColor = lowFuel ? AppColors.warning : AppColors.blue;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFF264D78).withValues(alpha: .08),
              blurRadius: 20,
              offset: const Offset(0, 8)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                    color: AppColors.navy.withValues(alpha: .1),
                    shape: BoxShape.circle),
                child: const Icon(Icons.local_shipping_outlined,
                    color: AppColors.navy)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Flexible(
                        child: Text(vehicle.plate,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 16))),
                    const Icon(Icons.keyboard_arrow_down,
                        size: 18, color: AppColors.muted),
                  ]),
                  Text(l10n.cementTruck,
                      style: const TextStyle(
                          color: AppColors.muted, fontSize: 12)),
                ],
              ),
            ),
            StatusBadge(label: l10n.onTripStatus, color: AppColors.success),
          ]),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 122,
                height: 122,
                child: Stack(alignment: Alignment.center, children: [
                  SizedBox.expand(
                    child: CircularProgressIndicator(
                      value: percent,
                      strokeWidth: 10,
                      strokeCap: StrokeCap.round,
                      backgroundColor: AppColors.blue.withValues(alpha: .1),
                      valueColor: AlwaysStoppedAnimation(gaugeColor),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.local_gas_station,
                          color: gaugeColor, size: 22),
                      const SizedBox(height: 4),
                      Text('${(percent * 100).round()}%',
                          style: const TextStyle(
                              fontSize: 21, fontWeight: FontWeight.w900)),
                      Text(l10n.currentFuelLevel,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 10, color: AppColors.muted)),
                    ],
                  ),
                ]),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(children: [
                  InfoRow(
                      icon: Icons.water_drop_outlined,
                      label: l10n.fuelCapacity,
                      value: '${vehicle.capacityLiters} L'),
                  const Divider(height: 1),
                  InfoRow(
                      icon: Icons.local_gas_station_outlined,
                      label: l10n.remainingFuel,
                      value: '${vehicle.remainingLiters} L'),
                ]),
              ),
            ],
          ),
          if (lowFuel) ...[
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(14)),
              child: Row(children: [
                const Icon(Icons.error_outline,
                    color: AppColors.warning, size: 19),
                const SizedBox(width: 8),
                Expanded(
                    child: Text(l10n.lowFuelWarning,
                        style: const TextStyle(
                            color: AppColors.warning,
                            fontSize: 12,
                            fontWeight: FontWeight.w600))),
              ]),
            ),
          ],
        ],
      ),
    );
  }
}

class _RequestFuelBanner extends StatelessWidget {
  const _RequestFuelBanner({required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Material(
      color: AppColors.navy,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(children: [
            Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .15),
                    shape: BoxShape.circle),
                child: const Icon(Icons.local_gas_station,
                    color: Colors.white)),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.requestFuel,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w800)),
                  const SizedBox(height: 2),
                  Text(l10n.createNewRequest,
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
            Container(
                width: 34,
                height: 34,
                decoration: const BoxDecoration(
                    color: Colors.white, shape: BoxShape.circle),
                child: const Icon(Icons.arrow_forward,
                    color: AppColors.navy, size: 18)),
          ]),
        ),
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  const _RequestCard({required this.request});
  final FuelRequest request;
  @override
  Widget build(BuildContext context) {
    final color = request.status.color;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: .12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.local_gas_station, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${request.liters} L',
                    style: const TextStyle(fontWeight: FontWeight.w900)),
                const SizedBox(height: 3),
                Text('${request.vehiclePlate} · ${request.date}',
                    style: const TextStyle(
                        color: AppColors.muted, fontSize: 12)),
                const SizedBox(height: 3),
                Row(children: [
                  const Icon(Icons.location_on_outlined,
                      size: 13, color: AppColors.muted),
                  const SizedBox(width: 3),
                  Text(request.location,
                      style: const TextStyle(
                          color: AppColors.muted, fontSize: 12)),
                ]),
              ],
            ),
          ),
          const SizedBox(width: 8),
          StatusBadge(label: request.status.label(context), color: color),
        ]),
      ),
    );
  }
}

class FuelRequestScreen extends StatefulWidget {
  const FuelRequestScreen({super.key});
  @override
  State<FuelRequestScreen> createState() => _FuelRequestScreenState();
}

class _FuelRequestScreenState extends State<FuelRequestScreen> {
  FuelReason reason = FuelReason.currentTrip;
  String? location;

  Future<void> _pickLocation() async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) => SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final place in const ['Main Depot', 'Site A', 'Site B'])
              ListTile(
                leading: const Icon(Icons.location_on_outlined),
                title: Text(place),
                onTap: () => Navigator.pop(sheetContext, place),
              ),
          ],
        ),
      ),
    );
    if (selected != null) setState(() => location = selected);
  }

  Widget _eyebrow(String label) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          label.toUpperCase(),
          style: const TextStyle(
            color: AppColors.muted,
            fontWeight: FontWeight.w800,
            fontSize: 11,
            letterSpacing: 1,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: curvedAppBar(l10n.requestFuel, actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.local_gas_station_outlined,
                color: Colors.white70),
          ),
        ]),
        body: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            const _RequestVehicle(),
            const SizedBox(height: 24),
            _eyebrow(l10n.requestedAmount),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.local_gas_station_outlined),
                hintText: l10n.enterFuelAmountHint,
              ),
            ),
            const SizedBox(height: 18),
            _eyebrow(l10n.locationLabel),
            InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: _pickLocation,
              child: InputDecorator(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.location_on_outlined),
                  suffixIcon: const Icon(Icons.chevron_right),
                ),
                child: Text(
                  location ?? l10n.selectLocationHint,
                  style: TextStyle(
                      color: location == null
                          ? Theme.of(context).hintColor
                          : null),
                ),
              ),
            ),
            const SizedBox(height: 18),
            _eyebrow(l10n.reason),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: FuelReason.values
                  .map(
                    (item) => ChoiceChip(
                      avatar: Icon(item.icon,
                          size: 18,
                          color: reason == item
                              ? Colors.white
                              : AppColors.muted),
                      label: Text(item.label(context)),
                      labelStyle: TextStyle(
                          color: reason == item ? Colors.white : null,
                          fontWeight: FontWeight.w700),
                      selected: reason == item,
                      selectedColor: AppColors.blue,
                      onSelected: (_) => setState(() => reason = item),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 18),
            _eyebrow(l10n.optionalNote),
            TextField(
              maxLines: 3,
              maxLength: 250,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.notes_outlined),
                hintText: l10n.addNoteHint,
              ),
            ),
            const SizedBox(height: 10),
            PrimaryButton(
              label: l10n.submitRequest,
              icon: Icons.send_outlined,
              onPressed: () => _confirm(context),
            ),
          ],
        ),
      );
  }
}

void _confirm(BuildContext context) {
  final l10n = AppLocalizations.of(context)!;
  showDialog(
    context: context,
    builder: (dialogContext) => AlertDialog(
      icon:
          const Icon(Icons.check_circle, color: AppColors.success, size: 36),
      title: Text(l10n.requestSubmittedTitle),
      content: Text(l10n.requestSubmittedBody),
      actions: [
        TextButton(
          onPressed: () =>
              Navigator.of(dialogContext).popUntil((route) => route.isFirst),
          child: Text(l10n.done),
        ),
      ],
    ),
  );
}

class _RequestVehicle extends StatelessWidget {
  const _RequestVehicle();
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.vehicleLabel.toUpperCase(),
                          style: const TextStyle(
                            color: AppColors.muted,
                            fontWeight: FontWeight.w800,
                            fontSize: 11,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${demoVehicle.plate} · ${demoVehicle.type}',
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                        color: AppColors.blue.withValues(alpha: .1),
                        borderRadius: BorderRadius.circular(14)),
                    child: const Icon(Icons.local_shipping_outlined,
                        color: AppColors.blue),
                  ),
                ],
              ),
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Divider(height: 1)),
              Row(
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                        color: AppColors.warning.withValues(alpha: .12),
                        shape: BoxShape.circle),
                    child: const Icon(Icons.local_gas_station,
                        color: AppColors.warning, size: 18),
                  ),
                  const SizedBox(width: 10),
                  Text(l10n.currentFuel),
                  const Spacer(),
                  Text(
                    '${(demoVehicle.fuelPercent * 100).round()}%',
                    style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 17,
                        color: AppColors.warning),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 90,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: demoVehicle.fuelPercent,
                        minHeight: 8,
                        color: AppColors.warning,
                        backgroundColor: const Color(0xFFE7ECF2),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
  }
}
