enum TripStage {
  assigned,
  pickup,
  loading,
  delivering,
  destination,
  unloading,
  completed,
}

class Trip {
  const Trip({
    required this.id,
    required this.material,
    required this.quantity,
    required this.vehicle,
    required this.pickup,
    required this.destination,
    required this.time,
    required this.distance,
    this.stage = TripStage.assigned,
  });
  final String id,
      material,
      quantity,
      vehicle,
      pickup,
      destination,
      time,
      distance;
  final TripStage stage;
  Trip copyWith({TripStage? stage}) => Trip(
        id: id,
        material: material,
        quantity: quantity,
        vehicle: vehicle,
        pickup: pickup,
        destination: destination,
        time: time,
        distance: distance,
        stage: stage ?? this.stage,
      );
}

const demoTrip = Trip(
  id: 'N1-2034',
  material: 'Cement',
  quantity: '25 Tons',
  vehicle: 'PP 3A-1234',
  pickup: 'N1 Cement Factory',
  destination: 'Construction Site A',
  time: 'Today, 08:30 AM',
  distance: '42 km',
);
