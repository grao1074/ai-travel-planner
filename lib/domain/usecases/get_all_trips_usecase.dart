import '../entities/trip.dart';
import '../repositories/trip_repository.dart';

class GetAllTripsUseCase {
  final TripRepository _tripRepository;

  GetAllTripsUseCase(this._tripRepository);

  Future<List<Trip>> execute() async {
    return await _tripRepository.getAllTrips();
  }
} 