import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unity_fund/config/routes/routes.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/constant.dart';
import '../../../../core/resources/shared_event.dart';
import '../../../../core/util/sign_in_controller.dart';
import '../../../../injection_container.dart';
import '../../data/services/local/storage_services.dart';
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
  late SignInBloc _signInBloc;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _signInBloc = BlocProvider.of<SignInBloc>(context);
  }

  @override
  void dispose() {
    _signInBloc.add(SignInReset());
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      sl<StorageService>().setBool(AppConstant.STORAGE_USER_TOKEN_KEY, true);
      final contact = _signInController.contactController.text.trim();
      final isEmail = contact.contains('@');
      _signInBloc.add(SignInSubmitEvent(
          email: isEmail ? contact : null,
          phoneNumber: !isEmail ? contact : null,
          password: _signInController.passwordController.text));
      Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.MAIN, (Route<dynamic> route) => false);
    }
  }

  void _handleGoogleSignIn() {
    sl<StorageService>().setBool(AppConstant.STORAGE_USER_TOKEN_KEY, true);
    // _signInBloc.add(GoogleSignInEvent());
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor:
          AppColors.accentColor, // Set status bar color for home screen
      statusBarIconBrightness: Brightness.light, // Light text/icons
    ));
    return BlocListener<SignInBloc, SignInState>(listener: (context, state) {
      if (state.signInSuccess || state.isGoogleSignInSuccess) {
        print("Successfully Signed in: ${state.email}");
        // context.read<SignUpBloc>().add(SignUpLoadingEvent());

        Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.MAIN, (Route<dynamic> route) => false);
      }
      if (state.signInFailure != null || state.googleSignInFailure != null) {
        // print("Sign In Failure: $state.signInFailure");
        print("Failed to Signed In");
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text(state.signInFailure!)),
        // );
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
                    state.isGoogleSignInLoading
                        ? const Center(child: CircularProgressIndicator())
                        : buildThirdPartyLogin(context, _handleGoogleSignIn),
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
