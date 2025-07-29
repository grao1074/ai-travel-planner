import '../../domain/entities/trip.dart';
import '../../domain/entities/destination.dart';
import '../../domain/repositories/ai_planner_repository.dart';
import '../datasources/ai_planner_remote_datasource.dart';
import '../models/trip_model.dart';
import '../models/destination_model.dart';

class AiPlannerRepositoryImpl implements AiPlannerRepository {
  final AiPlannerRemoteDataSource _remoteDataSource;

  AiPlannerRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<Destination>> searchDestinations(String query) async {
    try {
      final destinationModels = await _remoteDataSource.searchDestinations(query);
      return destinationModels.map((model) => model.toEntity()).toList();
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
    required int travelers,
  }) async {
    try {
      final tripModel = await _remoteDataSource.generateTripPlan(
        destination: destination,
        startDate: startDate,
        endDate: endDate,
        budget: budget,
        interests: interests,
        travelers: travelers,
      );
      return tripModel.toEntity();
    } catch (e) {
      throw Exception('Failed to generate trip plan: $e');
    }
  }

  @override
  Future<List<Destination>> getRecommendedDestinations({
    required double budget,
    required List<String> interests,
    required String preferredClimate,
  }) async {
    try {
      final destinationModels = await _remoteDataSource.getRecommendedDestinations(
        budget: budget,
        interests: interests,
        preferredClimate: preferredClimate,
      );
      return destinationModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to get recommended destinations: $e');
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