import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sewlesew_fund/core/constants/constant.dart';
import 'package:sewlesew_fund/features/auth/data/services/local/storage_services.dart';
import '../../../../config/theme/colors.dart';
import '../../../../injection_container.dart';
import '../bloc/welcome/welcome_bloc.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WelcomeBloc(),
      child: Scaffold(
        body: BlocBuilder<WelcomeBloc, WelcomeState>(
          builder: (context, state) {
            return Stack(
              children: [
                PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    state.page = index;
                    BlocProvider.of<WelcomeBloc>(context).add(WelcomeEvent());
                  },
                  children: [
                    _buildOnboardingPage(
                      context,
                      "Unite for a Better Future!",
                      "Join a community of change-makers.",
                      "assets/welcome/welcome1.png", // Replace with actual photo asset
                      0,
                    ),
                    _buildOnboardingPage(
                      context,
                      "Every Drop Makes an Ocean",
                      "Small acts, big impact.",
                      "assets/welcome/welcome2.png", // Replace with actual photo asset
                      1,
                    ),
                    _buildOnboardingPage(
                      context,
                      "Together, We Achieved Greatness!",
                      "Celebrate your success with us.",
                      "assets/welcome/welcome3.png", // Replace with actual photo asset
                      2,
                    ),
                  ],
                ),
                Positioned(
                  bottom: 100.h,
                  left: 0,
                  right: 0,
                  child: DotsIndicator(
                    position: state.page,
                    dotsCount: 3,
                    decorator: DotsDecorator(
                      activeColor: AppColors
                          .accentColor, // Match the "NEXT" button color
                      color: Colors.grey,
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

  Widget _buildOnboardingPage(
    BuildContext context,
    String title,
    String subtitle,
    String imagePath,
    int pageIndex,
  ) {
    return Stack(
      children: [
        // Background Image
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath), // Replace with actual asset path
              fit: BoxFit.fill,
            ),
          ),
        ),
        // Semi-transparent overlay with gradient
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.9),
                Colors.black.withOpacity(0.1),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        // Content
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 450.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ),
            SizedBox(height: 60.h),
            GestureDetector(
              onTap: () {
                if (pageIndex < 2) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                } else {
                  // Navigate to sign-in or main page
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/sign_in', (route) => false);

                  // Set Get Device First Open to true
                  AsyncSnapshot.waiting();
                  sl<StorageService>().setBool(
                      AppConstant.STORAGE_DEVICE_OPEN_FIRST_TIME, true);
                }
              },
              child: Container(
                width: 250.w,
                height: 50.h,
                decoration: BoxDecoration(
                  color: AppColors.accentColor.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(25.w),
                ),
                child: Center(
                  child: Text(
                    pageIndex < 2 ? "NEXT" : "GET STARTED",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
