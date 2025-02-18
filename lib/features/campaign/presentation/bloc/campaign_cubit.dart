import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewlesew_fund/core/resources/success_failure.dart';
import 'package:sewlesew_fund/features/campaign/domain/usecases/get_campaign_by_id.dart';
import 'package:sewlesew_fund/features/campaign/domain/usecases/get_campaigns.dart';
import 'package:sewlesew_fund/injection_container.dart';

import '../../domain/usecases/get_my_campaigns.dart';
import '../../../../core/resources/generic_state.dart';

class CampaignCubit extends Cubit<GenericState<Either<Failure, Success>>> {
  CampaignCubit()
      : super(GenericState<Either<Failure, Success>>(isLoading: false));

  void getMyCampaigns({String? camapignStatus}) async {
    emit(state.copyWith(isLoading: true));

    final result =
        await sl<GetMyCampaignsUsecase>().call(params: camapignStatus);

    emit(state.copyWith(
      isLoading: false,
      data: result,
      failure: result.isLeft() ? (result as Left).value.message : null,
      isSuccess: result.isRight(),
    ));
  }

  void getCampaigns({String? category, String? name}) async {
    emit(state.copyWith(isLoading: true));

    final result = await sl<GetCampaignsUsecase>().call(
        params: CampaignParameter(
      category: category,
      name: name,
    ));

    emit(state.copyWith(
      isLoading: false,
      data: result,
      failure: result.isLeft() ? (result as Left).value.message : null,
      isSuccess: result.isRight(),
    ));
  }

  void getCampaignById(String id) async {
    emit(state.copyWith(isLoading: true));

    final result = await sl<GetCampaignByIdUsecase>().call(params: id);

    emit(state.copyWith(
      isLoading: false,
      data: result,
      failure: result.isLeft() ? (result as Left).value.message : null,
      isSuccess: result.isRight(),
    ));
  }
}
