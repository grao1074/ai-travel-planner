import '../../domain/entities/trip.dart';
import '../../domain/repositories/trip_repository.dart';
import '../datasources/trip_local_datasource.dart';
import '../models/trip_model.dart';

class TripRepositoryImpl implements TripRepository {
  final TripLocalDataSource _localDataSource;

  TripRepositoryImpl(this._localDataSource);

  @override
  Future<List<Trip>> getAllTrips() async {
    try {
      final tripModels = await _localDataSource.getAllTrips();
      return tripModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to get trips: $e');
    }
  }

  @override
  Future<Trip?> getTripById(String id) async {
    try {
      final tripModel = await _localDataSource.getTripById(id);
      return tripModel?.toEntity();
    } catch (e) {
      throw Exception('Failed to get trip: $e');
    }
  }

  @override
  Future<Trip> createTrip(Trip trip) async {
    try {
      final tripModel = TripModel.fromEntity(trip);
      await _localDataSource.saveTrip(tripModel);
      return trip;
    } catch (e) {
      throw Exception('Failed to create trip: $e');
    }
  }

  @override
  Future<Trip> updateTrip(Trip trip) async {
    try {
      final tripModel = TripModel.fromEntity(trip);
      await _localDataSource.updateTrip(tripModel);
      return trip;
    } catch (e) {
      throw Exception('Failed to update trip: $e');
    }
  }

  @override
  Future<void> deleteTrip(String id) async {
    try {
      await _localDataSource.deleteTrip(id);
    } catch (e) {
      throw Exception('Failed to delete trip: $e');
    }
  }

  @override
  Future<List<Trip>> searchTrips(String query) async {
    try {
      final allTrips = await getAllTrips();
      return allTrips.where((trip) =>
        trip.name.toLowerCase().contains(query.toLowerCase()) ||
        trip.description.toLowerCase().contains(query.toLowerCase()) ||
        trip.destinations.any((dest) =>
          dest.name.toLowerCase().contains(query.toLowerCase()) ||
          dest.city.toLowerCase().contains(query.toLowerCase())
        )
      ).toList();
    } catch (e) {
      throw Exception('Failed to search trips: $e');
    }
  }

  @override
  Future<List<Trip>> getTripsByStatus(TripStatus status) async {
    try {
      final allTrips = await getAllTrips();
      return allTrips.where((trip) => trip.status == status).toList();
    } catch (e) {
      throw Exception('Failed to get trips by status: $e');
    }
  }
} 