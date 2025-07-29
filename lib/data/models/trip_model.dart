import 'package:freezed_annotation/freezed_annotation.dart';
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
    @JsonKey(name: 'start_date') required DateTime startDate,
    @JsonKey(name: 'end_date') required DateTime endDate,
    required List<DestinationModel> destinations,
    required List<ActivityModel> activities,
    required double budget,
    required TripStatus status,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _TripModel;

  factory TripModel.fromJson(Map<String, dynamic> json) => _$TripModelFromJson(json);

  factory TripModel.fromEntity(Trip trip) {
    return TripModel(
      id: trip.id,
      name: trip.name,
      description: trip.description,
      startDate: trip.startDate,
      endDate: trip.endDate,
      destinations: trip.destinations.map((d) => DestinationModel.fromEntity(d)).toList(),
      activities: trip.activities.map((a) => ActivityModel.fromEntity(a)).toList(),
      budget: trip.budget,
      status: trip.status,
      imageUrl: trip.imageUrl,
      createdAt: trip.createdAt,
      updatedAt: trip.updatedAt,
    );
  }

  Trip toEntity() {
    return Trip(
      id: id,
      name: name,
      description: description,
      startDate: startDate,
      endDate: endDate,
      destinations: destinations.map((d) => d.toEntity()).toList(),
      activities: activities.map((a) => a.toEntity()).toList(),
      budget: budget,
      status: status,
      imageUrl: imageUrl,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
} 