import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/trip.dart';
import '../../domain/entities/destination.dart';
import '../../domain/usecases/generate_trip_plan_usecase.dart';
import '../../domain/repositories/ai_planner_repository.dart';

part 'ai_planner_event.dart';
part 'ai_planner_state.dart';
part 'ai_planner_bloc.freezed.dart';

class AiPlannerBloc extends Bloc<AiPlannerEvent, AiPlannerState> {
  final GenerateTripPlanUseCase _generateTripPlanUseCase;
  final AiPlannerRepository _aiPlannerRepository;

  AiPlannerBloc(this._generateTripPlanUseCase, this._aiPlannerRepository)
      : super(const AiPlannerState.initial()) {
    on<AiPlannerEvent>((event, emit) async {
      await event.map(
        searchDestinations: (e) async => await _onSearchDestinations(e.query, emit),
        generateTripPlan: (e) async => await _onGenerateTripPlan(e, emit),
        getRecommendations: (e) async => await _onGetRecommendations(e.destination, emit),
        getTravelAdvice: (e) async => await _onGetTravelAdvice(e.destination, emit),
      );
    });
  }

  Future<void> _onSearchDestinations(String query, Emitter<AiPlannerState> emit) async {
    emit(const AiPlannerState.loading());
    try {
      final destinations = await _aiPlannerRepository.searchDestinations(query);
      emit(AiPlannerState.destinationsLoaded(destinations));
    } catch (e) {
      emit(AiPlannerState.error(e.toString()));
    }
  }

  Future<void> _onGenerateTripPlan(_GenerateTripPlan event, Emitter<AiPlannerState> emit) async {
    emit(const AiPlannerState.loading());
    try {
      final trip = await _generateTripPlanUseCase.execute(
        destination: event.destination,
        startDate: event.startDate,
        endDate: event.endDate,
        budget: event.budget,
        interests: event.interests,
      );
      emit(AiPlannerState.tripPlanGenerated(trip));
    } catch (e) {
      emit(AiPlannerState.error(e.toString()));
    }
  }

  Future<void> _onGetRecommendations(String destination, Emitter<AiPlannerState> emit) async {
    emit(const AiPlannerState.loading());
    try {
      final recommendations = await _aiPlannerRepository.getRecommendations(destination);
      emit(AiPlannerState.recommendationsLoaded(recommendations));
    } catch (e) {
      emit(AiPlannerState.error(e.toString()));
    }
  }

  Future<void> _onGetTravelAdvice(String destination, Emitter<AiPlannerState> emit) async {
    emit(const AiPlannerState.loading());
    try {
      final advice = await _aiPlannerRepository.getTravelAdvice(destination);
      emit(AiPlannerState.travelAdviceLoaded(advice));
    } catch (e) {
      emit(AiPlannerState.error(e.toString()));
    }
  }
} 