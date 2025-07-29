import 'package:dio/dio.dart';
import '../../domain/entities/trip.dart';
import '../../domain/entities/destination.dart';
import '../models/trip_model.dart';
import '../models/destination_model.dart';

abstract class AiPlannerRemoteDataSource {
  Future<List<DestinationModel>> searchDestinations(String query);
  Future<TripModel> generateTripPlan({
    required String destination,
    required DateTime startDate,
    required DateTime endDate,
    required double budget,
    required List<String> interests,
    required int travelers,
  });
  Future<List<DestinationModel>> getRecommendedDestinations({
    required double budget,
    required List<String> interests,
    required String preferredClimate,
  });
  Future<String> getTravelAdvice(String destination);
}

class AiPlannerRemoteDataSourceImpl implements AiPlannerRemoteDataSource {
  final Dio _dio;
  
  AiPlannerRemoteDataSourceImpl(this._dio);

  @override
  Future<List<DestinationModel>> searchDestinations(String query) async {
    try {
      // Simulate API call - in real app, this would call an actual AI service
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock data for demonstration
      return [
        DestinationModel(
          id: '1',
          name: 'Paris',
          country: 'France',
          city: 'Paris',
          description: 'The City of Light',
          latitude: 48.8566,
          longitude: 2.3522,
          imageUrl: 'https://example.com/paris.jpg',
          attractions: ['Eiffel Tower', 'Louvre Museum', 'Notre-Dame'],
          weatherInfo: 'Mild climate with four seasons',
          bestTimeToVisit: 'April to October',
        ),
        DestinationModel(
          id: '2',
          name: 'Tokyo',
          country: 'Japan',
          city: 'Tokyo',
          description: 'Modern metropolis with rich culture',
          latitude: 35.6762,
          longitude: 139.6503,
          imageUrl: 'https://example.com/tokyo.jpg',
          attractions: ['Shibuya Crossing', 'Senso-ji Temple', 'Tokyo Skytree'],
          weatherInfo: 'Humid subtropical climate',
          bestTimeToVisit: 'March to May and September to November',
        ),
      ];
    } catch (e) {
      throw Exception('Failed to search destinations: $e');
    }
  }

  @override
  Future<TripModel> generateTripPlan({
    required String destination,
    required DateTime startDate,
    required DateTime endDate,
    required double budget,
    required List<String> interests,
    required int travelers,
  }) async {
    try {
      // Simulate AI trip planning
      await Future.delayed(const Duration(seconds: 2));
      
      // Mock generated trip plan
      return TripModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: 'AI Generated Trip to $destination',
        description: 'An amazing trip planned by AI based on your preferences',
        startDate: startDate,
        endDate: endDate,
        destinations: [
          DestinationModel(
            id: '1',
            name: destination,
            country: 'Unknown',
            city: destination,
            description: 'Your dream destination',
          ),
        ],
        activities: [
          // Mock activities would be generated here
        ],
        budget: budget,
        status: TripStatus.planning,
        createdAt: DateTime.now(),
      );
    } catch (e) {
      throw Exception('Failed to generate trip plan: $e');
    }
  }

  @override
  Future<List<DestinationModel>> getRecommendedDestinations({
    required double budget,
    required List<String> interests,
    required String preferredClimate,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock recommendations based on budget and interests
      return [
        DestinationModel(
          id: '1',
          name: 'Bali',
          country: 'Indonesia',
          city: 'Bali',
          description: 'Tropical paradise with rich culture',
        ),
        DestinationModel(
          id: '2',
          name: 'Barcelona',
          country: 'Spain',
          city: 'Barcelona',
          description: 'Mediterranean charm with amazing architecture',
        ),
      ];
    } catch (e) {
      throw Exception('Failed to get recommendations: $e');
    }
  }

  @override
  Future<String> getTravelAdvice(String destination) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock travel advice
      return '''
Travel Advice for $destination:

1. Best Time to Visit: Spring or Fall for pleasant weather
2. Local Currency: Check exchange rates before traveling
3. Language: Learn basic phrases in the local language
4. Transportation: Research public transport options
5. Safety: Keep important documents secure
6. Local Customs: Respect local traditions and customs
7. Emergency Contacts: Save local emergency numbers
8. Health: Check if vaccinations are required
9. Budget: Plan for unexpected expenses
10. Documentation: Ensure all travel documents are valid
      ''';
    } catch (e) {
      throw Exception('Failed to get travel advice: $e');
    }
  }
} 