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
            TextFormField(
              decoration: InputDecoration(
                hintText: hint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onSaved: onSaved,
              validator: validator,
            ),
          ],
        ),
      ),
    );
  }
}
