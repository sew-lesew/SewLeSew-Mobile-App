import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewlesew_fund/config/routes/names.dart';

import '../../../../config/theme/colors.dart';
import '../bloc/verification/verification_bloc.dart';
import '../widgets/build_pin_code_field.dart';

class SignUpVerification extends StatefulWidget {
  const SignUpVerification(
      {super.key, this.title, this.phoneNumber, this.email});

  final String? title;
  final String? phoneNumber;
  final String? email;

  @override
  State<SignUpVerification> createState() => _SignUpVerificationState();
}

class _SignUpVerificationState extends State<SignUpVerification> {
  final TextEditingController _pinCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("The email that passed through this is: ${widget.email}");
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up Verification")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
            const Text(
              "Please enter the 6-digit verification code sent to your email",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 35),
            BlocBuilder<VerificationBloc, VerificationState>(
              builder: (context, state) {
                if (state is VerificationSuccess) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(context).pushNamed(AppRoutes.SIGN_IN);
                  });
                }
                return PinCodeFieldWidget(controller: _pinCodeController);
              },
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Didn't receive the code?"),
                GestureDetector(
                  onTap: () {
                    context.read<VerificationBloc>().add(
                          ResendCode(
                              email: widget.email,
                              phoneNumber: widget.phoneNumber),
                        );
                  },
                  child: const Text(
                    'Resend Now',
                    style:
                        TextStyle(color: AppColors.accentColor, fontSize: 15),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            BlocBuilder<VerificationBloc, VerificationState>(
              builder: (context, state) {
                bool isButtonEnabled = state is VerificationCodeValid;
                return ElevatedButton(
                  onPressed: isButtonEnabled
                      ? () {
                          final code = _pinCodeController.text;
                          if (code.isNotEmpty && code.length == 6) {
                            context.read<VerificationBloc>().add(
                                  SubmitCode(
                                    code: int.parse(code),
                                    email: widget.email,
                                    phoneNumber: widget.phoneNumber,
                                  ),
                                );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text("Please enter a valid 6-digit code."),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentColor,
                    disabledBackgroundColor: Colors.grey,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: state is VerificationLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Verify",
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
