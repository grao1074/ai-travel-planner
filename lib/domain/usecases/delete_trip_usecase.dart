import '../repositories/trip_repository.dart';

class DeleteTripUseCase {
  final TripRepository _tripRepository;

  DeleteTripUseCase(this._tripRepository);

  Future<void> execute(String id) async {
    return await _tripRepository.deleteTrip(id);
  }
}
