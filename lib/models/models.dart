/// Central export for the app's data models.
///
/// Each domain concept gets its own folder under `lib/models/` (`trip/`,
/// `vehicle/`, ...), holding its class plus the demo data screens render
/// until a real API is wired in. Import this file instead of reaching into
/// individual model folders — see `README.md` in this directory for the
/// full convention.
library;

export 'trip/trip.dart';
export 'vehicle/vehicle.dart';
export 'fuel_request/fuel_request.dart';
export 'notification/notification_item.dart';
