class DonationEntity {
  final String? id;
  final String? campaignId;
  final String? userId;
  final String? amount;
  final String? txRef;
  final String? donorFirstName;
  final String? donorLastName;
  final String? email;
  final bool? isAnonymous;
  final String? paymentStatus;
  final String? checkoutUrl;
  final String? createdAt;

  DonationEntity({
    this.id,
    this.campaignId,
    this.userId,
    this.amount,
    this.txRef,
    this.donorFirstName,
    this.donorLastName,
    this.email,
    this.isAnonymous,
    this.paymentStatus,
    this.checkoutUrl,
    this.createdAt,
  });
}
