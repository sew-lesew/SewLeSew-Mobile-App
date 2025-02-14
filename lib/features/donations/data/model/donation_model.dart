class DonationModel {
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

  DonationModel({
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

  factory DonationModel.fromJson(Map<String, dynamic> json) {
    return DonationModel(
      id: json['id'],
      campaignId: json['campaignId'],
      userId: json['userId'],
      amount: json['amount'],
      txRef: json['txRef'],
      donorFirstName: json['donorFirstName'],
      donorLastName: json['donorLastName'],
      email: json['email'],
      isAnonymous: json['isAnonymous'],
      paymentStatus: json['paymentStatus'],
      checkoutUrl: json['checkoutUrl'],
      createdAt: json['createdAt'],
    );
  }
  factory DonationModel.fromChapaJson(Map<String, dynamic> json) {
    return DonationModel(
      txRef: json['txRef'],
      checkoutUrl: json['checkoutUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'donorFirstName': donorFirstName,
      'donorLastName': donorLastName,
      'email': email,
      'isAnonymous': isAnonymous,
      "medium": "MOBILE"
    };
  }
}
