import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

// Domain
import 'domain/entities/trip.dart';
import 'domain/repositories/trip_repository.dart';
import 'domain/repositories/ai_planner_repository.dart';
import 'domain/usecases/get_all_trips_usecase.dart';
import 'domain/usecases/add_trip_usecase.dart';
import 'domain/usecases/update_trip_usecase.dart';
import 'domain/usecases/delete_trip_usecase.dart';
import 'domain/usecases/generate_trip_plan_usecase.dart';

// Data
import 'data/datasources/trip_local_datasource.dart';
import 'data/datasources/ai_planner_remote_datasource.dart';
import 'data/repositories/trip_repository_impl.dart';
import 'data/repositories/ai_planner_repository_impl.dart';

// Presentation
import 'presentation/blocs/trip_bloc.dart';
import 'presentation/blocs/ai_planner_bloc.dart';
import 'presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  runApp(const TravelPlannerApp());
}

class TravelPlannerApp extends StatelessWidget {
  const TravelPlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<Dio>(
          create: (context) => Dio(),
        ),
        RepositoryProvider<TripLocalDataSource>(
          create: (context) => TripLocalDataSourceImpl(),
        ),
        RepositoryProvider<AiPlannerRemoteDataSource>(
          create: (context) => AiPlannerRemoteDataSource(
            context.read<Dio>(),
          ),
        ),
        RepositoryProvider<TripRepository>(
          create: (context) => TripRepositoryImpl(
            context.read<TripLocalDataSource>(),
          ),
        ),
        RepositoryProvider<AiPlannerRepository>(
          create: (context) => AiPlannerRepositoryImpl(
            context.read<AiPlannerRemoteDataSource>(),
          ),
        ),
        RepositoryProvider<GetAllTripsUseCase>(
          create: (context) => GetAllTripsUseCase(
            context.read<TripRepository>(),
          ),
        ),
        RepositoryProvider<AddTripUseCase>(
          create: (context) => AddTripUseCase(
            context.read<TripRepository>(),
          ),
        ),
        RepositoryProvider<UpdateTripUseCase>(
          create: (context) => UpdateTripUseCase(
            context.read<TripRepository>(),
          ),
        ),
        RepositoryProvider<DeleteTripUseCase>(
          create: (context) => DeleteTripUseCase(
            context.read<TripRepository>(),
          ),
        ),
        RepositoryProvider<GenerateTripPlanUseCase>(
          create: (context) => GenerateTripPlanUseCase(
            context.read<AiPlannerRepository>(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TripBloc>(
            create: (context) => TripBloc(
              getAllTripsUseCase: context.read<GetAllTripsUseCase>(),
              addTripUseCase: context.read<AddTripUseCase>(),
              updateTripUseCase: context.read<UpdateTripUseCase>(),
              deleteTripUseCase: context.read<DeleteTripUseCase>(),
            )..add(const TripEvent.loadTrips()),
          ),
          BlocProvider<AiPlannerBloc>(
            create: (context) => AiPlannerBloc(
              context.read<GenerateTripPlanUseCase>(),
              context.read<AiPlannerRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Travel Planner',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: GoogleFonts.poppins().fontFamily,
            scaffoldBackgroundColor: const Color(0xFFF8F9FA),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(color: Color(0xFF1A1A1A)),
              titleTextStyle: TextStyle(
                color: Color(0xFF1A1A1A),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A90E2),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF4A90E2)),
              ),
            ),
          ),
          home: const HomePage(),
        ),
      ),
    );
  }
} 