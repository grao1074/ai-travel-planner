import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/destination.dart';

class DestinationCard extends StatelessWidget {
  final Destination destination;

  const DestinationCard({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      height: 150,
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
      child: destination.imageUrl != null
          ? Image.network(
              destination.imageUrl!,
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            )
          : Container(
              width: double.infinity,
              height: 150,
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
                Icons.location_on,
                color: Colors.white.withOpacity(0.8),
                size: 50,
              ),
            ),
    );
  }

  Widget _buildContentSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            destination.name,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${destination.city}, ${destination.country}',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: const Color(0xFF666666),
            ),
          ),
          if (destination.description != null) ...[
            const SizedBox(height: 8),
            Text(
              destination.description!,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF999999),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          if (destination.attractions != null && destination.attractions!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              'Popular attractions:',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 4),
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: destination.attractions!.take(3).map((attraction) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F0F0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    attraction,
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      color: const Color(0xFF666666),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
} 