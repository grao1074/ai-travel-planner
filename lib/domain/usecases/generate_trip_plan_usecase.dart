import '../entities/trip.dart';
import '../repositories/ai_planner_repository.dart';

class GenerateTripPlanUseCase {
  final AiPlannerRepository _repository;

  GenerateTripPlanUseCase(this._repository);

  Future<Trip> execute({
    required String destination,
    required DateTime startDate,
    required DateTime endDate,
    required double budget,
    required List<String> interests,
  }) async {
    return await _repository.generateTripPlan(
      destination: destination,
      startDate: startDate,
      endDate: endDate,
      budget: budget,
      interests: interests,
    );
  }
} 