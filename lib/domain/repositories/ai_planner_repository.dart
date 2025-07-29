import '../entities/trip.dart';
import '../entities/destination.dart';

abstract class AiPlannerRepository {
  Future<List<Destination>> searchDestinations(String query);
  Future<Trip> generateTripPlan({
    required String destination,
    required DateTime startDate,
    required DateTime endDate,
    required double budget,
    required List<String> interests,
    required int travelers,
  });
  Future<List<Destination>> getRecommendedDestinations({
    required double budget,
    required List<String> interests,
    required String preferredClimate,
  });
  Future<String> getTravelAdvice(String destination);
} 