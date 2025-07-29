part of 'ai_planner_bloc.dart';

@freezed
class AiPlannerState with _$AiPlannerState {
  const factory AiPlannerState.initial() = _Initial;
  const factory AiPlannerState.loading() = _Loading;
  const factory AiPlannerState.destinationsLoaded(List<Destination> destinations) = _DestinationsLoaded;
  const factory AiPlannerState.tripPlanGenerated(Trip trip) = _TripPlanGenerated;
  const factory AiPlannerState.recommendationsLoaded(List<Destination> destinations) = _RecommendationsLoaded;
  const factory AiPlannerState.travelAdviceLoaded(String advice) = _TravelAdviceLoaded;
  const factory AiPlannerState.error(String message) = _Error;
} 