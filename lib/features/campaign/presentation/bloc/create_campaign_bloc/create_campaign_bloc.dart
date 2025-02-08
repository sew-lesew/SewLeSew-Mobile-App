import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewlesew_fund/features/campaign/domain/usecases/create_business_campaign.dart';
import '../../../../../core/resources/generic_state.dart';
import '../../../../../injection_container.dart';
import '../../../domain/entities/business_campaign_entity.dart';
import 'create_campaign_event.dart';
import 'create_campaign_state.dart';

class CreateCampaignBloc
    extends Bloc<CreateCampaignEvent, CreateCampaignState> {
  CreateCampaignBloc()
      : super(CreateCampaignState(
          state: GenericState<BusinessCampaignEntity>(),
          currentPage: 0,
        )) {
    on<NextPageEvent>(_handleNextPageEvent);
    on<PreviousPageEvent>(_handlePreviousPageEvent);
    on<SubmitFormEvent>(_handleSubmitFormEvent);
  }

  void _handleNextPageEvent(
      NextPageEvent event, Emitter<CreateCampaignState> emit) {
    emit(state.copyWith(currentPage: state.currentPage + 1));
  }

  void _handlePreviousPageEvent(
      PreviousPageEvent event, Emitter<CreateCampaignState> emit) {
    emit(state.copyWith(currentPage: state.currentPage - 1));
  }

  void _handleSubmitFormEvent(
      SubmitFormEvent event, Emitter<CreateCampaignState> emit) async {
    emit(state.copyWith(
      state: state.state.copyWith(isLoading: true),
    ));
    final result = await sl<CreateBusinessCampaignUsecase>()
        .call(params: event.campaignData);
    result.fold(
        (failure) => emit(state.copyWith(
              state: state.state.copyWith(
                isLoading: false,
                failure: failure.message,
              ),
            )),
        (success) => emit(
              state.copyWith(
                state: state.state.copyWith(
                  isLoading: false,
                  isSuccess: true,
                ),
              ),
            ));
  }
}
