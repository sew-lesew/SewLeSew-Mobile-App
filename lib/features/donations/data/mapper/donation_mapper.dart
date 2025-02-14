// donation mapper class for converting DonationEntity to DonationModel(fromEntity) and vice versa(toEntity)

import '../../domain/entities/donation_entity.dart';
import '../model/donation_model.dart';

class DonationMapper {
  static DonationModel fromEntity(DonationEntity entity) {
    return DonationModel(
      id: entity.id,
      campaignId: entity.campaignId,
      userId: entity.userId,
      amount: entity.amount,
      txRef: entity.txRef,
      donorFirstName: entity.donorFirstName,
      donorLastName: entity.donorLastName,
      email: entity.email,
      isAnonymous: entity.isAnonymous,
      paymentStatus: entity.paymentStatus,
      createdAt: entity.createdAt,
    );
  }

  static DonationEntity toEntity(DonationModel model) {
    return DonationEntity(
      id: model.id,
      campaignId: model.campaignId,
      userId: model.userId,
      amount: model.amount,
      txRef: model.txRef,
      donorFirstName: model.donorFirstName,
      donorLastName: model.donorLastName,
      email: model.email,
      isAnonymous: model.isAnonymous,
      paymentStatus: model.paymentStatus,
      createdAt: model.createdAt,
    );
  }

  static DonationEntity toChapaEntity(DonationModel model) {
    return DonationEntity(txRef: model.txRef, checkoutUrl: model.checkoutUrl);
  }
}
