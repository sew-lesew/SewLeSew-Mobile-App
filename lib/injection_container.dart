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
import 'package:sewlesew_fund/features/campaign/domain/repository/campaign_repository.dart';
import 'package:sewlesew_fund/features/campaign/presentation/bloc/campaign_cubit.dart';
import 'package:sewlesew_fund/features/donations/domain/repository/donation_repository.dart';
import 'package:sewlesew_fund/features/donations/domain/usecases/donate.dart';
import 'package:sewlesew_fund/features/donations/domain/usecases/get_donation_by_campaign.dart';
import 'package:sewlesew_fund/features/donations/domain/usecases/verify_donation.dart';

import 'core/services/token_services.dart';
import 'features/auth/data/repository/auth_repository_impl.dart';
import 'features/auth/data/services/local/storage_services.dart';
import 'features/auth/data/services/remote/auth_services.dart';
import 'features/auth/domain/repositroy/auth_repository.dart';
import 'features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'features/auth/presentation/bloc/sign_out_cubit.dart';
import 'features/campaign/data/repository/campaign_repository_impl.dart';
import 'features/campaign/data/services/remote/campaign_services.dart';
import 'features/campaign/domain/usecases/create_business_campaign.dart';
import 'features/campaign/domain/usecases/get_campaign_by_id.dart';
import 'features/campaign/domain/usecases/get_campaigns.dart';
import 'features/campaign/domain/usecases/get_my_campaigns.dart';
import 'features/campaign/presentation/bloc/create_campaign_bloc/create_campaign_bloc.dart';
import 'features/donations/data/repository/donation_repository_impl.dart';
import 'features/donations/data/services/donation_services.dart';
import 'features/donations/domain/usecases/get_donation_by_user.dart';
import 'features/donations/presentation/bloc/donation_cubit.dart';

final GetIt sl = GetIt.instance;
Future<void> initializeDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  sl.registerSingleton<StorageService>(await StorageService().init());
  sl.registerSingleton(dotenv.load);
// repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
  sl.registerLazySingleton<CampaignRepository>(() => CampaignRepositoryImpl());
  sl.registerLazySingleton<DonationRepository>(() => DonationRepositoryImpl());

  //services
  sl.registerLazySingleton<AuthServices>(() => AuthServicesImpl());
  sl.registerLazySingleton<TokenService>(() => TokenService());
  sl.registerLazySingleton<CampaignServices>(() => CampaignServices());
  sl.registerLazySingleton<DonationServices>(() => DonationServices());

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

  //Campaign Usecases
  sl.registerSingleton<GetMyCampaignsUsecase>(GetMyCampaignsUsecase());
  sl.registerSingleton<GetCampaignsUsecase>(GetCampaignsUsecase());
  sl.registerSingleton<GetCampaignByIdUsecase>(GetCampaignByIdUsecase());
  sl.registerSingleton<CreateBusinessCampaignUsecase>(
      CreateBusinessCampaignUsecase());

  // Donation Usecases
  sl.registerSingleton<DonateUseCase>(DonateUseCase());
  sl.registerSingleton<GetDonationByUserUseCase>(GetDonationByUserUseCase());
  sl.registerSingleton<GetDonationByCampaignUseCase>(
      GetDonationByCampaignUseCase());
  sl.registerSingleton<VerifyDonationUseCase>(VerifyDonationUseCase());

  // Blocs
  sl.registerFactory<SignInBloc>(() => SignInBloc());
  sl.registerFactory<SignUpBloc>(() => SignUpBloc());
  sl.registerFactory<VerificationBloc>(() => VerificationBloc());
  sl.registerFactory<ResetPasswordBloc>(() => ResetPasswordBloc());
  sl.registerFactory<SignOutCubit>(() => SignOutCubit());
  sl.registerFactory<CampaignCubit>(() => CampaignCubit());
  sl.registerFactory<CreateCampaignBloc>(() => CreateCampaignBloc());
  sl.registerFactory<DonationCubit>(() => DonationCubit());
}
