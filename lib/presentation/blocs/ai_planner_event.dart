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
  }) = _GenerateTripPlan;
  
  const factory AiPlannerEvent.getRecommendations(String destination) = _GetRecommendations;
  
  const factory AiPlannerEvent.getTravelAdvice(String destination) = _GetTravelAdvice;
} 