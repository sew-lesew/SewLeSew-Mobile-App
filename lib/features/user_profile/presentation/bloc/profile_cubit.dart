import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewlesew_fund/features/user_profile/domain/entities/profile_entity.dart';
import 'package:sewlesew_fund/features/user_profile/domain/usecase/deactivate_account.dart';

import '../../../../core/resources/generic_state.dart';
import '../../../../injection_container.dart';
import '../../domain/usecase/get_my_profile.dart';
import '../../domain/usecase/update_profile.dart';

class ProfileCubit extends Cubit<GenericState> {
  ProfileCubit() : super(GenericState(isLoading: false));

  Future<void> updateProfile(ProfileEntity entity) async {
    emit(state.copyWith(isLoading: true));
    try {
      final result = await sl<UpdateProfileUsecase>().call(params: entity);
      emit(state.copyWith(isLoading: false, isSuccess: true, data: result));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        failure: e.toString(),
        isSuccess: false,
      ));
    }
  }

  Future<void> getMyProfile() async {
    emit(state.copyWith(isLoading: true));
    try {
      final result = await sl<GetMyProfileUsecase>().call();
      emit(state.copyWith(isLoading: false, isSuccess: true, data: result));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        failure: e.toString(),
        isSuccess: false,
      ));
    }
  }

  Future<void> deactivateAccount() async {
    try {
      emit(state.copyWith(isLoading: true));
      await sl<DeactivateAccountUsecase>().call();
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      state.copyWith(
        isLoading: false,
        failure: e.toString(),
        isSuccess: false,
      );
    }
  }
}
