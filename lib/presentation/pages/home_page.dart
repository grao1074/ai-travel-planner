import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../blocs/trip_bloc.dart';
import '../widgets/trip_card.dart';
import '../widgets/ai_planner_button.dart';
import 'create_trip_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: _buildTripsList(),
            ),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Travel Planner',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                  Text(
                    'Plan your next adventure',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: const Color(0xFF666666),
                    ),
                  ),
                ],
              ),
              CircleAvatar(
                radius: 25,
                backgroundColor: const Color(0xFF4A90E2),
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          AiPlannerButton(),
        ],
      ),
    );
  }

  Widget _buildTripsList() {
    return BlocBuilder<TripBloc, TripState>(
      builder: (context, state) {
        return state.when(
          initial: () => _buildEmptyState(),
          loading: () => _buildLoadingState(),
          loaded: (trips) => trips.isEmpty ? _buildEmptyState() : _buildTripsGrid(trips),
          error: (message) => _buildErrorState(message),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.flight_takeoff,
            size: 80,
            color: const Color(0xFFCCCCCC),
          ),
          const SizedBox(height: 20),
          Text(
            'No trips planned yet',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF666666),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Start planning your next adventure!',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: const Color(0xFF999999),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(
        color: Color(0xFF4A90E2),
      ),
    );
  }

  Widget _buildTripsGrid(List<Trip> trips) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 0.8,
        ),
        itemCount: trips.length,
        itemBuilder: (context, index) {
          return TripCard(trip: trips[index]);
        },
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 80,
            color: const Color(0xFFFF6B6B),
          ),
          const SizedBox(height: 20),
          Text(
            'Something went wrong',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF666666),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            message,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: const Color(0xFF999999),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CreateTripPage()),
        );
      },
      backgroundColor: const Color(0xFF4A90E2),
      icon: const Icon(Icons.add, color: Colors.white),
      label: Text(
        'New Trip',
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
} 