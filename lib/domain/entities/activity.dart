import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity.freezed.dart';
part 'activity.g.dart';

@freezed
class Activity with _$Activity {
  const factory Activity({
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
  }) = _Activity;

  factory Activity.fromJson(Map<String, dynamic> json) => _$ActivityFromJson(json);
}

enum ActivityType {
  accommodation,
  transportation,
  sightseeing,
  dining,
  entertainment,
  shopping,
  other,
} 