import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewlesew_fund/features/auth/domain/usecases/refresh.dart';
import 'package:sewlesew_fund/features/auth/domain/usecases/verify_account.dart';

import '../../../../../core/util/ethiopian_phone_validator.dart';
import '../../../../../injection_container.dart';
import '../../../domain/usecases/resend_code.dart';

part 'verification_event.dart';
part 'verification_state.dart';

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  VerificationBloc() : super(VerificationInitial()) {
    on<CodeChanged>((event, emit) {
      if (event.code.length == 6) {
        emit(VerificationCodeValid(event.code));
      } else {
        emit(VerificationCodeInvalid(event.code));
      }
    });
    on<SubmitCode>((event, emit) async {
      emit(VerificationLoading());
      try {
        await sl<VerifyAccountUsecase>().call(
          params: VerifyAccountParams(
            email: event.email,
            code: event.code,
            phoneNumber: EthiopianPhoneValidator.normalize(event.phoneNumber),
          ),
        );

        emit(VerificationSuccess());
      } catch (e) {
        if (e.toString().contains("401")) {
          try {
            await sl<RefreshUsecase>().call();
            await sl<VerifyAccountUsecase>().call(
              params: VerifyAccountParams(
                email: event.email,
                code: event.code,
                phoneNumber:
                    EthiopianPhoneValidator.normalize(event.phoneNumber),
              ),
            );
            emit(VerificationSuccess());
          } catch (refreshError) {
            emit(const VerificationFailure(
                "Token refresh failed. Please try again."));
          }
        } else {
          emit(VerificationFailure(e.toString()));
        }
      }
    });

    // on<SubmitResetCode>((event, emit) async {
    //   emit(VerificationLoading());
    //   try {
    //     await _repository.forgotPassword(event.email!);
    //     emit(VerificationSuccess());
    //     print("Reset this ${event.email} ");
    //   } catch (e) {
    //     emit(VerificationFailure(e.toString()));
    //   }
    // });
    on<ResendCode>((event, emit) async {
      emit(VerificationLoading());
      try {
        await sl<ResendCodeUsecase>().call(
            params: ResendCodeParams(
                email: event.email,
                phoneNumber:
                    EthiopianPhoneValidator.normalize(event.phoneNumber)));
        // await sl<AuthRepository>().resendCode(event.email);
        emit(VerificationCodeResent());
      } catch (e) {
        emit(VerificationFailure(e.toString()));
      }
    });
    on<ResetCode>((event, emit) {
      emit(VerificationInitial());
    });
  }
}
