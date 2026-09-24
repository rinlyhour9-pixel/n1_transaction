import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../l10n/generated/app_localizations.dart';

/// Why a driver is requesting fuel — the choices offered on the fuel
/// request form, and the reason shown on a request card.
enum FuelReason { currentTrip, nextTrip, lowFuel, other }

extension FuelReasonDetails on FuelReason {
  String label(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return switch (this) {
      FuelReason.currentTrip => l10n.reasonCurrentTrip,
      FuelReason.nextTrip => l10n.reasonNextTrip,
      FuelReason.lowFuel => l10n.reasonLowFuel,
      FuelReason.other => l10n.reasonOther,
    };
  }

  IconData get icon => switch (this) {
        FuelReason.currentTrip => Icons.check_circle,
        FuelReason.nextTrip => Icons.event_outlined,
        FuelReason.lowFuel => Icons.error_outline,
        FuelReason.other => Icons.more_horiz,
      };
}

enum FuelRequestStatus { pending, approved, rejected }

extension FuelRequestStatusDetails on FuelRequestStatus {
  String label(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return switch (this) {
      FuelRequestStatus.pending => l10n.statusPending,
      FuelRequestStatus.approved => l10n.statusApproved,
      FuelRequestStatus.rejected => l10n.statusRejected,
    };
  }

  Color get color => switch (this) {
        FuelRequestStatus.pending => AppColors.warning,
        FuelRequestStatus.approved => AppColors.success,
        FuelRequestStatus.rejected => AppColors.error,
      };
}

/// A driver's request to draw fuel for a trip, tracked from submission
/// through the fuel stock manager's approval.
class FuelRequest {
  const FuelRequest({
    required this.id,
    required this.driverName,
    required this.vehiclePlate,
    required this.liters,
    required this.reason,
    required this.location,
    required this.date,
    this.tripId,
    this.status = FuelRequestStatus.pending,
  });

  final String id, driverName, vehiclePlate, location, date;
  final int liters;
  final FuelReason reason;
  final String? tripId;
  final FuelRequestStatus status;

  /// The reason label with its trip id appended when there is one, e.g.
  /// "Current Trip · N1-2034".
  String reasonLabel(BuildContext context) {
    final label = reason.label(context);
    return tripId == null ? label : '$label · $tripId';
  }

  FuelRequest copyWith({FuelRequestStatus? status}) => FuelRequest(
        id: id,
        driverName: driverName,
        vehiclePlate: vehiclePlate,
        liters: liters,
        reason: reason,
        location: location,
        date: date,
        tripId: tripId,
        status: status ?? this.status,
      );
}

/// Dara Sok's own request history, shown on the driver's fuel screen.
const demoFuelRequests = [
  FuelRequest(
    id: 'FR-041',
    driverName: 'Dara Sok',
    vehiclePlate: 'PP 3A-1234',
    liters: 120,
    reason: FuelReason.currentTrip,
    tripId: 'N1-2034',
    location: 'Main Depot',
    date: 'Today · 07:10 AM',
    status: FuelRequestStatus.approved,
  ),
  FuelRequest(
    id: 'FR-038',
    driverName: 'Dara Sok',
    vehiclePlate: 'PP 3A-1234',
    liters: 80,
    reason: FuelReason.lowFuel,
    location: 'Site A',
    date: 'Sep 14 · 04:20 PM',
    status: FuelRequestStatus.pending,
  ),
  FuelRequest(
    id: 'FR-030',
    driverName: 'Dara Sok',
    vehiclePlate: 'PP 3A-1234',
    liters: 100,
    reason: FuelReason.currentTrip,
    location: 'Main Depot',
    date: 'Sep 09 · 08:30 AM',
    status: FuelRequestStatus.approved,
  ),
  FuelRequest(
    id: 'FR-021',
    driverName: 'Dara Sok',
    vehiclePlate: 'PP 3A-1234',
    liters: 60,
    reason: FuelReason.other,
    location: 'Site B',
    date: 'Sep 01 · 02:15 PM',
    status: FuelRequestStatus.rejected,
  ),
];

/// Requests still awaiting a decision, across all drivers — shown on the
/// fuel stock manager's approval queue.
const demoPendingFuelRequests = [
  FuelRequest(
    id: 'FR-045',
    driverName: 'Dara Sok',
    vehiclePlate: 'PP 3A-1234',
    liters: 120,
    reason: FuelReason.currentTrip,
    tripId: 'N1-2034',
    location: 'Main Depot',
    date: 'Today · 09:05 AM',
  ),
  FuelRequest(
    id: 'FR-046',
    driverName: 'Vannak Lim',
    vehiclePlate: 'PP 2D-9090',
    liters: 80,
    reason: FuelReason.lowFuel,
    location: 'Site A',
    date: 'Today · 09:40 AM',
  ),
];
