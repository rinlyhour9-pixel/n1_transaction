import 'package:flutter/material.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../features/auth/auth_flow.dart';

enum NotificationType { newTrip, fuelApproved }

/// How long ago a notification arrived — kept as data rather than a
/// pre-formatted string so both languages render correctly.
enum NotificationTime { now, twoHoursAgo }

extension NotificationTimeDetails on NotificationTime {
  String label(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return switch (this) {
      NotificationTime.now => l10n.notifNow,
      NotificationTime.twoHoursAgo => l10n.notif2h,
    };
  }
}

/// A single alert on the notifications screen, e.g. a new trip assignment
/// or a fuel request update. [tripId]/[tripTime] fill the new-trip message,
/// [fuelLiters]/[vehiclePlate] fill the fuel-approved one. [roles] limits
/// which signed-in role sees the alert; leave it null to show it to everyone.
class NotificationItem {
  const NotificationItem({
    required this.type,
    required this.time,
    this.unread = false,
    this.tripId,
    this.tripTime,
    this.fuelLiters,
    this.vehiclePlate,
    this.roles,
  });

  final NotificationType type;
  final NotificationTime time;
  final bool unread;
  final String? tripId, tripTime, fuelLiters, vehiclePlate;
  final List<AppRole>? roles;

  bool visibleTo(AppRole role) => roles == null || roles!.contains(role);

  IconData get icon => switch (type) {
        NotificationType.newTrip => Icons.route,
        NotificationType.fuelApproved => Icons.local_gas_station,
      };

  String title(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return switch (type) {
      NotificationType.newTrip => l10n.notifNewTripTitle,
      NotificationType.fuelApproved => l10n.notifFuelApprovedTitle,
    };
  }

  String subtitle(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return switch (type) {
      NotificationType.newTrip => l10n.notifNewTripSubtitle(tripId!, tripTime!),
      NotificationType.fuelApproved =>
        l10n.notifFuelApprovedSubtitle(fuelLiters!, vehiclePlate!),
    };
  }
}

const demoNotifications = [
  NotificationItem(
    type: NotificationType.newTrip,
    time: NotificationTime.now,
    unread: true,
    tripId: 'N1-2034',
    tripTime: '08:30 AM',
    roles: [AppRole.driver],
  ),
  NotificationItem(
    type: NotificationType.fuelApproved,
    time: NotificationTime.twoHoursAgo,
    fuelLiters: '120 L',
    vehiclePlate: 'PP 3A-1234',
    roles: [AppRole.driver, AppRole.fuelStockManager],
  ),
];
