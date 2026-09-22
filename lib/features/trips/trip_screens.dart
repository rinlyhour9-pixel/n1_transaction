import 'package:flutter/material.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/models/trip.dart';
import '../../shared/widgets/ui_components.dart';
import '../../shared/widgets/trip_presentation.dart';

class TripsScreen extends StatefulWidget {
  const TripsScreen(
      {super.key, this.initialFilter = 'All', this.title = 'My trips'});
  final String initialFilter, title;
  @override
  State<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> {
  late String filter = widget.initialFilter;
  String query = '';
  bool matches(String text) =>
      text.toLowerCase().contains(query.trim().toLowerCase());
  @override
  Widget build(BuildContext context) {
    final current = filter != 'Completed' &&
        matches('${demoTrip.id} ${demoTrip.pickup} ${demoTrip.destination}');
    final completed =
        filter != 'Today' && matches('N1-2027 Factory B Warehouse C');
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          TextField(
            onChanged: (value) => setState(() => query = value),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search trip ID or destination',
            ),
          ),
          const SizedBox(height: 14),
          Wrap(spacing: 8, children: [
            for (final value in ['All', 'Today', 'Completed'])
              ChoiceChip(
                  label: Text(value),
                  selected: filter == value,
                  onSelected: (_) => setState(() => filter = value)),
          ]),
          if (!current && !completed)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 48),
              child: EmptyState(
                  title: 'No trips found',
                  message: 'Try another trip ID or destination.'),
            ),
          if (current) ...[
            const SizedBox(height: 20),
            const Text(
              'TODAY',
              style: TextStyle(
                color: AppColors.muted,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 10),
            _TripListItem(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TripDetailScreen()),
              ),
            ),
          ],
          if (completed) ...[
            const SizedBox(height: 18),
            const Text(
              'RECENTLY COMPLETED',
              style: TextStyle(
                color: AppColors.muted,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 10),
            _TripListItem(
                completed: true,
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const CompletedTripScreen()))),
          ],
        ],
      ),
    );
  }
}

class CompletedTripScreen extends StatelessWidget {
  const CompletedTripScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Completed trip')),
        body: ListView(padding: const EdgeInsets.all(20), children: [
          const TripSummaryCard(
              id: 'N1-2027',
              pickup: 'Factory B',
              destination: 'Warehouse C',
              completed: true),
          const SizedBox(height: 24),
          const SectionHeader(title: 'Delivery summary'),
          const SizedBox(height: 12),
          const Card(
              child: Padding(
                  padding: EdgeInsets.all(18),
                  child: Column(children: [
                    InfoRow(
                        icon: Icons.tag, label: 'Trip ID', value: 'N1-2027'),
                    Divider(),
                    InfoRow(
                        icon: Icons.check_circle_outline,
                        label: 'Status',
                        value: 'Completed'),
                  ]))),
          const SizedBox(height: 16),
          const Text(
              'Delivery documents and recorded quantities are not available for this trip.',
              style: TextStyle(color: AppColors.muted)),
        ]),
      );
}

class _TripListItem extends StatelessWidget {
  const _TripListItem({this.onTap, this.completed = false});
  final VoidCallback? onTap;
  final bool completed;
  @override
  Widget build(BuildContext context) => TripSummaryCard(
        id: completed ? 'N1-2027' : demoTrip.id,
        pickup: completed ? 'Factory B' : demoTrip.pickup,
        destination: completed ? 'Warehouse C' : demoTrip.destination,
        material:
            completed ? null : '${demoTrip.material} · ${demoTrip.quantity}',
        schedule: completed ? null : demoTrip.time,
        distance: completed ? null : demoTrip.distance,
        completed: completed,
        onTap: onTap,
      );
}

class TripDetailScreen extends StatelessWidget {
  const TripDetailScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Trip details')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
              child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: Column(children: [
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                    color: const Color(0xFF202020),
                    borderRadius: BorderRadius.circular(32)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: Container(
                              width: 36,
                              height: 4,
                              decoration: BoxDecoration(
                                  color: Colors.white30,
                                  borderRadius: BorderRadius.circular(4)))),
                      const SizedBox(height: 24),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  const Text('Trip ID',
                                      style: TextStyle(
                                          color: Colors.white54, fontSize: 12)),
                                  const SizedBox(height: 7),
                                  Text(demoTrip.id,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 26,
                                          fontWeight: FontWeight.w600)),
                                ])),
                            const TripStatusPill(label: 'Assigned', dark: true),
                          ]),
                      const SizedBox(height: 26),
                      const TripProgressLine(dark: true),
                      const SizedBox(height: 24),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: TripFact(
                                    label: demoTrip.time,
                                    value: demoTrip.pickup,
                                    dark: true)),
                            const SizedBox(width: 16),
                            Expanded(
                                child: TripFact(
                                    label: 'Estimated 10:00 AM',
                                    value: demoTrip.destination,
                                    dark: true)),
                          ]),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Divider(color: Colors.white10, height: 1)),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  TripFact(
                                      label: 'Material',
                                      value: demoTrip.material,
                                      dark: true),
                                  const SizedBox(height: 22),
                                  TripFact(
                                      label: 'Quantity',
                                      value: demoTrip.quantity,
                                      dark: true),
                                  const SizedBox(height: 22),
                                  TripFact(
                                      label: 'Estimated distance',
                                      value: demoTrip.distance,
                                      dark: true),
                                ])),
                            const SizedBox(width: 12),
                            const Flexible(child: CargoArtwork(size: 155)),
                          ]),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: .05),
                            borderRadius: BorderRadius.circular(24)),
                        child: Row(children: [
                          Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                  color: tripAccent.withValues(alpha: .15),
                                  shape: BoxShape.circle),
                              child: const Icon(Icons.local_shipping_outlined,
                                  color: tripAccent)),
                          const SizedBox(width: 12),
                          Expanded(
                              child: TripFact(
                                  label: 'Assigned vehicle',
                                  value: demoTrip.vehicle,
                                  dark: true)),
                          const Icon(Icons.verified_outlined,
                              color: Colors.white54, size: 22),
                        ]),
                      ),
                    ]),
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                  label: 'Start trip',
                  icon: Icons.play_arrow,
                  onPressed: () => _confirmStart(context)),
            ]),
          )),
        ),
      );
}

void _confirmStart(BuildContext context) => showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.route, size: 40, color: AppColors.navy),
            const SizedBox(height: 14),
            const Text(
              'Start this trip?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 8),
            const Text(
              'Confirm when you are ready to head to the pickup location.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 22),
            PrimaryButton(
              label: 'Yes, start trip',
              icon: Icons.check,
              onPressed: () {
                Navigator.pop(sheetContext);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const ActiveTripScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );

class _LocationCard extends StatelessWidget {
  const _LocationCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });
  final IconData icon;
  final String title, value;
  final Color color;
  @override
  Widget build(BuildContext context) => Card(
        child: ListTile(
          leading: Icon(icon, color: color),
          title:
              Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
          subtitle: Text(value),
        ),
      );
}

class ActiveTripScreen extends StatefulWidget {
  const ActiveTripScreen({super.key});
  @override
  State<ActiveTripScreen> createState() => _ActiveTripScreenState();
}

class _ActiveTripScreenState extends State<ActiveTripScreen> {
  var step = 1;
  final labels = const [
    'Started',
    'Going to pickup',
    'Arrived at pickup',
    'Loading material',
    'Delivering',
    'Arrived at destination',
    'Unloading',
    'Completed',
  ];
  void _advance() {
    if (step == 3) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const LoadingScreen()));
    } else {
      setState(() => step = (step + 1).clamp(0, labels.length - 1));
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Active trip')),
        bottomNavigationBar: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
            child: Center(
                heightFactor: 1,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 680),
                  child: SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                          backgroundColor: tripAccent,
                          foregroundColor: const Color(0xFF202020),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18))),
                      onPressed: _advance,
                      icon: const Icon(Icons.arrow_forward),
                      label: Text(
                          step < 2
                              ? 'Arrived at pickup'
                              : step == 2
                                  ? 'Start loading'
                                  : step == 3
                                      ? 'Confirm loading'
                                      : 'Continue trip',
                          style: const TextStyle(fontWeight: FontWeight.w700)),
                    ),
                  ),
                )),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
          child: Center(
              child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                  color: const Color(0xFF202020),
                  borderRadius: BorderRadius.circular(32)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            const Text('Trip ID',
                                style: TextStyle(
                                    color: Colors.white54, fontSize: 12)),
                            const SizedBox(height: 7),
                            Text(demoTrip.id,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 26,
                                    fontWeight: FontWeight.w600)),
                          ])),
                      const TripStatusPill(label: 'In progress', dark: true),
                    ]),
                    const SizedBox(height: 20),
                    Row(children: [
                      Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Semantics(
                                liveRegion: true,
                                child: Text(labels[step],
                                    style: const TextStyle(
                                        color: tripAccent,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600))),
                            const SizedBox(height: 8),
                            Text('${demoTrip.material} · ${demoTrip.quantity}',
                                style: const TextStyle(
                                    color: Colors.white70, fontSize: 14)),
                            const SizedBox(height: 5),
                            Text(demoTrip.distance,
                                style: const TextStyle(
                                    color: Colors.white54, fontSize: 12)),
                          ])),
                      const SizedBox(width: 12),
                      const CargoArtwork(size: 88),
                    ]),
                    const SizedBox(height: 22),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: TripFact(
                                  label: 'Pickup',
                                  value: demoTrip.pickup,
                                  dark: true)),
                          const Padding(
                              padding: EdgeInsets.fromLTRB(8, 20, 12, 0),
                              child: Icon(Icons.east,
                                  size: 18, color: tripAccent)),
                          Expanded(
                              child: TripFact(
                                  label: 'Delivery',
                                  value: demoTrip.destination,
                                  dark: true)),
                        ]),
                    const Padding(
                        padding: EdgeInsets.symmetric(vertical: 22),
                        child: Divider(color: Colors.white10, height: 1)),
                    const Text('Trip progress',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(height: 20),
                    ...List.generate(
                        labels.length,
                        (i) => _TimelineRow(
                            label: labels[i],
                            current: i == step,
                            done: i < step,
                            last: i == labels.length - 1)),
                    const SizedBox(height: 22),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: .05),
                          borderRadius: BorderRadius.circular(24)),
                      child: Row(children: [
                        const CircleAvatar(
                            backgroundColor: Color(0xFF433029),
                            child: Icon(Icons.local_shipping_outlined,
                                color: tripAccent)),
                        const SizedBox(width: 12),
                        Expanded(
                            child: TripFact(
                                label: 'Assigned vehicle',
                                value: demoTrip.vehicle,
                                dark: true)),
                      ]),
                    ),
                  ]),
            ),
          )),
        ),
      );
}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow(
      {required this.label,
      required this.current,
      required this.done,
      required this.last});
  final String label;
  final bool current, done, last;
  @override
  Widget build(BuildContext context) => Semantics(
        label: '$label, ${done ? 'complete' : current ? 'current' : 'pending'}',
        child: ExcludeSemantics(
            child: Padding(
          padding: EdgeInsets.only(bottom: last ? 0 : 8),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Column(children: [
              Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: done ? tripAccent : Colors.transparent,
                      border: Border.all(
                          color: done || current ? tripAccent : Colors.white24,
                          width: 1.5)),
                  child: Icon(
                      done
                          ? Icons.check
                          : current
                              ? Icons.local_shipping_outlined
                              : Icons.circle,
                      size: done
                          ? 16
                          : current
                              ? 14
                              : 5,
                      color: done
                          ? const Color(0xFF202020)
                          : current
                              ? tripAccent
                              : Colors.white24)),
              if (!last)
                ...List.generate(
                    3,
                    (_) => Container(
                        margin: const EdgeInsets.only(top: 5),
                        width: 3,
                        height: 3,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: done ? tripAccent : Colors.white24))),
            ]),
            const SizedBox(width: 14),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(label,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: current ? FontWeight.w700 : FontWeight.w400,
                      color: current
                          ? tripAccent
                          : done
                              ? Colors.white
                              : Colors.white54)),
            )),
          ]),
        )),
      );
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Loading material')),
        body: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            const _LocationCard(
              icon: Icons.inventory_2_outlined,
              title: 'Cement',
              value: 'Planned quantity: 25 Tons',
              color: AppColors.blue,
            ),
            const SizedBox(height: 20),
            const TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Actual quantity',
                suffixText: 'Tons',
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 120,
              decoration: BoxDecoration(
                border:
                    Border.all(color: AppColors.muted.withValues(alpha: .3)),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Icon(
                  Icons.add_a_photo_outlined,
                  size: 36,
                  color: AppColors.blue,
                ),
              ),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'Confirm loading',
              icon: Icons.check_circle_outline,
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const DeliveryProofScreen()),
              ),
            ),
          ],
        ),
      );
}

class DeliveryProofScreen extends StatelessWidget {
  const DeliveryProofScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Delivery proof')),
        body: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            const Text(
              'Capture delivery details',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 20),
            Container(
              height: 130,
              decoration: BoxDecoration(
                color: AppColors.blue.withValues(alpha: .07),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Icon(
                  Icons.add_a_photo_outlined,
                  size: 36,
                  color: AppColors.blue,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(labelText: 'Receiver name'),
            ),
            const SizedBox(height: 12),
            const TextField(
              maxLines: 2,
              decoration: InputDecoration(labelText: 'Delivery note'),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'Complete delivery',
              icon: Icons.task_alt,
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const TripSuccessScreen()),
              ),
            ),
          ],
        ),
      );
}

class TripSuccessScreen extends StatelessWidget {
  const TripSuccessScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 48,
                    backgroundColor: AppColors.success,
                    child: Icon(Icons.check, color: Colors.white, size: 52),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Trip completed!',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'N1-2034 · Cement · 25 Tons',
                    style: TextStyle(color: AppColors.muted),
                  ),
                  const SizedBox(height: 28),
                  PrimaryButton(
                    label: 'Back to home',
                    icon: Icons.home_outlined,
                    onPressed: () => Navigator.of(context)
                        .popUntil((route) => route.isFirst),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
