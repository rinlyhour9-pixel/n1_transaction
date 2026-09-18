import 'package:flutter/material.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/models/trip.dart';
import '../../shared/widgets/ui_components.dart';

class TripsScreen extends StatelessWidget {
  const TripsScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('My trips')),
        body: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            const TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search trip ID or destination',
              ),
            ),
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
            const _TripListItem(completed: true),
          ],
        ),
      );
}

class _TripListItem extends StatelessWidget {
  const _TripListItem({this.onTap, this.completed = false});
  final VoidCallback? onTap;
  final bool completed;
  @override
  Widget build(BuildContext context) => Card(
        child: ListTile(
          onTap: onTap,
          contentPadding: const EdgeInsets.all(15),
          leading: Icon(
            completed ? Icons.check_circle : Icons.local_shipping_outlined,
            color: completed ? AppColors.success : AppColors.blue,
          ),
          title: Text(
            completed ? 'N1-2027' : demoTrip.id,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
          subtitle: Text(
            completed
                ? 'Factory B to Warehouse C'
                : '${demoTrip.pickup} to ${demoTrip.destination}',
          ),
          trailing: StatusBadge(
            label: completed ? 'Completed' : 'Assigned',
            color: completed ? AppColors.success : AppColors.blue,
          ),
        ),
      );
}

class TripDetailScreen extends StatelessWidget {
  const TripDetailScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Trip details')),
        body: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            Row(
              children: [
                Text(
                  demoTrip.id,
                  style: Theme.of(
                    context,
                  )
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w900),
                ),
                const Spacer(),
                const StatusBadge(label: 'Assigned'),
              ],
            ),
            const SizedBox(height: 20),
            const _MapPlaceholder(),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: const Column(
                  children: [
                    InfoRow(
                      icon: Icons.local_shipping_outlined,
                      label: 'Vehicle',
                      value: 'PP 3A-1234',
                    ),
                    Divider(height: 1),
                    InfoRow(
                      icon: Icons.inventory_2_outlined,
                      label: 'Material',
                      value: 'Cement · 25 Tons',
                    ),
                    Divider(height: 1),
                    InfoRow(
                      icon: Icons.straighten_outlined,
                      label: 'Estimated distance',
                      value: '42 km',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const _LocationCard(
              icon: Icons.radio_button_checked,
              title: 'Pickup',
              value: 'N1 Cement Factory',
              color: AppColors.blue,
            ),
            const SizedBox(height: 12),
            const _LocationCard(
              icon: Icons.location_on,
              title: 'Delivery',
              value: 'Construction Site A',
              color: AppColors.error,
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'Start trip',
              icon: Icons.play_arrow,
              onPressed: () => _confirmStart(context),
            ),
          ],
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

class _MapPlaceholder extends StatelessWidget {
  const _MapPlaceholder();
  @override
  Widget build(BuildContext context) => Container(
        height: 190,
        decoration: BoxDecoration(
          color: const Color(0xFFE8F0F4),
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Stack(
          children: [
            Center(
              child: Icon(Icons.map_outlined, size: 60, color: AppColors.navy),
            ),
            Positioned(
              left: 36,
              bottom: 38,
              child: Icon(Icons.radio_button_checked, color: AppColors.blue),
            ),
            Positioned(
              right: 38,
              top: 35,
              child: Icon(Icons.location_on, color: AppColors.error, size: 30),
            ),
          ],
        ),
      );
}

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
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Active trip')),
        body: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            Text(
              demoTrip.id,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 14),
            const _MapPlaceholder(),
            const SizedBox(height: 22),
            const SectionHeader(title: 'Trip progress'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: List.generate(
                    labels.length,
                    (i) => _TimelineRow(
                      label: labels[i],
                      current: i == step,
                      done: i < step,
                      last: i == labels.length - 1,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: step < 3
                  ? 'Arrived at pickup'
                  : step < 4
                      ? 'Confirm loading'
                      : 'Continue trip',
              icon: Icons.arrow_forward,
              onPressed: () {
                if (step == 3) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LoadingScreen()),
                  );
                } else {
                  setState(() => step = (step + 1).clamp(0, labels.length - 1));
                }
              },
            ),
          ],
        ),
      );
}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({
    required this.label,
    required this.current,
    required this.done,
    required this.last,
  });
  final String label;
  final bool current, done, last;
  @override
  Widget build(BuildContext context) {
    final color = done || current ? AppColors.success : AppColors.muted;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: done ? AppColors.success : Colors.transparent,
                border: Border.all(color: color, width: 2),
              ),
              child: done
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
            if (!last)
              Container(
                width: 2,
                height: 27,
                color: color.withValues(alpha: .5),
              ),
          ],
        ),
        const SizedBox(width: 12),
        Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: current ? FontWeight.w800 : FontWeight.w500,
              color: current ? AppColors.text : AppColors.muted,
            ),
          ),
        ),
      ],
    );
  }
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
