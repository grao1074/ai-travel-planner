import 'package:dio/dio.dart';
import '../models/destination_model.dart';
import '../models/trip_model.dart';
import '../models/activity_model.dart';
import '../../domain/entities/destination.dart';
import '../../domain/entities/trip.dart';
import '../../domain/entities/activity.dart';

class AiPlannerRemoteDataSource {
  final Dio _dio;

  AiPlannerRemoteDataSource(this._dio);

  Future<List<Destination>> searchDestinations(String query) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock data
    final destinations = [
      DestinationModel(
        id: '1',
        name: 'Eiffel Tower',
        country: 'France',
        city: 'Paris',
        description: 'Iconic iron lattice tower on the Champ de Mars in Paris.',
        latitude: 48.8584,
        longitude: 2.2945,
        imageUrl: 'https://example.com/eiffel.jpg',
        attractions: ['Tower viewing', 'Restaurant', 'Museum'],
        weatherInfo: 'Mild climate with occasional rain',
        bestTimeToVisit: 'April to October',
      ),
      DestinationModel(
        id: '2',
        name: 'Tokyo Tower',
        country: 'Japan',
        city: 'Tokyo',
        description: 'Communications and observation tower in Tokyo.',
        latitude: 35.6586,
        longitude: 139.7454,
        imageUrl: 'https://example.com/tokyo-tower.jpg',
        attractions: ['Observation deck', 'Restaurant', 'Shopping'],
        weatherInfo: 'Humid subtropical climate',
        bestTimeToVisit: 'March to May and September to November',
      ),
    ];

    return destinations.map((model) => model.toEntity()).toList();
  }

  Future<Trip> generateTripPlan({
    required String destination,
    required DateTime startDate,
    required DateTime endDate,
    required double budget,
    required List<String> interests,
  }) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 2));

    // Mock trip plan
    final tripModel = TripModel(
      id: 'generated-${DateTime.now().millisecondsSinceEpoch}',
      name: 'Amazing $destination Adventure',
      description: 'A carefully crafted trip to $destination based on your interests.',
      startDate: startDate,
      endDate: endDate,
      destinations: [
        DestinationModel(
          id: 'dest-1',
          name: destination,
          country: 'Unknown',
          city: destination,
          description: 'Your dream destination',
          imageUrl: 'https://example.com/destination.jpg',
          attractions: ['Local attractions', 'Cultural sites', 'Natural beauty'],
        ),
      ],
      activities: [
        ActivityModel(
          id: 'act-1',
          name: 'City Tour',
          description: 'Explore the main attractions of $destination',
          type: ActivityType.sightseeing,
          date: startDate,
          location: destination,
          cost: budget * 0.1,
        ),
        ActivityModel(
          id: 'act-2',
          name: 'Local Cuisine Experience',
          description: 'Taste authentic local dishes',
          type: ActivityType.dining,
          date: startDate.add(const Duration(days: 1)),
          location: destination,
          cost: budget * 0.15,
        ),
        ActivityModel(
          id: 'act-3',
          name: 'Cultural Museum Visit',
          description: 'Learn about local history and culture',
          type: ActivityType.sightseeing,
          date: startDate.add(const Duration(days: 2)),
          location: destination,
          cost: budget * 0.05,
        ),
      ],
      budget: budget,
      status: TripStatus.planning,
      createdAt: DateTime.now(),
    );

    return tripModel.toEntity();
  }

  Future<List<String>> getRecommendations(String destination) async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      'Visit the main tourist attractions',
      'Try local cuisine at recommended restaurants',
      'Take a guided tour to learn about the history',
      'Explore the city on foot to discover hidden gems',
      'Visit local markets for authentic souvenirs',
    ];
  }

  Future<String> getTravelAdvice(String destination) async {
    await Future.delayed(const Duration(seconds: 1));

    return '''
Travel Advice for $destination:

1. **Best Time to Visit**: Research the best weather conditions for your preferred activities.

2. **Local Customs**: Learn about local customs and etiquette to show respect.

3. **Transportation**: Research public transportation options and consider getting a travel pass.

4. **Safety**: Keep your belongings secure and be aware of your surroundings.

5. **Language**: Learn a few basic phrases in the local language.

6. **Budget**: Plan your daily budget including accommodation, food, and activities.

7. **Booking**: Book popular attractions and restaurants in advance.

8. **Insurance**: Consider travel insurance for peace of mind.

Enjoy your trip to $destination!
''';
  }
} 