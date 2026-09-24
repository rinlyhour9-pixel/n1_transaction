import 'package:flutter/material.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../models/models.dart';
import '../../shared/widgets/ui_components.dart';
import '../../shared/widgets/trip_presentation.dart';
import '../../shared/widgets/date_filter.dart';
import '../../l10n/generated/app_localizations.dart';

class TripsScreen extends StatefulWidget {
  const TripsScreen({super.key, this.initialFilter = 'All', this.title});
  final String initialFilter;
  final String? title;
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
    final l10n = AppLocalizations.of(context)!;
    final current = filter != 'Completed' &&
        matches('${demoTrip.id} ${demoTrip.pickup} ${demoTrip.destination}');
    final completed =
        filter != 'Today' && matches('N1-2027 Factory B Warehouse C');
    String filterLabel(String value) => switch (value) {
          'All' => l10n.filterAll,
          'Today' => l10n.filterToday,
          'Completed' => l10n.completed,
          _ => value,
        };
    return Scaffold(
      appBar: curvedAppBar(widget.title ?? l10n.myTrips),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          TextField(
            onChanged: (value) => setState(() => query = value),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: l10n.searchTripHint,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(spacing: 8, children: [
            for (final value in ['All', 'Today', 'Completed'])
              ChoiceChip(
                  label: Text(filterLabel(value)),
                  selected: filter == value,
                  onSelected: (_) => setState(() => filter = value)),
          ]),
          if (!current && !completed)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 48),
              child: EmptyState(
                  title: l10n.noTripsFound,
                  message: l10n.tryAnotherSearch),
            ),
          if (current) ...[
            const SizedBox(height: 20),
            Text(
              l10n.todaySectionLabel,
              style: const TextStyle(
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
            Text(
              l10n.recentlyCompleted,
              style: const TextStyle(
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
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: curvedAppBar(l10n.completedTripTitle),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        const TripSummaryCard(
            id: 'N1-2027',
            pickup: 'Factory B',
            destination: 'Warehouse C',
            completed: true),
        const SizedBox(height: 24),
        SectionHeader(title: l10n.deliverySummary),
        const SizedBox(height: 12),
        Card(
            child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(children: [
                  InfoRow(
                      icon: Icons.tag, label: l10n.tripId, value: 'N1-2027'),
                  const Divider(),
                  InfoRow(
                      icon: Icons.check_circle_outline,
                      label: l10n.status,
                      value: l10n.completed),
                  const Divider(),
                  InfoRow(
                      icon: Icons.schedule,
                      label: l10n.completedAtLabel,
                      value: formatReportDate(
                          context, DateTime(2026, 9, 18, 9, 45))),
                ]))),
        const SizedBox(height: 16),
        Text(l10n.deliveryDocsUnavailable,
            style: const TextStyle(color: AppColors.muted)),
      ]),
    );
  }
}

class _TripListItem extends StatelessWidget {
  const _TripListItem({this.onTap, this.completed = false});
  final VoidCallback? onTap;
  final bool completed;
  @override
  Widget build(BuildContext context) {
    if (completed) {
      return TripSummaryCard(
        id: 'N1-2027',
        pickup: 'Factory B',
        destination: 'Warehouse C',
        completed: true,
        onTap: onTap,
      );
    }
    return ValueListenableBuilder<int>(
      valueListenable: currentTripStage,
      builder: (context, stage, _) => TripSummaryCard(
        id: demoTrip.id,
        pickup: demoTrip.pickup,
        destination: demoTrip.destination,
        material: '${demoTrip.material} · ${demoTrip.quantity}',
        schedule: demoTrip.time,
        distance: demoTrip.distance,
        progress: stage / (totalTripStages - 1),
        onTap: onTap,
      ),
    );
  }
}

class TripDetailScreen extends StatelessWidget {
  const TripDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: curvedAppBar(l10n.tripDetailsTitle),
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
                                  Text(l10n.tripId,
                                      style: const TextStyle(
                                          color: Colors.white54, fontSize: 12)),
                                  const SizedBox(height: 7),
                                  Text(demoTrip.id,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 26,
                                          fontWeight: FontWeight.w600)),
                                ])),
                            TripStatusPill(label: l10n.assignedStatus, dark: true),
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
                                    label: l10n.estimatedTime('10:00 AM'),
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
                                      label: l10n.material,
                                      value: demoTrip.material,
                                      dark: true),
                                  const SizedBox(height: 22),
                                  TripFact(
                                      label: l10n.quantity,
                                      value: demoTrip.quantity,
                                      dark: true),
                                  const SizedBox(height: 22),
                                  TripFact(
                                      // TODO: no matching ARB key for "Estimated distance"; left as literal.
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
                                  label: l10n.assignedVehicleLabel,
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
                  label: l10n.startTrip,
                  icon: Icons.play_arrow,
                  onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ActiveTripScreen()))),
            ]),
          )),
        ),
      );
  }
}

class ActiveTripScreen extends StatefulWidget {
  const ActiveTripScreen({super.key});
  @override
  State<ActiveTripScreen> createState() => _ActiveTripScreenState();
}

class _ActiveTripScreenState extends State<ActiveTripScreen> {
  final _quantityController = TextEditingController();
  final _receiverController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Reset shared progress each time a trip is started, so a stale value
    // from a previous run doesn't leak into trip cards elsewhere.
    currentTripStage.value = 1;
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _receiverController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  List<String> _labels(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      l10n.stageStarted,
      l10n.stageGoingToPickup,
      l10n.stageArrivedAtPickup,
      l10n.stageLoadingMaterial,
      l10n.stageDelivering,
      l10n.stageArrivedAtDestination,
      l10n.stageCompleted,
    ];
  }

  DateTime? _completedAt;

  void _advance(int lastStep) {
    final next = (currentTripStage.value + 1).clamp(0, lastStep);
    currentTripStage.value = next;
    if (next == lastStep) _completedAt = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final labels = _labels(context);
    final lastStep = labels.length - 1;
    return ValueListenableBuilder<int>(
      valueListenable: currentTripStage,
      builder: (context, step, _) {
        final tripCompleted = step == lastStep;
        return Scaffold(
        appBar: curvedAppBar(l10n.activeTripTitle),
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
                      onPressed: tripCompleted
                          ? () => Navigator.of(context)
                              .popUntil((route) => route.isFirst)
                          : () => _advance(lastStep),
                      icon: Icon(tripCompleted
                          ? Icons.home_outlined
                          : Icons.arrow_forward),
                      label: Text(
                          tripCompleted
                              ? l10n.backToHome
                              : step < 2
                                  ? l10n.arrivedAtPickup
                                  : step == 2
                                      ? l10n.startLoading
                                      : step == 3
                                          ? l10n.confirmLoading
                                          : step == 4
                                              ? l10n.continueTrip
                                              : l10n.completeDelivery,
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
                            Text(l10n.tripId,
                                style: const TextStyle(
                                    color: Colors.white54, fontSize: 12)),
                            const SizedBox(height: 7),
                            Text(demoTrip.id,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 26,
                                    fontWeight: FontWeight.w600)),
                          ])),
                      TripStatusPill(label: l10n.inProgressStatus, dark: true),
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
                                  label: l10n.pickup,
                                  value: demoTrip.pickup,
                                  dark: true)),
                          const Padding(
                              padding: EdgeInsets.fromLTRB(8, 20, 12, 0),
                              child: Icon(Icons.east,
                                  size: 18, color: tripAccent)),
                          Expanded(
                              child: TripFact(
                                  label: l10n.delivery,
                                  value: demoTrip.destination,
                                  dark: true)),
                        ]),
                    const Padding(
                        padding: EdgeInsets.symmetric(vertical: 22),
                        child: Divider(color: Colors.white10, height: 1)),
                    Text(l10n.tripProgress,
                        style: const TextStyle(
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
                            isNext: i == step + 1,
                            last: i == labels.length - 1)),
                    if (step == 3) ...[
                      const SizedBox(height: 22),
                      _InlineLoadingForm(controller: _quantityController),
                    ],
                    if (step == 5) ...[
                      const SizedBox(height: 22),
                      _InlineDeliveryForm(
                          receiverController: _receiverController,
                          noteController: _noteController),
                    ],
                    if (tripCompleted) ...[
                      const SizedBox(height: 22),
                      _InlineCompletedCard(completedAt: _completedAt),
                    ],
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
                                label: l10n.assignedVehicleLabel,
                                value: demoTrip.vehicle,
                                dark: true)),
                      ]),
                    ),
                  ]),
            ),
          )),
        ),
      );
      },
    );
  }
}

class _InlineLoadingForm extends StatelessWidget {
  const _InlineLoadingForm({required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: .05),
          borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.loadingMaterialTitle,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700)),
          const SizedBox(height: 14),
          TripFact(
              label: l10n.material,
              value: l10n.plannedQuantity('25 Tons'),
              dark: true),
          const SizedBox(height: 16),
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white),
            cursorColor: tripAccent,
            decoration: InputDecoration(
              labelText: l10n.actualQuantity,
              suffixText: l10n.tons,
              filled: true,
              fillColor: Colors.white.withValues(alpha: .08),
              labelStyle: const TextStyle(color: Colors.white54),
              suffixStyle: const TextStyle(color: Colors.white54),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.white24)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: tripAccent)),
            ),
          ),
          const SizedBox(height: 14),
          Container(
            height: 96,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white24),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Icon(Icons.add_a_photo_outlined,
                  size: 30, color: tripAccent),
            ),
          ),
        ],
      ),
    );
  }
}

class _InlineDeliveryForm extends StatelessWidget {
  const _InlineDeliveryForm({
    required this.receiverController,
    required this.noteController,
  });
  final TextEditingController receiverController, noteController;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    InputDecoration fieldDecoration(String label) => InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white.withValues(alpha: .08),
          labelStyle: const TextStyle(color: Colors.white54),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.white24)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: tripAccent)),
        );
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: .05),
          borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.captureDeliveryDetails,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700)),
          const SizedBox(height: 14),
          Container(
            height: 96,
            decoration: BoxDecoration(
              color: tripAccent.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Icon(Icons.add_a_photo_outlined,
                  size: 30, color: tripAccent),
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: receiverController,
            style: const TextStyle(color: Colors.white),
            cursorColor: tripAccent,
            decoration: fieldDecoration(l10n.receiverName),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: noteController,
            maxLines: 2,
            style: const TextStyle(color: Colors.white),
            cursorColor: tripAccent,
            decoration: fieldDecoration(l10n.deliveryNote),
          ),
        ],
      ),
    );
  }
}

class _InlineCompletedCard extends StatelessWidget {
  const _InlineCompletedCard({required this.completedAt});
  final DateTime? completedAt;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: .05),
          borderRadius: BorderRadius.circular(24)),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.success,
            child: Icon(Icons.check, color: Colors.white, size: 32),
          ),
          const SizedBox(height: 14),
          Text(l10n.tripCompletedTitle,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w900)),
          const SizedBox(height: 6),
          const Text('N1-2034 · Cement · 25 Tons',
              style: TextStyle(color: Colors.white54)),
          if (completedAt != null) ...[
            const SizedBox(height: 4),
            Text(
                l10n.completedAtTime(
                    TimeOfDay.fromDateTime(completedAt!).format(context)),
                style: const TextStyle(
                    color: tripAccent, fontWeight: FontWeight.w600)),
          ],
        ],
      ),
    );
  }
}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow(
      {required this.label,
      required this.current,
      required this.done,
      required this.isNext,
      required this.last});
  final String label;
  final bool current, done, isNext, last;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final state = done
        ? l10n.semStateComplete
        : current
            ? l10n.semStateCurrent
            : l10n.semStatePending;
    // Only the current step and the one right after it stay fully
    // detailed; everything else (already done, or further away) collapses
    // to a slim row so the list doesn't dominate the page once the trip
    // is underway.
    final expanded = current || isNext;
    final dotSize = expanded ? 25.0 : 18.0;
    final connectorDots = expanded ? 3 : 1;
    return Semantics(
        label: l10n.semTimelineLabel(label, state),
        child: ExcludeSemantics(
            child: Padding(
          padding: EdgeInsets.only(bottom: last ? 0 : (expanded ? 8 : 3)),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Column(children: [
              Container(
                  width: dotSize,
                  height: dotSize,
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
                          ? (expanded ? 16 : 11)
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
                    connectorDots,
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
              padding: EdgeInsets.only(top: expanded ? 3 : 1),
              child: Text(label,
                  style: TextStyle(
                      fontSize: expanded ? 14 : 12,
                      fontWeight: current ? FontWeight.w700 : FontWeight.w400,
                      color: current
                          ? tripAccent
                          : done
                              ? Colors.white70
                              : Colors.white38)),
            )),
          ]),
        )),
      );
  }
}

