import 'package:flutter/material.dart';
import 'package:unity_fund/features/donations/presentation/widgets/donation_widgets.dart';

import '../../../../config/routes/names.dart';
import '../../../../config/theme/colors.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  void _navigateTo(BuildContext context, String pageTitle) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExpandedPage(title: pageTitle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.primaryBackground,
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
                      // Profile Image Placeholder
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: AppColors.primaryBackground,
                        child: const Text(
                          'K',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: AppColors.accentColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Profile Details
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Kidan',
                            style: TextStyle(
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
                      'Lives Supported', '0', Icons.people_outline),
                  _buildImpactTile(
                      'Total Donation', '0', Icons.monetization_on_outlined),
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


// class Profile extends StatelessWidget {
//   const Profile({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Stack(
//             children: [
//               Container(
//                 height: 200,
//                 decoration: const BoxDecoration(
//                   color: AppColors.accentColor,
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(40),
//                     bottomRight: Radius.circular(40),
//                   ),
//                 ),
//               ),
//               const Column(
//                 children: [
//                   SizedBox(height: 40),
//                   Center(
//                     child: CircleAvatar(
//                       radius: 60,
//                       backgroundColor: Colors.white,
//                       child: CircleAvatar(
//                         radius: 55,
//                         backgroundImage:
//                             AssetImage('assets/welcome/welcome1.png'),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     "Kidan Mazie",
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                   Text(
//                     "Software Developer",
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.white70,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 20),
//                 const SectionHeader(title: "Personal Information"),
//                 const SizedBox(height: 10),
//                 _buildDetailTile(
//                   icon: Icons.person,
//                   title: "Full Name",
//                   value: "Kidan Mazie",
//                 ),
//                 _buildDetailTile(
//                   icon: Icons.phone,
//                   title: "Mobile Number",
//                   value: "+251 921 889 274",
//                 ),
//                 _buildDetailTile(
//                   icon: Icons.email,
//                   title: "Email Address",
//                   value: "kidumazie@gmail.com",
//                 ),
//                 const SizedBox(height: 30),
//                 const SectionHeader(title: "Other Details"),
//                 const SizedBox(height: 10),
//                 _buildDetailTile(
//                   icon: Icons.location_on,
//                   title: "Location",
//                   value: "Addis Ababa, Ethiopia",
//                 ),
//                 _buildDetailTile(
//                   icon: Icons.cake,
//                   title: "Date of Birth",
//                   value: "5th July 1994",
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDetailTile({
//     required IconData icon,
//     required String title,
//     required String value,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: Row(
//         children: [
//           CircleAvatar(
//             radius: 20,
//             backgroundColor: AppColors.accentColor.withOpacity(0.1),
//             child: Icon(icon, color: AppColors.accentColor),
//           ),
//           const SizedBox(width: 15),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey,
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//                 Text(
//                   value,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SectionHeader extends StatelessWidget {
//   final String title;

//   const SectionHeader({required this.title, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       title,
//       style: const TextStyle(
//         fontSize: 18,
//         fontWeight: FontWeight.bold,
//         color: AppColors.accentColor,
//       ),
//     );
//   }
// }
