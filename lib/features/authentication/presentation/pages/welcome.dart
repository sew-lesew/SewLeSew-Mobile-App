import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unity_fund/core/constants/constant.dart';
import 'package:unity_fund/injection_container.dart';

import '../../../../config/theme/colors.dart';
import '../../data/services/local/storage_services.dart';
import '../bloc/welcome/welcome_bloc.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  PageController pageController = PageController(initialPage: 0);

  Widget _page(
    int index,
    BuildContext context,
    String buttonName,
    String title,
    String subtitle,
    String imagePath,
  ) {
    return Column(
      children: [
        SizedBox(
          width: 345.w,
          height: 345.w,
          child: Image.asset(
            imagePath,
            fit: BoxFit.fitWidth,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            color: AppColors.secondaryColor,
            fontSize: 25.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 15.sp,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (index < 3) {
              pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
              );
            } else {
              sl<StorageService>()
                  .setBool(AppConstant.STORAGE_DEVICE_OPEN_FIRST_TIME, true);
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("/sign_in", (route) => false);
            }
          },
          child: Container(
            margin: EdgeInsets.only(top: 100.h, left: 25.w, right: 25.w),
            width: 325.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: AppColors.accentColor,
              borderRadius: BorderRadius.circular(15.w),
            ),
            child: Center(
              child: Text(
                buttonName,
                style: TextStyle(
                  color: AppColors.primaryBackground,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WelcomeBloc(),
      child: Scaffold(
        backgroundColor: AppColors.primaryBackground,
        body: BlocBuilder<WelcomeBloc, WelcomeState>(
          builder: (context, state) {
            return Stack(
              alignment: Alignment.topCenter,
              children: [
                PageView(
                  controller: pageController,
                  onPageChanged: (index) {
                    state.page = index;
                    BlocProvider.of<WelcomeBloc>(context).add(WelcomeEvent());
                  },
                  children: [
                    _page(
                      1,
                      context,
                      'Next',
                      "Welcome to Unity Fund",
                      "A platform connecting individuals and communities to raise funds for important causes.",
                      "assets/welcome/welcome1.png",
                    ),
                    _page(
                      2,
                      context,
                      'Next',
                      "Support and Empower",
                      "Easily browse campaigns and support those in need by donating to meaningful causes.",
                      "assets/welcome/welcome2.png",
                    ),
                    _page(
                      3,
                      context,
                      'Get Started',
                      "Create and Share",
                      "Start your own campaign, share your story, and gather support from a caring community.",
                      "assets/welcome/welcome3.png",
                    ),
                  ],
                ),
                Positioned(
                  bottom: 50.h,
                  child: DotsIndicator(
                    position: state.page,
                    dotsCount: 3,
                    mainAxisAlignment: MainAxisAlignment.center,
                    decorator: DotsDecorator(
                      activeColor: AppColors.accentColor,
                      color: AppColors.cardColor,
                      size: const Size.square(8.0),
                      activeSize: const Size(15.0, 8.0),
                      activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
