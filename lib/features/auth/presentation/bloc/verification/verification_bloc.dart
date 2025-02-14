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
      await sl<VerifyAccountUsecase>().call(
        params: VerifyAccountParams(
          email: event.email,
          code: event.code,
          phoneNumber: event.phoneNumber,
        ),
      );

      emit(VerificationSuccess());
    });

    on<ResendCode>((event, emit) async {
      emit(VerificationLoading());
      try {
        await sl<ResendCodeUsecase>().call(
            params: ResendCodeParams(
                email: event.email,
                phoneNumber:
                    EthiopianPhoneValidator.normalize(event.phoneNumber)));
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
