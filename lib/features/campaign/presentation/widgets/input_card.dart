import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String hint;
  final Function(String?) onSaved;
  final String? Function(String?)? validator;

  const InputCard({
    super.key,
    required this.icon,
    required this.label,
    required this.hint,
    required this.onSaved,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label with Icon
          Row(
            children: [
              Icon(icon, color: const Color(0xFF13ADB7), size: 18),
              const SizedBox(width: 8.0),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF005782),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),

          // Text Field
          TextFormField(
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade500,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 16.0,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1.5,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: const Color(0xFF13ADB7),
                  width: 2.0,
                ),
              ),
              errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red.shade400,
                  width: 1.5,
                ),
              ),
              focusedErrorBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red.shade400,
                  width: 2.0,
                ),
              ),
            ),
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF005782),
            ),
            onSaved: onSaved,
            validator: validator,
          ),
        ],
      ),
    );
  }
}
