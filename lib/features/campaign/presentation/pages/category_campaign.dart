import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewlesew_fund/features/campaign/presentation/pages/create_campaign_tab.dart';

class CampaignCategory extends StatefulWidget {
  const CampaignCategory({super.key});

  @override
  State<CampaignCategory> createState() => _CampaignCategoryState();
}

class _CampaignCategoryState extends State<CampaignCategory> {
  String? _selectedOption; // To track the selected option

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Choose Campaign Category',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF005782),
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Organizational Card
            _buildOptionCard(
              icon: Icons.people_alt_outlined,
              title: 'Organizational',
              isSelected: _selectedOption == 'Organizational',
              onTap: () {
                setState(() {
                  _selectedOption = 'Organizational';
                });
              },
            ),
            const SizedBox(height: 16.0),

            // Business Card
            _buildOptionCard(
              icon: Icons.business_outlined,
              title: 'Business',
              isSelected: _selectedOption == 'Business',
              onTap: () {
                setState(() {
                  _selectedOption = 'Business';
                });
              },
            ),
            const SizedBox(height: 16.0),

            // Personal Card
            _buildOptionCard(
              icon: Icons.business_outlined,
              title: 'Personal',
              isSelected: _selectedOption == 'Personal',
              onTap: () {
                setState(() {
                  _selectedOption = 'Personal';
                });
              },
            ),
            const SizedBox(height: 16.0),

            // Continue Button
            ElevatedButton(
              onPressed: _selectedOption != null
                  ? () {
                      // Navigate to the CreateCampaignForm with the selected type
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateCampaignForm(
                            campaignType: _selectedOption!,
                          ),
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF13ADB7),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14.0),
              ),
              child: Text(
                'Continue',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build an option card
  Widget _buildOptionCard({
    required IconData icon,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: isSelected ? const Color(0xFF13ADB7) : Colors.grey.shade300,
            width: isSelected ? 2.0 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 28,
              color:
                  isSelected ? const Color(0xFF13ADB7) : Colors.grey.shade600,
            ),
            const SizedBox(width: 16.0),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color:
                    isSelected ? const Color(0xFF005782) : Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
