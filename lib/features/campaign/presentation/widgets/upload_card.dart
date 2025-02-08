// lib/features/campaign/presentation/widgets/upload_card.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UploadCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const UploadCard({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Color(0xFF13ADB7)),
                SizedBox(width: 8.0),
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF005782),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            ElevatedButton.icon(
              onPressed: onPressed,
              icon: Icon(Icons.upload),
              label: Text('Upload'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF13ADB7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
