import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:sewlesew_fund/features/donations/domain/usecases/donate.dart';
import 'package:sewlesew_fund/features/donations/domain/usecases/get_donation_by_campaign.dart';
import 'package:sewlesew_fund/features/donations/domain/usecases/verify_donation.dart';
import 'package:sewlesew_fund/features/donations/domain/usecases/get_donation_by_user.dart';
import '../../../../core/resources/generic_state.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/donation_entity.dart';

class DonationCubit extends Cubit<GenericState> {
  DonationCubit() : super(GenericState(isLoading: false));

  Future<void> donate(DonationEntity entity) async {
    emit(state.copyWith(isLoading: true));

    try {
      final DonationEntity result =
          await sl<DonateUseCase>().call(params: entity);
      emit(state.copyWith(isLoading: false, isSuccess: true, data: result));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        failure: "Error donating: $e",
        isSuccess: false,
      ));
    }

    // Open the payment URL directly, assuming it's always valid
    // _redirectToPayment(success.donationEntity!.checkoutUrl!);
  }

  // void _redirectToPayment(String paymentUrl) async {
  //   try {
  //     await launchUrl(Uri.parse(paymentUrl), mode: LaunchMode.externalApplication);
  //   } catch (e) {
  //     emit(state.copyWith(
  //       failure: "Error launching payment: $e",
  //       isSuccess: false,
  //     ));
  //   }
  // }

  Future<void> verifyDonation(String txRef) async {
    emit(state.copyWith(isLoading: true));

    final result = await sl<VerifyDonationUseCase>().call(params: txRef);

    emit(state.copyWith(
      isLoading: false,
      data: result,
      failure: result.isLeft() ? (result as Left).value : null,
      isSuccess: result.isRight(),
    ));
  }

  Future<void> getDonationByCampaign(String id) async {
    emit(state.copyWith(isLoading: true));

    final result = await sl<GetDonationByCampaignUseCase>().call(params: id);
    emit(state.copyWith(
      isLoading: false,
      data: result,
      failure: result.isLeft() ? (result as Left).value : null,
      isSuccess: result.isRight(),
    ));
  }

  Future<void> getDonationByUser() async {
    emit(state.copyWith(isLoading: true));

    try {
      final result = await sl<GetDonationByUserUseCase>().call();

      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
        data: result,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        failure: "Error getting donation: $e",
        isSuccess: false,
      ));
    }
  }
}
