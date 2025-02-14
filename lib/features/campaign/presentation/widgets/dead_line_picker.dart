import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DualInputDatePicker extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final Function(DateTime?) onDateSelected;

  const DualInputDatePicker({
    super.key,
    required this.label,
    required this.controller,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.date_range,
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
        TextFormField(
          controller: controller,
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
            suffixIcon: IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  // Update the controller with the selected date
                  controller.text = "${pickedDate.toLocal()}".split(' ')[0];
                  onDateSelected(pickedDate);
                }
              },
            ),
          ),
          onChanged: (value) {
            // Validate and parse the manually entered date
            if (value.isNotEmpty) {
              final DateTime? parsedDate = DateTime.tryParse(value);
              if (parsedDate != null) {
                onDateSelected(parsedDate);
              }
            }
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select or enter a date';
            }
            final DateTime? parsedDate = DateTime.tryParse(value);
            if (parsedDate == null) {
              return 'Invalid date format';
            }
            return null;
          },
        ),
      ],
    );
  }
}
