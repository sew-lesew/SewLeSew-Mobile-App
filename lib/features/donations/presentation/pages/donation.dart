import 'package:flutter/material.dart';

class Donation extends StatelessWidget {
  const Donation({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Urgent Campaigns Section
            const Text(
              "Urgent Campaigns",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5, // Example campaigns
                itemBuilder: (context, index) => _buildUrgentCampaignCard(),
              ),
            ),

            // Donation Input Section

            const SizedBox(height: 20),

            // Previous Donations Section
            const Text(
              "My Donations",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3, // Example previous donations
              itemBuilder: (context, index) => _buildPreviousDonationTile(),
            ),
            const SizedBox(height: 20),

            // Final Note and Call to Action
            Center(
              child: Text(
                "Your contribution will create a lasting impact!",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.teal.shade700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build a previous donation tile
  Widget _buildPreviousDonationTile() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.teal.shade100,
          child: const Icon(Icons.campaign, color: Colors.teal),
        ),
        title: const Text(
          "Education for All Campaign",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        subtitle: const Text(
          "Donated: 100birr\nDate: Nov 10, 2024",
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        trailing:
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.teal),
      ),
    );
  }

  // Helper method to build an urgent campaign card
  Widget _buildUrgentCampaignCard() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.only(right: 10),
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Help People Save Live",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 5),
            Text(
              "Deadline: 5 Days Left",
              style: TextStyle(fontSize: 12, color: Colors.red.shade600),
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: 0.6, // Example progress
              backgroundColor: Colors.grey.shade300,
              valueColor: const AlwaysStoppedAnimation(Colors.teal),
            ),
            const SizedBox(height: 5),
            const Text(
              "Raised: 6,000birr of 10,000birr",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
