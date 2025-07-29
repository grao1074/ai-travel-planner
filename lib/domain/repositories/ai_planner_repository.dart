import '../entities/destination.dart';
import '../entities/trip.dart';

abstract class AiPlannerRepository {
  Future<List<Destination>> searchDestinations(String query);
  
  Future<Trip> generateTripPlan({
    required String destination,
    required DateTime startDate,
    required DateTime endDate,
    required double budget,
    required List<String> interests,
  });
  
  Future<List<String>> getRecommendations(String destination);
  
  Future<String> getTravelAdvice(String destination);
} 