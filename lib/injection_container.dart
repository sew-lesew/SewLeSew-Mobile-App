import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:sewlesew_fund/features/auth/domain/usecases/forgot_password.dart';
import 'package:sewlesew_fund/features/auth/domain/usecases/login.dart';
import 'package:sewlesew_fund/features/auth/domain/usecases/logout.dart';
import 'package:sewlesew_fund/features/auth/domain/usecases/refresh.dart';
import 'package:sewlesew_fund/features/auth/domain/usecases/resend_code.dart';
import 'package:sewlesew_fund/features/auth/domain/usecases/reset_passord.dart';
import 'package:sewlesew_fund/features/auth/domain/usecases/signup.dart';
import 'package:sewlesew_fund/features/auth/domain/usecases/verify_account.dart';
import 'package:sewlesew_fund/features/auth/presentation/bloc/reset_password/reset_password_bloc.dart';
import 'package:sewlesew_fund/features/auth/presentation/bloc/sign_up/sign_up_bloc.dart';
import 'package:sewlesew_fund/features/auth/presentation/bloc/verification/verification_bloc.dart';

import 'features/auth/data/repository/auth_repository_impl.dart';
import 'features/auth/data/services/local/storage_services.dart';
import 'features/auth/data/services/remote/auth_services.dart';
import 'features/auth/domain/repositroy/auth_repository.dart';
import 'features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'features/auth/presentation/bloc/sign_out_cubit.dart';

final GetIt sl = GetIt.instance;
Future<void> initializeDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  sl.registerSingleton<StorageService>(await StorageService().init());
  sl.registerSingleton(dotenv.load);
// repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
  //services
  sl.registerLazySingleton<AuthServices>(() => AuthServicesImpl());
//Usecases
  //Auth Usecases
  sl.registerSingleton<LoginUsecase>(LoginUsecase());
  sl.registerSingleton<LogoutUsecase>(LogoutUsecase());
  sl.registerSingleton<SignupUsecase>(SignupUsecase());
  sl.registerSingleton<ForgotPasswordUsecase>(ForgotPasswordUsecase());
  sl.registerSingleton<ResetPasswordUsecase>(ResetPasswordUsecase());
  sl.registerSingleton<RefreshUsecase>(RefreshUsecase());
  sl.registerSingleton<VerifyAccountUsecase>(VerifyAccountUsecase());
  sl.registerSingleton<ResendCodeUsecase>(ResendCodeUsecase());
  // Blocs
  sl.registerFactory<SignInBloc>(() => SignInBloc());
  sl.registerFactory<SignUpBloc>(() => SignUpBloc());
  sl.registerFactory<VerificationBloc>(() => VerificationBloc());
  sl.registerFactory<ResetPasswordBloc>(() => ResetPasswordBloc());
  sl.registerFactory<SignOutCubit>(() => SignOutCubit());
}
