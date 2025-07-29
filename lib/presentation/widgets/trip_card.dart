import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/trip.dart';
import 'package:intl/intl.dart';

class TripCard extends StatelessWidget {
  final Trip trip;

  const TripCard({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSection(),
            _buildContentSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF4A90E2),
            const Color(0xFF357ABD),
          ],
        ),
      ),
      child: Stack(
        children: [
          if (trip.imageUrl != null)
            Image.network(
              trip.imageUrl!,
              width: double.infinity,
              height: 120,
              fit: BoxFit.cover,
            )
          else
            Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF4A90E2),
                    const Color(0xFF357ABD),
                  ],
                ),
              ),
              child: Icon(
                Icons.flight_takeoff,
                color: Colors.white.withOpacity(0.8),
                size: 40,
              ),
            ),
          Positioned(
            top: 8,
            right: 8,
            child: _buildStatusChip(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip() {
    Color chipColor;
    String statusText;

    switch (trip.status) {
      case TripStatus.planning:
        chipColor = const Color(0xFFFFA726);
        statusText = 'Planning';
        break;
      case TripStatus.active:
        chipColor = const Color(0xFF4CAF50);
        statusText = 'Active';
        break;
      case TripStatus.completed:
        chipColor = const Color(0xFF2196F3);
        statusText = 'Completed';
        break;
      case TripStatus.cancelled:
        chipColor = const Color(0xFFF44336);
        statusText = 'Cancelled';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        statusText,
        style: GoogleFonts.poppins(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildContentSection() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            trip.name,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1A1A1A),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          if (trip.destinations.isNotEmpty)
            Text(
              trip.destinations.first.name,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF666666),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 14,
                color: const Color(0xFF999999),
              ),
              const SizedBox(width: 4),
              Text(
                '${DateFormat('MMM dd').format(trip.startDate)} - ${DateFormat('MMM dd').format(trip.endDate)}',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF999999),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                Icons.attach_money,
                size: 14,
                color: const Color(0xFF999999),
              ),
              const SizedBox(width: 4),
              Text(
                '\$${trip.budget.toStringAsFixed(0)}',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF999999),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 