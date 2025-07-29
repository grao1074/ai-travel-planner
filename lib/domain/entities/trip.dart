import 'package:freezed_annotation/freezed_annotation.dart';
import 'destination.dart';
import 'activity.dart';

part 'trip.freezed.dart';
part 'trip.g.dart';

@freezed
class Trip with _$Trip {
  const factory Trip({
    required String id,
    required String name,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
    required List<Destination> destinations,
    required List<Activity> activities,
    required double budget,
    required TripStatus status,
    String? imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Trip;

  factory Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);
}

enum TripStatus {
  planning,
  active,
  completed,
  cancelled,
} 