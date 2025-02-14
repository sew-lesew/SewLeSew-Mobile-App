import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/util/enum_string.dart';

class SimpleEnumDropdown<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<T> items;
  final Function(T?) onChanged;

  const SimpleEnumDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.category,
                color: Color(0xFF13ADB7)), // Match InputCard icon
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
        DropdownButtonFormField<T>(
          value: value,
          decoration: InputDecoration(
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
          isExpanded: true, // Ensure the dropdown expands to fill the width
          items: items.map((item) {
            // Convert enum to display string (e.g., "AGRICULTURE" -> "Agriculture")
            final displayText = enumToDisplayString(item);

            return DropdownMenuItem<T>(
              value: item,
              child: Text(
                displayText,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade700,
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
