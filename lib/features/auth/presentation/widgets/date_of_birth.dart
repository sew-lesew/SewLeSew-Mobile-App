// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewlesew_fund/features/auth/presentation/bloc/sign_up/sign_up_bloc.dart';

import '../../../../core/resources/shared_event.dart';
import 'build_textfield.dart';

Widget dateField({
  required BuildContext context,
  required TextEditingController dateController,
  required String? date,
  required String? dateType,
}) {
  return MyTextField(
      prefixIcon: const Icon(Icons.date_range),
      suffixIcon: IconButton(
          onPressed: () async {
            final DateTime now = DateTime.now();
            final DateTime minDate =
                DateTime(now.year - 100, now.month, now.day);
            final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: minDate,
                firstDate: DateTime(1800),
                lastDate: DateTime.now());
            if (picked != null) {
              dateController.text = "${picked.toLocal()}".split(' ')[0];

              context
                  .read<SignUpBloc>()
                  .add(DateEvent(dateOfBirth: dateController.text));
              print("Users Date is :${dateController.text}");
            }
          },
          icon: const Icon(Icons.calendar_today)),
      controller: TextEditingController(text: dateController.text),
      validator: (validate) {
        if (validate!.isEmpty) {
          return "Please fill in this field";
        }
        return null;
      },
      readOnly: true,
      hintText: "Select date of birth",
      obscureText: false,
      keyboardType: TextInputType.datetime);
}
