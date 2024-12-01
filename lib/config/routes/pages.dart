// The UNIFICATION Of BlocProvider and routes and pages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unity_fund/config/routes/names.dart';
import 'package:unity_fund/features/authentication/presentation/bloc/reset_password/reset_password_bloc.dart';
import 'package:unity_fund/features/authentication/presentation/bloc/toogle_password/toggle_password_bloc.dart';
import 'package:unity_fund/features/authentication/presentation/pages/reset_screen.dart';
import 'package:unity_fund/features/authentication/presentation/pages/sign_up.dart';
import 'package:unity_fund/main.dart';

import '../../features/authentication/data/services/local/storage_services.dart';
import '../../features/authentication/presentation/bloc/sign_in/sign_in_bloc.dart';
import '../../features/authentication/presentation/bloc/sign_up/sign_up_bloc.dart';
import '../../features/authentication/presentation/bloc/welcome/welcome_bloc.dart';
import '../../features/authentication/presentation/pages/sign_in.dart';
import '../../features/authentication/presentation/pages/welcome.dart';
import '../../injection_container.dart';

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
          route: AppRoutes.SIGN_UP,
          page: const SignUp(),
          bloc: BlocProvider(create: (_) => sl<SignUpBloc>())),
      PageEntity(
          route: AppRoutes.RESET_PASSWORD,
          page: const ResetScreen(),
          bloc: BlocProvider(
            create: (_) => sl<ResetPasswordBloc>(),
          )),
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
  String? route;
  Widget? page;
  dynamic bloc;

  PageEntity({this.route, this.page, this.bloc});
}
