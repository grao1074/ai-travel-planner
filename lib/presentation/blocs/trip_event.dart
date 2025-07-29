part of 'trip_bloc.dart';

@freezed
class TripEvent with _$TripEvent {
  const factory TripEvent.loadTrips() = _LoadTrips;
  const factory TripEvent.searchTrips(String query) = _SearchTrips;
  const factory TripEvent.addTrip(Trip trip) = _AddTrip;
  const factory TripEvent.updateTrip(Trip trip) = _UpdateTrip;
  const factory TripEvent.deleteTrip(String id) = _DeleteTrip;
} 