part of 'trip_bloc.dart';

@freezed
class TripState with _$TripState {
  const factory TripState.initial() = _Initial;
  const factory TripState.loading() = _Loading;
  const factory TripState.loaded(List<Trip> trips) = _Loaded;
  const factory TripState.error(String message) = _Error;
} 