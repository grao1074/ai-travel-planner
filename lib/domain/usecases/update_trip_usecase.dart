import '../entities/trip.dart';
import '../repositories/trip_repository.dart';

class UpdateTripUseCase {
  final TripRepository _tripRepository;

  UpdateTripUseCase(this._tripRepository);

  Future<Trip> execute(Trip trip) async {
    return await _tripRepository.updateTrip(trip);
  }
}
