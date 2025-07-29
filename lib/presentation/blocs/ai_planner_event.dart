part of 'ai_planner_bloc.dart';

@freezed
class AiPlannerEvent with _$AiPlannerEvent {
  const factory AiPlannerEvent.searchDestinations(String query) = _SearchDestinations;
  const factory AiPlannerEvent.generateTripPlan({
    required String destination,
    required DateTime startDate,
    required DateTime endDate,
    required double budget,
    required List<String> interests,
    required int travelers,
  }) = _GenerateTripPlan;
  const factory AiPlannerEvent.getRecommendedDestinations({
    required double budget,
    required List<String> interests,
    required String preferredClimate,
  }) = _GetRecommendedDestinations;
  const factory AiPlannerEvent.getTravelAdvice(String destination) = _GetTravelAdvice;
} 