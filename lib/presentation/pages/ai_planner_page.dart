import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../blocs/ai_planner_bloc.dart';
import '../widgets/destination_card.dart';

class AiPlannerPage extends StatefulWidget {
  const AiPlannerPage({super.key});

  @override
  State<AiPlannerPage> createState() => _AiPlannerPageState();
}

class _AiPlannerPageState extends State<AiPlannerPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _interests = [
    'Culture & History',
    'Nature & Adventure',
    'Food & Cuisine',
    'Shopping',
    'Relaxation',
    'Nightlife',
  ];
  final List<String> _selectedInterests = [];

  @override
  void initState() {
    super.initState();
    // Load initial recommendations
    context.read<AiPlannerBloc>().add(
      const AiPlannerEvent.getRecommendedDestinations(
        budget: 5000,
        interests: ['Culture & History', 'Food & Cuisine'],
        preferredClimate: 'Temperate',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A1A)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'AI Travel Planner',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1A1A1A),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchSection(),
            const SizedBox(height: 30),
            _buildInterestsSection(),
            const SizedBox(height: 30),
            _buildRecommendationsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Where do you want to go?',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search destinations...',
              hintStyle: GoogleFonts.poppins(
                color: const Color(0xFF999999),
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: Color(0xFF666666),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(20),
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                context.read<AiPlannerBloc>().add(
                  AiPlannerEvent.searchDestinations(value),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildInterestsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What interests you?',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 15),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _interests.map((interest) {
            final isSelected = _selectedInterests.contains(interest);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedInterests.remove(interest);
                  } else {
                    _selectedInterests.add(interest);
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF4A90E2) : Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: isSelected ? const Color(0xFF4A90E2) : const Color(0xFFE0E0E0),
                  ),
                ),
                child: Text(
                  interest,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : const Color(0xFF666666),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildRecommendationsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recommended for you',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1A1A1A),
              ),
            ),
            TextButton(
              onPressed: () {
                context.read<AiPlannerBloc>().add(
                  AiPlannerEvent.getRecommendedDestinations(
                    budget: 5000,
                    interests: _selectedInterests,
                    preferredClimate: 'Temperate',
                  ),
                );
              },
              child: Text(
                'Refresh',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF4A90E2),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        BlocBuilder<AiPlannerBloc, AiPlannerState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox(),
              loading: () => const Center(
                child: CircularProgressIndicator(color: Color(0xFF4A90E2)),
              ),
              destinationsLoaded: (destinations) => _buildDestinationsList(destinations),
              recommendationsLoaded: (destinations) => _buildDestinationsList(destinations),
              tripPlanGenerated: (trip) => _buildTripPlanResult(trip),
              travelAdviceLoaded: (advice) => _buildTravelAdvice(advice),
              error: (message) => _buildErrorState(message),
            );
          },
        ),
      ],
    );
  }

  Widget _buildDestinationsList(List<Destination> destinations) {
    return Column(
      children: destinations.map((destination) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: DestinationCard(destination: destination),
        );
      }).toList(),
    );
  }

  Widget _buildTripPlanResult(Trip trip) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your AI-Generated Trip Plan',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            trip.name,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF4A90E2),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            trip.description,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: const Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTravelAdvice(String advice) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Travel Advice',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            advice,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: const Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFF6B6B).withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFF6B6B)),
      ),
      child: Column(
        children: [
          Icon(
            Icons.error_outline,
            color: const Color(0xFFFF6B6B),
            size: 40,
          ),
          const SizedBox(height: 10),
          Text(
            'Something went wrong',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFFFF6B6B),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            message,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: const Color(0xFF666666),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
} 