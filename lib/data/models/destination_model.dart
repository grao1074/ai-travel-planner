import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/destination.dart';

part 'destination_model.freezed.dart';
part 'destination_model.g.dart';

@freezed
class DestinationModel with _$DestinationModel {
  const factory DestinationModel({
    required String id,
    required String name,
    required String country,
    required String city,
    String? description,
    double? latitude,
    double? longitude,
    @JsonKey(name: 'image_url') String? imageUrl,
    List<String>? attractions,
    @JsonKey(name: 'weather_info') String? weatherInfo,
    @JsonKey(name: 'best_time_to_visit') String? bestTimeToVisit,
  }) = _DestinationModel;

  factory DestinationModel.fromJson(Map<String, dynamic> json) => _$DestinationModelFromJson(json);

  factory DestinationModel.fromEntity(Destination destination) {
    return DestinationModel(
      id: destination.id,
      name: destination.name,
      country: destination.country,
      city: destination.city,
      description: destination.description,
      latitude: destination.latitude,
      longitude: destination.longitude,
      imageUrl: destination.imageUrl,
      attractions: destination.attractions,
      weatherInfo: destination.weatherInfo,
      bestTimeToVisit: destination.bestTimeToVisit,
    );
  }

  Destination toEntity() {
    return Destination(
      id: id,
      name: name,
      country: country,
      city: city,
      description: description,
      latitude: latitude,
      longitude: longitude,
      imageUrl: imageUrl,
      attractions: attractions,
      weatherInfo: weatherInfo,
      bestTimeToVisit: bestTimeToVisit,
    );
  }
} 