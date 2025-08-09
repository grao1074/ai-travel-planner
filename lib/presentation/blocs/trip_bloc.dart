import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/trip.dart';
import '../../domain/usecases/get_all_trips_usecase.dart';
import '../../domain/usecases/add_trip_usecase.dart';
import '../../domain/usecases/update_trip_usecase.dart';
import '../../domain/usecases/delete_trip_usecase.dart';

part 'trip_event.dart';
part 'trip_state.dart';
part 'trip_bloc.freezed.dart';

class TripBloc extends Bloc<TripEvent, TripState> {
  final GetAllTripsUseCase _getAllTripsUseCase;
  final AddTripUseCase _addTripUseCase;
  final UpdateTripUseCase _updateTripUseCase;
  final DeleteTripUseCase _deleteTripUseCase;

  TripBloc({
    required GetAllTripsUseCase getAllTripsUseCase,
    required AddTripUseCase addTripUseCase,
    required UpdateTripUseCase updateTripUseCase,
    required DeleteTripUseCase deleteTripUseCase,
  })  : _getAllTripsUseCase = getAllTripsUseCase,
        _addTripUseCase = addTripUseCase,
        _updateTripUseCase = updateTripUseCase,
        _deleteTripUseCase = deleteTripUseCase,
        super(const TripState.initial()) {
    on<TripEvent>((event, emit) async {
      await event.map(
        loadTrips: (e) async => await _onLoadTrips(emit),
        searchTrips: (e) async => await _onSearchTrips(e.query, emit),
        addTrip: (e) async => await _onAddTrip(e.trip, emit),
        updateTrip: (e) async => await _onUpdateTrip(e.trip, emit),
        deleteTrip: (e) async => await _onDeleteTrip(e.id, emit),
      );
    });
  }

  Future<void> _onLoadTrips(Emitter<TripState> emit) async {
    emit(const TripState.loading());
    try {
      final trips = await _getAllTripsUseCase.execute();
      emit(TripState.loaded(trips));
    } catch (e) {
      emit(TripState.error(e.toString()));
    }
  }

  Future<void> _onSearchTrips(String query, Emitter<TripState> emit) async {
    emit(const TripState.loading());
    try {
      final trips = await _getAllTripsUseCase.execute();
      final filteredTrips = trips.where((trip) =>
        trip.name.toLowerCase().contains(query.toLowerCase()) ||
        trip.description.toLowerCase().contains(query.toLowerCase())
      ).toList();
      emit(TripState.loaded(filteredTrips));
    } catch (e) {
      emit(TripState.error(e.toString()));
    }
  }

  Future<void> _onAddTrip(Trip trip, Emitter<TripState> emit) async {
    try {
      emit(const TripState.loading());
      // Save the trip to storage
      await _addTripUseCase.execute(trip);
      // Reload all trips to get the updated list
      final trips = await _getAllTripsUseCase.execute();
      emit(TripState.loaded(trips));
    } catch (e) {
      emit(TripState.error(e.toString()));
    }
  }

  Future<void> _onUpdateTrip(Trip trip, Emitter<TripState> emit) async {
    try {
      emit(const TripState.loading());
      // Update the trip in storage
      await _updateTripUseCase.execute(trip);
      // Reload all trips to get the updated list
      final trips = await _getAllTripsUseCase.execute();
      emit(TripState.loaded(trips));
    } catch (e) {
      emit(TripState.error(e.toString()));
    }
  }

  Future<void> _onDeleteTrip(String id, Emitter<TripState> emit) async {
    try {
      emit(const TripState.loading());
      // Delete the trip from storage
      await _deleteTripUseCase.execute(id);
      // Reload all trips to get the updated list
      final trips = await _getAllTripsUseCase.execute();
      emit(TripState.loaded(trips));
    } catch (e) {
      emit(TripState.error(e.toString()));
    }
  }
} 