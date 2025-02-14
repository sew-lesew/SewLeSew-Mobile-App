import 'package:flutter/material.dart';
import 'package:sewlesew_fund/features/donations/domain/entities/donation_entity.dart';
import 'package:intl/intl.dart';

class DonationDetail extends StatelessWidget {
  final DonationEntity donation;
  const DonationDetail({super.key, required this.donation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(Intl.message('Donation Detail', name: 'donationDetailTitle')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Donation Receipt',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                buildDetailRow('Donor Name:',
                    '${donation.donorFirstName} ${donation.donorLastName}'),
                buildDetailRow('Donor Email:', donation.email ?? ''),
                buildDetailRow(
                  'Donation Amount:',
                  NumberFormat.currency(symbol: '\$', decimalDigits: 2).format(
                      double.tryParse(donation.amount.toString()) ?? 0.0),
                ),
                buildDetailRow(
                  'Donation Date:',
                  donation.createdAt != null
                      ? DateFormat('MMMM d, yyyy').format(
                          DateTime.tryParse(donation.createdAt!) ??
                              DateTime(2000, 1, 1))
                      : 'N/A',
                ),
                buildDetailRow(
                    'Transaction Reference:', donation.txRef ?? 'N/A'),
                buildDetailRow(
                    'Payment Status:', donation.paymentStatus ?? 'N/A'),
                buildDetailRow(
                    'Is Anonymous:', donation.isAnonymous! ? 'Yes' : 'No'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 7,
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
