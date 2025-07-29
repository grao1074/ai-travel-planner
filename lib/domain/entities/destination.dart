import 'package:freezed_annotation/freezed_annotation.dart';

part 'destination.freezed.dart';
part 'destination.g.dart';

@freezed
class Destination with _$Destination {
  const factory Destination({
    required String id,
    required String name,
    required String country,
    required String city,
    String? description,
    double? latitude,
    double? longitude,
    String? imageUrl,
    List<String>? attractions,
    String? weatherInfo,
    String? bestTimeToVisit,
  }) = _Destination;

  factory Destination.fromJson(Map<String, dynamic> json) => _$DestinationFromJson(json);
} 