import 'package:equatable/equatable.dart';
import 'package:sewlesew_fund/features/campaign/domain/entities/business_campaign_entity.dart';

import '../../../../../core/resources/generic_state.dart';

class CreateCampaignState extends Equatable {
  final GenericState<BusinessCampaignEntity> state;
  final int currentPage;

  const CreateCampaignState({
    required this.state,
    required this.currentPage,
  });

  CreateCampaignState copyWith({
    GenericState<BusinessCampaignEntity>? state,
    int? currentPage,
  }) {
    return CreateCampaignState(
      state: state ?? this.state,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props => [state, currentPage];
}
