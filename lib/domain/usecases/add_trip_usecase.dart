import '../entities/trip.dart';
import '../repositories/trip_repository.dart';

class AddTripUseCase {
  final TripRepository _tripRepository;

  AddTripUseCase(this._tripRepository);

  Future<Trip> execute(Trip trip) async {
    return await _tripRepository.createTrip(trip);
  }
}
