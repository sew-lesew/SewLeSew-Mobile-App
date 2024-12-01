import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
              ),
              const Column(
                children: [
                  SizedBox(height: 40),
                  Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 55,
                        backgroundImage:
                            AssetImage('assets/welcome/welcome1.png'),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Kidan Mazie",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Software Developer",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const SectionHeader(title: "Personal Information"),
                const SizedBox(height: 10),
                _buildDetailTile(
                  icon: Icons.person,
                  title: "Full Name",
                  value: "Kidan Mazie",
                ),
                _buildDetailTile(
                  icon: Icons.phone,
                  title: "Mobile Number",
                  value: "+251 921 889 274",
                ),
                _buildDetailTile(
                  icon: Icons.email,
                  title: "Email Address",
                  value: "kidumazie@gmail.com",
                ),
                const SizedBox(height: 30),
                const SectionHeader(title: "Other Details"),
                const SizedBox(height: 10),
                _buildDetailTile(
                  icon: Icons.location_on,
                  title: "Location",
                  value: "Addis Ababa, Ethiopia",
                ),
                _buildDetailTile(
                  icon: Icons.cake,
                  title: "Date of Birth",
                  value: "5th July 1994",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.teal.withOpacity(0.1),
            child: Icon(icon, color: Colors.teal),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.teal,
      ),
    );
  }
}
