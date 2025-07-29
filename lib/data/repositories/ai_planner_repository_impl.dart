import '../../domain/repositories/ai_planner_repository.dart';
import '../../domain/entities/destination.dart';
import '../../domain/entities/trip.dart';
import '../datasources/ai_planner_remote_datasource.dart';

class AiPlannerRepositoryImpl implements AiPlannerRepository {
  final AiPlannerRemoteDataSource _remoteDataSource;

  AiPlannerRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<Destination>> searchDestinations(String query) async {
    try {
      return await _remoteDataSource.searchDestinations(query);
    } catch (e) {
      throw Exception('Failed to search destinations: $e');
    }
  }

  @override
  Future<Trip> generateTripPlan({
    required String destination,
    required DateTime startDate,
    required DateTime endDate,
    required double budget,
    required List<String> interests,
  }) async {
    try {
      return await _remoteDataSource.generateTripPlan(
        destination: destination,
        startDate: startDate,
        endDate: endDate,
        budget: budget,
        interests: interests,
      );
    } catch (e) {
      throw Exception('Failed to generate trip plan: $e');
    }
  }

  @override
  Future<List<String>> getRecommendations(String destination) async {
    try {
      return await _remoteDataSource.getRecommendations(destination);
    } catch (e) {
      throw Exception('Failed to get recommendations: $e');
    }
  }

  @override
  Future<String> getTravelAdvice(String destination) async {
    try {
      return await _remoteDataSource.getTravelAdvice(destination);
    } catch (e) {
      throw Exception('Failed to get travel advice: $e');
    }
  }
} 