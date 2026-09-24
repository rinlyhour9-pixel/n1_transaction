# models/

Plain data classes for the app's domain concepts — no `Widget`s, no
`BuildContext` required to construct one. One folder per concept, same
convention as our other Flutter/.NET projects:

```
models/
  models.dart              <- import this, not the files below
  trip/trip.dart
  vehicle/vehicle.dart
  fuel_request/fuel_request.dart
  notification/notification_item.dart
```

Each file holds:
- the class (and any enum it needs, e.g. `FuelRequestStatus`)
- an `extension` with `label(context)` / `color` getters when a field
  needs localized text or a themed color to display
- `const demo...` data the UI renders today, in place of a real API

Screens import `models/models.dart` and read these — they don't declare
their own copies of "Dara Sok" or "PP 3A-1234" inline. When the app gets
a real backend, the demo constants are what gets replaced with API calls;
the classes and the screens that consume them stay the same.

Adding a new concept: make a new folder, write the class the same way,
and add an `export` line to `models.dart`.
