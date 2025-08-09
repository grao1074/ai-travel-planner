import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/activity.dart';

part 'activity_model.freezed.dart';
part 'activity_model.g.dart';

@freezed
class ActivityModel with _$ActivityModel {
  const factory ActivityModel({
    required String id,
    required String name,
    required String description,
    required ActivityType type,
    required DateTime date,
    required String location,
    double? cost,
    String? notes,
    bool? isCompleted,
    String? imageUrl,
  }) = _ActivityModel;

  factory ActivityModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityModelFromJson(json);

  factory ActivityModel.fromEntity(Activity activity) {
    return ActivityModel(
      id: activity.id,
      name: activity.name,
      description: activity.description,
      type: activity.type,
      date: activity.date,
      location: activity.location,
      cost: activity.cost,
      notes: activity.notes,
      isCompleted: activity.isCompleted,
      imageUrl: activity.imageUrl,
    );
  }
}

extension ActivityModelExtension on ActivityModel {
  Activity toEntity() {
    return Activity(
      id: id,
      name: name,
      description: description,
      type: type,
      date: date,
      location: location,
      cost: cost,
      notes: notes,
      isCompleted: isCompleted,
      imageUrl: imageUrl,
    );
  }
} 