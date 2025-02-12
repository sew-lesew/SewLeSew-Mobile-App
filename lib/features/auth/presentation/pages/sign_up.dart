import 'package:flutter/material.dart';
import "package:flutter_screenutil/flutter_screenutil.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewlesew_fund/features/auth/domain/entities/sign_up_entity.dart';

import '../../../../core/resources/shared_event.dart';
import '../../../../core/util/sign_up_controller.dart';
import '../bloc/sign_up/sign_up_bloc.dart';
import '../widgets/common_widgets.dart';
import '../widgets/date_of_birth.dart';
import '../widgets/flutter_toast.dart';
import '../widgets/sign_up_widgets.dart';
import 'verification_code.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final SignUpController _signUpController = SignUpController();
  String formType = "sign up";

  final _formKey = GlobalKey<FormState>();
  late SignUpBloc _signUpBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _signUpBloc = BlocProvider.of<SignUpBloc>(context);
  }

  @override
  void dispose() {
    _signUpBloc.add(SignUpReset());
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      final contact = _signUpController.contactController.text.trim();
      final isEmail = contact.contains('@');
      final user = SignUpEntity(
        firstName: _signUpController.firstNameController.text,
        lastName: _signUpController.lastNameController.text,
        email: isEmail ? contact : null,
        phoneNumber: !isEmail ? contact : null,
        password: _signUpController.passwordController.text,
        confirmPassword: _signUpController.confirmPasswordController.text,
        dateOfBirth: _signUpController.dateOfBirthController.text,
      );
      _signUpBloc.add(SignUpSubmitEvent(user));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpStates>(listener: (context, state) {
      if (state.signUpSuccess) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SignUpVerification(
            phoneNumber: state.phoneNumber,
            email: state.email,
          ),
        ));
      }

      if (state.signUpFailure != null) {
        // Show error message
        toastInfo(
          msg: state.signUpFailure!,
        );
      }
    }, child: BlocBuilder<SignUpBloc, SignUpStates>(
      builder: (context, state) {
        return BlocBuilder<SignUpBloc, SignUpStates>(
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Container(
                // color: AppColors.primaryBackground,
                child: SafeArea(
                  child: Scaffold(
                    // backgroundColor: AppColors.primaryBackground,
                    appBar: buildAppBarLarge("Sign Up"),
                    body: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Center(
                              child: reusableText(
                                  "Enter your details below and free sign Up")),
                          Container(
                            padding: EdgeInsets.only(left: 25.w, right: 25.w),
                            margin: EdgeInsets.only(top: 50.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                reusableText("First Name"),
                                formField(
                                    fieldName: "firstName",
                                    value: state.firstName,
                                    controller:
                                        _signUpController.firstNameController,
                                    textType: "text",
                                    hintText: "Enter your first name",
                                    prefixIcon: const Icon(Icons.person),
                                    inputType: TextInputType.name,
                                    func: (value) {
                                      context.read<SignUpBloc>().add(
                                          NameChangedEvent(firstName: value));
                                    },
                                    formType: formType,
                                    context: context),
                                SizedBox(
                                  height: 5.h,
                                ),
                                reusableText("Last Name"),

                                formField(
                                    fieldName: "lastName",
                                    value: state.lastName,
                                    controller:
                                        _signUpController.lastNameController,
                                    textType: "text",
                                    hintText: "Enter your last name",
                                    prefixIcon: const Icon(Icons.person),
                                    inputType: TextInputType.name,
                                    func: (value) {
                                      context.read<SignUpBloc>().add(
                                          NameChangedEvent(lastName: value));
                                    },
                                    formType: formType,
                                    context: context),
                                SizedBox(
                                  height: 5.h,
                                ),
                                reusableText("Email or Phone Number"),
                                formField(
                                    fieldName: "contact",
                                    value: state.email ?? state.phoneNumber,
                                    controller:
                                        _signUpController.contactController,
                                    textType: "text",
                                    hintText:
                                        "Enter your email or phone number",
                                    prefixIcon: const Icon(Icons.contact_mail),
                                    inputType: TextInputType.emailAddress,
                                    func: (value) {
                                      context
                                          .read<SignUpBloc>()
                                          .add(ContactEvent(value));
                                    },
                                    formType: formType,
                                    context: context),
                                SizedBox(
                                  height: 5.h,
                                ),

                                reusableText("Date Of Birth"),

                                // print("Date of Birth:$dateOfBirth");
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: dateField(
                                    context: context,
                                    dateController:
                                        _signUpController.dateOfBirthController,
                                    date: state.dateOfBirth,
                                    dateType: "birth",
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                reusableText("Password"),
                                formField(
                                  formType: formType,
                                  fieldName: "password",
                                  value: state.password,
                                  controller:
                                      _signUpController.passwordController,
                                  textType: "password",
                                  hintText: "Enter your password",
                                  prefixIcon: const Icon(Icons.lock),
                                  inputType: TextInputType.visiblePassword,
                                  func: (value) {
                                    context
                                        .read<SignUpBloc>()
                                        .add(PasswordEvent(password: value));
                                  },
                                  context: context,
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                reusableText("Confirm Password"),
                                formField(
                                  formType: formType,
                                  fieldName: "repassword",
                                  value: state.repassword,
                                  controller: _signUpController
                                      .confirmPasswordController,
                                  textType: "password",
                                  hintText: "Re-enter your password to confirm",
                                  prefixIcon: const Icon(Icons.lock),
                                  inputType: TextInputType.visiblePassword,
                                  func: (value) {
                                    context
                                        .read<SignUpBloc>()
                                        .add(PasswordEvent(repassword: value));
                                  },
                                  context: context,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 25.w),
                            child: reusableText(
                                "By creating an account you have agree with our terms and conditions"),
                          ),
                          state.isSignUpLoading
                              ? const Center(child: CircularProgressIndicator())
                              : buildLogInAndRegButton(
                                  "Sign Up", true, _handleSubmit)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    ));
  }
}
