import 'package:flutter/material.dart';
import '../../l10n/generated/app_localizations.dart';

const tripAccent = Color(0xFFFF875F);

class TripSummaryCard extends StatelessWidget {
  const TripSummaryCard(
      {super.key,
      required this.id,
      required this.pickup,
      required this.destination,
      this.material,
      this.schedule,
      this.distance,
      this.completed = false,
      this.progress,
      this.onTap});
  final String id, pickup, destination;
  final String? material, schedule, distance;
  final bool completed;

  /// How far through the journey the trip is (0.0-1.0). Passed straight
  /// through to [TripProgressLine]; see there for details.
  final double? progress;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Material(
      color: dark ? const Color(0xFF242424) : Colors.white,
      borderRadius: BorderRadius.circular(28),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                      color: tripAccent.withValues(alpha: .12),
                      shape: BoxShape.circle),
                  child: const Icon(Icons.local_shipping_outlined,
                      color: tripAccent, size: 23)),
              const SizedBox(width: 10),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(id,
                        style: const TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w700)),
                    if (material != null) ...[
                      const SizedBox(height: 3),
                      Text(material!,
                          style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant)),
                    ],
                  ])),
              const SizedBox(width: 8),
              TripStatusPill(
                  label: completed ? l10n.completed : l10n.assignedStatus),
            ]),
            const SizedBox(height: 22),
            Row(children: [
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    TripProgressLine(completed: completed, progress: progress),
                    const SizedBox(height: 16),
                    Text(
                        schedule ??
                            (completed
                                ? l10n.tripCompletedNote
                                : l10n.readyToDepart),
                        style: TextStyle(
                            fontSize: 11,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant)),
                    if (distance != null) ...[
                      const SizedBox(height: 4),
                      Text(l10n.routeDistance(distance!),
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600)),
                    ],
                  ])),
              const SizedBox(width: 12),
              const CargoArtwork(size: 76),
            ]),
            const SizedBox(height: 14),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(child: TripFact(label: l10n.pickup, value: pickup)),
              const Padding(
                  padding: EdgeInsets.fromLTRB(8, 18, 12, 0),
                  child: Icon(Icons.east, size: 17, color: tripAccent)),
              Expanded(
                  child: TripFact(label: l10n.delivery, value: destination)),
            ]),
          ]),
        ),
      ),
    );
  }
}

class TripStatusPill extends StatelessWidget {
  const TripStatusPill({super.key, required this.label, this.dark = false});
  final String label;
  final bool dark;
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
            color: dark
                ? Colors.white.withValues(alpha: .08)
                : tripAccent.withValues(alpha: .10),
            borderRadius: BorderRadius.circular(30)),
        child: Text(label,
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: dark ? Colors.white : const Color(0xFFAA4825))),
      );
}

class TripProgressLine extends StatelessWidget {
  const TripProgressLine(
      {super.key, this.completed = false, this.dark = false, this.progress});
  final bool completed, dark;

  /// How far through the journey the trip is, from 0.0 to 1.0. When null,
  /// falls back to the simple started/completed look. When set, the number
  /// of the 4 segments lit up scales with progress, so this compact bar
  /// stays in sync with the detailed stage list on the active-trip screen.
  final double? progress;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final filledCount = completed
        ? 4
        : progress == null
            ? 1
            : (progress! * 4).ceil().clamp(1, 4);
    return Semantics(
        label: completed
            ? l10n.tripCompletedNote
            : l10n.tripAssignedSemantics,
        child: ExcludeSemantics(
            child: Row(children: [
          for (var i = 0; i < 4; i++) ...[
            if (i > 0)
              Expanded(
                  child: LayoutBuilder(
                      builder: (context, constraints) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(
                                (constraints.maxWidth / 7).floor().clamp(1, 40),
                                (_) => Container(
                                      width: 3,
                                      height: 3,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: i < filledCount
                                              ? tripAccent
                                              : dark
                                                  ? Colors.white24
                                                  : const Color(0xFFD9D9D9)),
                                    )),
                          ))),
            Container(
                width: 23,
                height: 23,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: i < filledCount
                            ? tripAccent
                            : dark
                                ? Colors.white24
                                : const Color(0xFFDDDDDD))),
                child: Icon(
                    i < filledCount
                        ? Icons.check_circle
                        : Icons.circle_outlined,
                    size: 17,
                    color: i < filledCount
                        ? tripAccent
                        : dark
                            ? Colors.white30
                            : const Color(0xFFD0D0D0))),
          ],
        ])),
      );
  }
}

class TripFact extends StatelessWidget {
  const TripFact(
      {super.key, required this.label, required this.value, this.dark = false});
  final String label, value;
  final bool dark;
  @override
  Widget build(BuildContext context) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label,
            style: TextStyle(
                fontSize: 12,
                color: dark
                    ? Colors.white54
                    : Theme.of(context).colorScheme.onSurfaceVariant)),
        const SizedBox(height: 6),
        Text(value,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: dark ? Colors.white : null,
                height: 1.35)),
      ]);
}

/// A code-drawn cargo illustration that stays crisp at every screen size.
class CargoArtwork extends StatelessWidget {
  const CargoArtwork({super.key, this.size = 110});
  final double size;
  @override
  Widget build(BuildContext context) => ExcludeSemantics(
          child: SizedBox(
        width: size,
        height: size,
        child: CustomPaint(painter: _CargoPainter()),
      ));
}

class _CargoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.scale(size.width / 100, size.height / 100);
    void face(List<Offset> points, Color color) {
      final path = Path()..addPolygon(points, true);
      canvas.drawPath(path, Paint()..color = color);
    }

    canvas.drawOval(const Rect.fromLTWH(7, 85, 88, 10),
        Paint()..color = Colors.black.withValues(alpha: .09));
    face(const [Offset(7, 26), Offset(58, 8), Offset(94, 26), Offset(44, 44)],
        const Color(0xFFFFD58C));
    face(const [Offset(7, 26), Offset(44, 44), Offset(44, 92), Offset(7, 72)],
        const Color(0xFFEAA64F));
    face(const [Offset(44, 44), Offset(94, 26), Offset(94, 76), Offset(44, 92)],
        const Color(0xFFF7BF68));
    face(const [Offset(25, 20), Offset(35, 16), Offset(73, 34), Offset(63, 38)],
        const Color(0xFFFFE7BA));
    face(const [Offset(63, 38), Offset(73, 34), Offset(73, 83), Offset(63, 86)],
        const Color(0xFFECD4AA));
    face(const [Offset(79, 47), Offset(89, 43), Offset(89, 60), Offset(79, 64)],
        const Color(0xFFF5F8F9));
    face(const [Offset(81, 50), Offset(87, 48), Offset(87, 54), Offset(81, 56)],
        const Color(0xFF8FB7BB));
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _CargoPainter oldDelegate) => false;
}
