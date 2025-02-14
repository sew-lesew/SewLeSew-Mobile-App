import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewlesew_fund/features/donations/presentation/widgets/donation_widgets.dart';

import '../../../../config/routes/names.dart';
import '../../../../config/theme/colors.dart';
import '../../../donations/presentation/pages/my_donation.dart';
import '../../domain/entities/profile_entity.dart';
import '../bloc/profile_cubit.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  void _navigateTo(BuildContext context, String pageTitle) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyDonationPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Access the ProfileEntity from your state management (example using Provider)
    final ProfileEntity profileEntity = context.read<ProfileCubit>().state.data;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            children: [
              // Profile Card Section
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      // Dynamic Profile Image/Initial
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: AppColors.primaryBackground,
                        backgroundImage: profileEntity.profilePictueUrl != null
                            ? CachedNetworkImageProvider(
                                profileEntity.profilePictueUrl!,
                              )
                            : null,
                        child: profileEntity.profilePictueUrl == null
                            ? Text(
                                profileEntity.firstName!.isNotEmpty
                                    ? profileEntity.firstName![0].toUpperCase()
                                    : '',
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.accentColor,
                                ),
                              )
                            : null,
                      ),
                      const SizedBox(width: 16),
                      // Profile Details
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profileEntity.firstName!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, AppRoutes.EDIT_PROFILE),
                            child: Row(
                              children: [
                                const Text(
                                  'Edit Profile',
                                  style: TextStyle(
                                    color: AppColors.accentColor,
                                    fontSize: 14,
                                  ),
                                ),
                                Icon(
                                  size: 12,
                                  Icons.arrow_forward_ios,
                                  color: AppColors.accentColor,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Impact Section
              lineWithText(text: " YOUR IMPACT", context: context),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildImpactTile(
                      'Lives Supported', '3', Icons.people_outline),
                  _buildImpactTile('Total Donation', '155555',
                      Icons.monetization_on_outlined),
                ],
              ),
              const SizedBox(height: 20),

              // Action List Section
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _buildListTile(
                      context,
                      title: 'Donation History',
                      icon: Icons.history,
                      onTap: () => _navigateTo(context, 'Donation History'),
                    ),
                    _buildDivider(),
                    _buildListTile(
                      context,
                      title: 'FAQ',
                      icon: Icons.help_outline,
                      onTap: () => Navigator.pushNamed(context, AppRoutes.FAQ),
                    ),
                    _buildDivider(),
                    _buildListTile(
                      context,
                      title: 'Support',
                      icon: Icons.phone,
                      onTap: () => _navigateTo(context, 'Support'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              // App Version Section
              Center(
                child: Text(
                  'v1.32.5',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper to build impact tiles
  Widget _buildImpactTile(String title, String value, IconData icon) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Card(
        // color: AppColors.cardColor,
        child: SizedBox(
          width: 125,
          height: 120,
          child: Column(
            children: [
              Icon(icon, size: 40, color: AppColors.accentColor),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper to build list tiles
  Widget _buildListTile(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.accentColor),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }

  // Helper to build divider
  Widget _buildDivider() {
    return const Divider(height: 1, thickness: 1, color: Colors.grey);
  }
}

// Expanded Page to navigate to
class ExpandedPage extends StatelessWidget {
  final String title;
  const ExpandedPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'This is the $title page',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
