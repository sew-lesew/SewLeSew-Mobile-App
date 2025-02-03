// making a cubit for sign out
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewlesew_fund/core/resources/generic_state.dart';
import 'package:sewlesew_fund/features/auth/domain/usecases/logout.dart';

import '../../../../injection_container.dart';

class SignOutCubit extends Cubit<GenericState> {
  SignOutCubit() : super(GenericState());
  Future<void> signOut() async {
    emit(state.copyWith(isLoading: true));
    try {
      await sl<LogoutUsecase>().call();

      emit(state.copyWith(isSuccess: true, isLoading: false, failure: null));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        failure: e.toString(),
      ));
    }
  }
}
