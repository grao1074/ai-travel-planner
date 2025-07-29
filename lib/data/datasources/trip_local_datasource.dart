import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/trip_model.dart';

abstract class TripLocalDataSource {
  Future<List<TripModel>> getAllTrips();
  Future<TripModel?> getTripById(String id);
  Future<void> saveTrip(TripModel trip);
  Future<void> updateTrip(TripModel trip);
  Future<void> deleteTrip(String id);
}

class TripLocalDataSourceImpl implements TripLocalDataSource {
  static const String _tripsKey = 'trips';

  @override
  Future<List<TripModel>> getAllTrips() async {
    final prefs = await SharedPreferences.getInstance();
    final tripsJson = prefs.getStringList(_tripsKey) ?? [];
    
    return tripsJson
        .map((json) => TripModel.fromJson(jsonDecode(json)))
        .toList();
  }

  @override
  Future<TripModel?> getTripById(String id) async {
    final trips = await getAllTrips();
    try {
      return trips.firstWhere((trip) => trip.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> saveTrip(TripModel trip) async {
    final prefs = await SharedPreferences.getInstance();
    final trips = await getAllTrips();
    trips.add(trip);
    
    final tripsJson = trips.map((trip) => jsonEncode(trip.toJson())).toList();
    await prefs.setStringList(_tripsKey, tripsJson);
  }

  @override
  Future<void> updateTrip(TripModel trip) async {
    final prefs = await SharedPreferences.getInstance();
    final trips = await getAllTrips();
    
    final index = trips.indexWhere((t) => t.id == trip.id);
    if (index != -1) {
      trips[index] = trip;
      final tripsJson = trips.map((trip) => jsonEncode(trip.toJson())).toList();
      await prefs.setStringList(_tripsKey, tripsJson);
    }
  }

  @override
  Future<void> deleteTrip(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final trips = await getAllTrips();
    
    trips.removeWhere((trip) => trip.id == id);
    final tripsJson = trips.map((trip) => jsonEncode(trip.toJson())).toList();
    await prefs.setStringList(_tripsKey, tripsJson);
  }
} 