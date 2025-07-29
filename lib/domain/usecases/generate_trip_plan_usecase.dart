import '../entities/trip.dart';
import '../repositories/ai_planner_repository.dart';

class GenerateTripPlanUseCase {
  final AiPlannerRepository _aiPlannerRepository;

  GenerateTripPlanUseCase(this._aiPlannerRepository);

  Future<Trip> execute({
    required String destination,
    required DateTime startDate,
    required DateTime endDate,
    required double budget,
    required List<String> interests,
    required int travelers,
  }) async {
    return await _aiPlannerRepository.generateTripPlan(
      destination: destination,
      startDate: startDate,
      endDate: endDate,
      budget: budget,
      interests: interests,
      travelers: travelers,
    );
  }
} 