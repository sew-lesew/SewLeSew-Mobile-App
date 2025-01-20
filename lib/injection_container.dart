import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:unity_fund/features/auth/presentation/bloc/reset_password/reset_password_bloc.dart';
import 'package:unity_fund/features/auth/presentation/bloc/sign_up/sign_up_bloc.dart';
import 'package:unity_fund/features/auth/presentation/bloc/verification/verification_bloc.dart';

import 'features/auth/data/repository/auth_repository_impl.dart';
import 'features/auth/data/services/local/storage_services.dart';
import 'features/auth/domain/repositroy/auth_repository.dart';
import 'features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';

final sl = GetIt.instance;
Future<void> initializeDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  sl.registerSingleton<StorageService>(await StorageService().init());
  sl.registerSingleton(dotenv.load);

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  // Blocs
  sl.registerFactory<SignInBloc>(() => SignInBloc());
  sl.registerFactory<SignUpBloc>(() => SignUpBloc());
  sl.registerFactory<VerificationBloc>(() => VerificationBloc());
  sl.registerFactory<ResetPasswordBloc>(() => ResetPasswordBloc());
}
