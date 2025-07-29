import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/trip.dart';
import 'destination_model.dart';
import 'activity_model.dart';

part 'trip_model.freezed.dart';
part 'trip_model.g.dart';

@freezed
class TripModel with _$TripModel {
  const factory TripModel({
    required String id,
    required String name,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
    required List<DestinationModel> destinations,
    required List<ActivityModel> activities,
    required double budget,
    required TripStatus status,
    String? imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _TripModel;

  factory TripModel.fromJson(Map<String, dynamic> json) =>
      _$TripModelFromJson(json);

  factory TripModel.fromEntity(Trip trip) {
    return TripModel(
      id: trip.id,
      name: trip.name,
      description: trip.description,
      startDate: trip.startDate,
      endDate: trip.endDate,
      destinations: trip.destinations.map((destination) => DestinationModel.fromEntity(destination)).toList(),
      activities: trip.activities.map((activity) => ActivityModel.fromEntity(activity)).toList(),
      budget: trip.budget,
      status: trip.status,
      imageUrl: trip.imageUrl,
      createdAt: trip.createdAt,
      updatedAt: trip.updatedAt,
    );
  }
}

extension TripModelExtension on TripModel {
  Trip toEntity() {
    return Trip(
      id: id,
      name: name,
      description: description,
      startDate: startDate,
      endDate: endDate,
      destinations: destinations.map((destination) => destination.toEntity()).toList(),
      activities: activities.map((activity) => activity.toEntity()).toList(),
      budget: budget,
      status: status,
      imageUrl: imageUrl,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
} 