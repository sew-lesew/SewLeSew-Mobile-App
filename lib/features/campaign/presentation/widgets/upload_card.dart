import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UploadCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final String? fileName;

  const UploadCard({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.fileName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon,
                  color: const Color(0xFF13ADB7)), // Match InputCard icon
              const SizedBox(width: 8.0),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w300,
                  color: const Color(0xFF005782),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4.0),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  readOnly: true,
                  controller: TextEditingController(text: fileName),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 14.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Color(0xFF13ADB7)),
                    ),
                    hintText: fileName == null ? 'No file selected' : null,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade200, // Grey background
                  foregroundColor: Colors.grey.shade800, // Dark grey text
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 14.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.upload, size: 18),
                    const SizedBox(width: 8.0),
                    Text(
                      fileName == null ? 'Upload' : 'Change',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
