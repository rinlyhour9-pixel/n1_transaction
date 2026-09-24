/// A vehicle assigned to a driver, plus its live fuel level.
///
/// Mirrors the "My Vehicle" and fuel dashboard screens, which previously
/// repeated the same plate/driver/fuel numbers as separate string literals
/// scattered across each screen file.
class Vehicle {
  const Vehicle({
    required this.plate,
    required this.type,
    required this.driverName,
    required this.driverId,
    required this.capacityLiters,
    required this.fuelPercent,
  });

  final String plate, type, driverName, driverId;
  final int capacityLiters;
  final double fuelPercent;

  int get remainingLiters => (capacityLiters * fuelPercent).round();
  bool get isLowFuel => fuelPercent <= .35;
}

const demoVehicle = Vehicle(
  plate: 'PP 3A-1234',
  type: 'Cement Truck',
  driverName: 'Dara Sok',
  driverId: 'DR-001',
  capacityLiters: 300,
  fuelPercent: 0.35,
);
