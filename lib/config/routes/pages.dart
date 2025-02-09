import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewlesew_fund/config/routes/names.dart';
import 'package:sewlesew_fund/features/auth/presentation/bloc/reset_password/reset_password_bloc.dart';
import 'package:sewlesew_fund/features/auth/presentation/bloc/sign_out_cubit.dart';
import 'package:sewlesew_fund/features/auth/presentation/bloc/toogle_password/toggle_password_bloc.dart';
import 'package:sewlesew_fund/features/auth/presentation/bloc/verification/verification_bloc.dart';
import 'package:sewlesew_fund/features/auth/presentation/pages/reset_screen.dart';
import 'package:sewlesew_fund/features/auth/presentation/pages/sign_up.dart';
import 'package:sewlesew_fund/features/auth/presentation/pages/verification_code.dart';
import 'package:sewlesew_fund/features/campaign/presentation/bloc/campaign_cubit.dart';
import 'package:sewlesew_fund/features/campaign/presentation/bloc/create_campaign_bloc/create_campaign_bloc.dart';
import 'package:sewlesew_fund/features/donations/presentation/bloc/donation_cubit.dart';
import 'package:sewlesew_fund/features/donations/presentation/pages/payment.dart';
import 'package:sewlesew_fund/features/campaign/presentation/pages/campaign_detail.dart';
import 'package:sewlesew_fund/features/user_profile/presentation/pages/FAQ.dart';
import 'package:sewlesew_fund/main.dart';

import '../../features/auth/data/services/local/storage_services.dart';
import '../../features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';
import '../../features/auth/presentation/bloc/sign_up/sign_up_bloc.dart';
import '../../features/auth/presentation/bloc/welcome/welcome_bloc.dart';
import '../../features/auth/presentation/pages/sign_in.dart';
import '../../features/auth/presentation/pages/welcome.dart';
import '../../features/user_profile/presentation/pages/edit_profile.dart';
import '../../injection_container.dart';

// The UNIFICATION Of BlocProvider and routes and pages

class AppPages {
  // final UserRepositoryImpl _userRepository;
  // AppPages(this._userRepository);
  List<PageEntity> routes() {
    return [
      PageEntity(
        route: AppRoutes.WELCOME,
        page: const Welcome(),
        bloc: BlocProvider(
          create: (_) => sl<WelcomeBloc>(),
        ),
      ),
      PageEntity(
          bloc: BlocProvider(
        create: (_) => TogglePasswordBloc(),
      )),
      PageEntity(
        route: AppRoutes.SIGN_IN,
        page: const SignIn(),
        bloc: BlocProvider(
          create: (_) => sl<SignInBloc>(),
        ),
      ),
      PageEntity(
          bloc: BlocProvider(
        create: (_) => sl<SignOutCubit>(),
      )),
      PageEntity(
          route: AppRoutes.CAMPAIGN_DETAIL,
          page: CampaignDetailScreen(),
          bloc: BlocProvider(
            create: (_) => sl<CampaignCubit>(),
          )),
      PageEntity(
          bloc: BlocProvider(
        create: (_) => sl<CreateCampaignBloc>(),
      )),
      PageEntity(
          route: AppRoutes.SIGN_UP,
          page: const SignUp(),
          bloc: BlocProvider(create: (_) => sl<SignUpBloc>())),
      PageEntity(
          route: AppRoutes.SIGN_UP_VERIFICATION,
          page: const SignUpVerification(),
          bloc: BlocProvider(create: (_) => sl<VerificationBloc>())),
      PageEntity(
          route: AppRoutes.RESET_PASSWORD,
          page: const ResetScreen(),
          bloc: BlocProvider(
            create: (_) => sl<ResetPasswordBloc>(),
          )),
      PageEntity(
        route: AppRoutes.EDIT_PROFILE,
        page: const EditProfileScreen(),
      ),
      PageEntity(
          route: AppRoutes.PAYMENT,
          page: const DonatePayment(),
          bloc: BlocProvider(create: (_) => sl<DonationCubit>())),
      PageEntity(route: AppRoutes.FAQ, page: const FAQ()),
      PageEntity(route: AppRoutes.MAIN, page: const MyHomePage()),
    ];
  }

  List<dynamic> allBlocProvider(BuildContext context) {
    List<dynamic> blocProviders = <dynamic>[];
    for (var bloc in routes()) {
      if (bloc.bloc != null) {
        // Check if bloc is not null before adding
        blocProviders.add(bloc.bloc);
      }
    }
    return blocProviders;
  }

  // models that covers entire screen as we click on navigator object
  MaterialPageRoute generateRouteSettings(RouteSettings settings) {
    print('GenerateRouteSettings');
    if (settings.name != null) {
      // check for route name matching when navigator gets triggered
      var result = routes().where((element) => element.route == settings.name);
      if (result.isNotEmpty) {
        print("first log");
        print(result.first.route);
        print(result.indexed);
        bool deviceFirstOpen = sl<StorageService>().getDeviceFirstOpen();
        if (result.first.route == AppRoutes.WELCOME && deviceFirstOpen) {
          print("Second Log");
          bool getIsLoggedIn = sl<StorageService>().getIsLoggedIn();
          if (getIsLoggedIn) {
            print("is logged in");
            // return MaterialPageRoute(
            //     builder: (_) => const MyHomePage(), settings: settings);
          }
          return MaterialPageRoute(
              builder: (_) => const SignIn(), settings: settings);
        }
        return MaterialPageRoute(
            builder: (_) => result.first.page!, settings: settings);
      }
    }
    print("Invalid route name: ${settings.name}");
    return MaterialPageRoute(
        builder: (_) => const Welcome(), settings: settings);
  }
}

class HomeBloc {}

class PageEntity {
  PageEntity({this.route, this.page, this.bloc});

  dynamic bloc;
  Widget? page;
  String? route;
}
