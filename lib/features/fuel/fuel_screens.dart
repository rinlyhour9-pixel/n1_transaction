import 'package:flutter/material.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/ui_components.dart';
import '../../l10n/generated/app_localizations.dart';

class FuelScreen extends StatelessWidget {
  const FuelScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: AppBar(title: Text(l10n.navFuel)),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FuelRequestScreen()),
          ),
          icon: const Icon(Icons.add),
          label: Text(l10n.requestFuel),
        ),
        body: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            Card(
              color: AppColors.navy,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'PP 3A-1234  •  Cement Truck',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      '35%',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 42,
                      ),
                    ),
                    Text(
                      l10n.currentFuelLevel,
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 14),
                    LinearProgressIndicator(
                      value: .35,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.accent,
                      backgroundColor: Colors.white24,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 26),
            SectionHeader(title: l10n.latestRequest),
            _RequestCard(
              status: l10n.statusApproved,
              liters: '120 L',
              date: 'Today · 07:10 AM',
              color: AppColors.success,
            ),
            const SizedBox(height: 22),
            SectionHeader(title: l10n.requestHistory),
            _RequestCard(
              status: l10n.statusPending,
              liters: '80 L',
              date: 'Sep 14 · 04:20 PM',
              color: AppColors.warning,
            ),
            const SizedBox(height: 10),
            _RequestCard(
              status: l10n.statusApproved,
              liters: '100 L',
              date: 'Sep 09 · 08:00 AM',
              color: AppColors.success,
            ),
          ],
        ),
      );
  }
}

class _RequestCard extends StatelessWidget {
  const _RequestCard({
    required this.status,
    required this.liters,
    required this.date,
    required this.color,
  });
  final String status, liters, date;
  final Color color;
  @override
  Widget build(BuildContext context) => Card(
        child: ListTile(
          contentPadding: const EdgeInsets.all(15),
          leading: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withValues(alpha: .12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.local_gas_station, color: color),
          ),
          title:
              Text(liters, style: const TextStyle(fontWeight: FontWeight.w900)),
          subtitle: Text('PP 3A-1234 · $date'),
          trailing: StatusBadge(label: status, color: color),
        ),
      );
}

class FuelRequestScreen extends StatefulWidget {
  const FuelRequestScreen({super.key});
  @override
  State<FuelRequestScreen> createState() => _FuelRequestScreenState();
}

class _FuelRequestScreenState extends State<FuelRequestScreen> {
  String reason = 'Current Trip';

  String _reasonLabel(AppLocalizations l10n, String item) {
    switch (item) {
      case 'Current Trip':
        return l10n.reasonCurrentTrip;
      case 'Next Trip':
        return l10n.reasonNextTrip;
      case 'Low Fuel':
        return l10n.reasonLowFuel;
      default:
        return l10n.reasonOther;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: AppBar(title: Text(l10n.requestFuel)),
        body: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            const _RequestVehicle(),
            const SizedBox(height: 24),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: l10n.requestedAmount,
                suffixText: l10n.liters,
              ),
            ),
            const SizedBox(height: 20),
            Text(l10n.reason, style: const TextStyle(fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ['Current Trip', 'Next Trip', 'Low Fuel', 'Other']
                  .map(
                    (item) => ChoiceChip(
                      label: Text(_reasonLabel(l10n, item)),
                      selected: reason == item,
                      onSelected: (_) => setState(() => reason = item),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 16),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(hintText: l10n.optionalNote),
            ),
            const SizedBox(height: 26),
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
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.requestFor,
                style: const TextStyle(
                  color: AppColors.muted,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'PP 3A-1234 · Cement Truck',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  const Icon(Icons.local_gas_station, color: AppColors.warning),
                  const SizedBox(width: 8),
                  Text(l10n.currentFuel),
                  const Spacer(),
                  Text(
                    '35%',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: AppColors.warning,
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
