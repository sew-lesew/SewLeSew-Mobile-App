import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sewlesew_fund/config/routes/routes.dart';
import 'package:sewlesew_fund/features/auth/presentation/widgets/flutter_toast.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/resources/shared_event.dart';
import '../../../../core/util/sign_in_controller.dart';
import '../bloc/sign_in/sign_in_bloc.dart';
import '../widgets/common_widgets.dart';
import '../widgets/sign_up_widgets.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final SignInController _signInController = SignInController();

  @override
  void dispose() {
    context.read<SignInBloc>().add(SignInReset());
    super.dispose();
  }

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final contact = _signInController.contactController.text.trim();
    final password = _signInController.passwordController.text.trim();

    if (contact.isEmpty || password.isEmpty) {
      return;
    }

    final isEmail = contact.contains('@');

    try {
      context.read<SignInBloc>().add(SignInSubmitEvent(
            email: isEmail ? contact : null,
            phoneNumber: isEmail ? null : contact,
            password: password,
          ));
    } catch (e) {
      print("Error dispatching SignInSubmitEvent: $e");
    }
  }

  void _handleGoogleSignIn() {
    print("Start to Sign IN with Google");
    try {
      // sl<StorageService>().setBool(AppConstant.STORAGE_USER_TOKEN_KEY, true);
      context.read<SignInBloc>().add(GoogleSignInEvent());
    } catch (e) {
      print("Error dispatching GoogleSignInEvent: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor:
          AppColors.accentColor, // Set status bar color for home screen
      statusBarIconBrightness: Brightness.light, // Light text/icons
    ));
    return BlocListener<SignInBloc, SignInState>(listener: (context, state) {
      if (state.signInSuccess) {
        print("Successfully Signed in: ${state.email}");
        // context.read<SignUpBloc>().add(SignUpLoadingEvent());

        Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.MAIN, (Route<dynamic> route) => false);
      }
      if (state.signInFailure != null || state.signInFailure != "") {
        // toastInfo(msg: state.signInFailure ?? state.googleSignInFailure);
      }
    }, child: BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            // backgroundColor: AppColors.primaryBackground,
            appBar: buildAppBarLarge('Log In'),
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    // Center(
                    //   child: Image.asset(
                    //     'assets/logo/logo.png', // Your logo image path
                    //     width: 150.h,
                    //   ),
                    // ),
                    Container(
                      padding:
                          EdgeInsets.only(left: 25.w, right: 25.w, top: 10.h),
                      margin: EdgeInsets.only(top: 25.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Center(
                          //   child: Image.asset(
                          //     'assets/logo/logo.png', // Your logo image path
                          //     height: 100.h,
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 15.h,
                          // ),
                          // animatedTextScreen(),
                          reusableText("Email"),
                          SizedBox(
                            height: 5.h,
                          ),
                          formField(
                              fieldName: "contact",
                              value: state.email ?? state.phoneNumber,
                              controller: _signInController.contactController,
                              textType: "text",
                              hintText: "Enter your email or phone number",
                              prefixIcon: const Icon(Icons.contact_mail),
                              inputType: TextInputType.emailAddress,
                              func: (value) {
                                context
                                    .read<SignInBloc>()
                                    .add(ContactEvent(value));
                              },
                              context: context,
                              formType: 'sign in'),
                          SizedBox(
                            height: 5.h,
                          ),
                          reusableText("Password"),
                          formField(
                            fieldName: "password",
                            value: state.password,
                            controller: _signInController.passwordController,
                            textType: "password",
                            hintText: "Enter your password",
                            prefixIcon: const Icon(Icons.lock),
                            inputType: TextInputType.visiblePassword,
                            func: (value) {
                              context
                                  .read<SignInBloc>()
                                  .add(PasswordEvent(password: value));
                            },
                            formType: 'sign in',
                            context: context,
                          ),
                          Row(
                            children: [
                              IconButton(
                                  alignment: Alignment.centerRight,
                                  iconSize: 13,
                                  onPressed: () {},
                                  icon: const Icon(
                                      Icons.check_box_outline_blank)),
                              Text(
                                "Remember Password",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 175.w,
                              ),
                              forgotPassword(() {
                                Navigator.of(context)
                                    .pushNamed("/reset_password");
                              }),
                            ],
                          ),
                        ],
                      ),
                    ),

                    state.isSignInLoading
                        ? const Center(child: CircularProgressIndicator())
                        : buildLogInAndRegButton("Log In", true, _handleSubmit),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Center(
                      child:
                          reusableText("Or use your google account to login"),
                    ),
                    BlocBuilder<SignInBloc, SignInState>(
                      builder: (context, state) {
                        if (state.isGoogleSignInLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        // if (state.googleSignInFailure != null ||
                        //     state.googleSignInFailure!.isNotEmpty) {
                        //   toastInfo(msg: state.googleSignInFailure);
                        // }

                        return GestureDetector(
                          onTap: () {
                            context.read<SignInBloc>().add(GoogleSignInEvent());
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 25.w,
                                right: 25.w,
                                top: 10.h,
                                bottom: 10.h),
                            width: 325.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.w),
                              border: Border.all(color: AppColors.cardColor),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle),
                                  child: Image.asset(
                                    "assets/icons/google.png",
                                    // color: AppColors.primaryBackground,
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ), // Assuming this builds the Google icon

                                Center(
                                  child: Text(
                                    "Continue with Google",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(
                          width: 35,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.SIGN_UP);
                          },
                          child: const Text(
                            "sign up",
                            style: TextStyle(color: AppColors.accentColor),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    // buildLogInAndRegButton("Sign Up", "register", () {
                    //   Navigator.of(context).pushNamed("/sign_up");
                    // })
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ));
  }
}
