import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewlesew_fund/config/routes/names.dart';

import '../../../../config/theme/colors.dart';
import '../bloc/verification/verification_bloc.dart';
import '../widgets/build_pin_code_field.dart';
import '../widgets/common_widgets.dart';

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
  final String? title = "Sign up Verification";

  final TextEditingController _pinCodeController = TextEditingController();
  late VerificationBloc _verificationBloc;

  @override
  void initState() {
    super.initState();
    _verificationBloc = context.read<VerificationBloc>();
  }

  @override
  Widget build(BuildContext context) {
    print("the email that pass through this is ${widget.email}");
    return Scaffold(
      appBar: buildAppBarLarge(title!),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            reusableText(
                "Please Enter the 6 digit \nverification code sent \nto your email"),
            const SizedBox(
              height: 35,
            ),
            Container(
                padding: const EdgeInsets.all(20.0),
                margin: const EdgeInsets.all(8.0),
                child: BlocBuilder<VerificationBloc, VerificationState>(
                  builder: (context, state) {
                    if (state is VerificationFailure) {
                      return Center(
                          child: Text('Error: ${state.error}',
                              style: const TextStyle(color: Colors.red)));
                    }
                    if (state is VerificationSuccess) {
                      // Navigate to the next page after successful verification
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.of(context).pushNamed(AppRoutes.SIGN_IN);
                        return;
                      });
                    }
                    return PinCodeFieldWidget(controller: _pinCodeController);
                  },
                )),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  reusableText("Didn't receive code?"),
                  GestureDetector(
                    child: const Center(
                      child: Text(
                        'Resend Now',
                        style: TextStyle(
                            color: AppColors.accentColor, fontSize: 15),
                      ),
                    ),
                    onTap: () {
                      _verificationBloc.add(ResendCode(
                          email: widget.email,
                          phoneNumber: widget.phoneNumber));
                    },
                  )
                ],
              ),
            ),
            BlocBuilder<VerificationBloc, VerificationState>(
              builder: (context, state) {
                bool isButtonEnabled = state is VerificationCodeValid;
                print(isButtonEnabled);
                return state is VerificationLoading
                    ? const Center(child: CircularProgressIndicator())
                    : buildLogInAndRegButton(
                        "Verify", state is VerificationCodeValid, () {
                        if (state is VerificationCodeValid) {
                          final code = _pinCodeController.text;

                          if (code.isNotEmpty && code.length == 6) {
                            context.read<VerificationBloc>().add(SubmitCode(
                                  code: int.parse(code),
                                  email: widget.email,
                                  phoneNumber: widget.phoneNumber,
                                ));
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
                      });
              },
            )
          ],
        ),
      ),
    );
  }
}
