import 'package:equatable/equatable.dart';
import 'package:sewlesew_fund/features/campaign/domain/entities/business_campaign_entity.dart';

abstract class CreateCampaignEvent extends Equatable {
  const CreateCampaignEvent();

  @override
  List<Object?> get props => [];
}

class NextPageEvent extends CreateCampaignEvent {
  final BusinessCampaignEntity campaignData;

  const NextPageEvent(this.campaignData);

  @override
  List<Object?> get props => [campaignData];
}

class PreviousPageEvent extends CreateCampaignEvent {}

class SubmitFormEvent extends CreateCampaignEvent {
  final BusinessCampaignEntity campaignData;

  const SubmitFormEvent(this.campaignData);

  @override
  List<Object?> get props => [campaignData];
}
