import '../entities/trip.dart';

abstract class TripRepository {
  Future<List<Trip>> getAllTrips();
  Future<Trip?> getTripById(String id);
  Future<Trip> createTrip(Trip trip);
  Future<Trip> updateTrip(Trip trip);
  Future<void> deleteTrip(String id);
  Future<List<Trip>> searchTrips(String query);
  Future<List<Trip>> getTripsByStatus(TripStatus status);
} 