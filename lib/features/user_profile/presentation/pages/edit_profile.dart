import 'package:flutter/material.dart';
import 'package:sewlesew_fund/features/user_profile/presentation/widgets/dialog_box.dart';
import '../../../../config/theme/colors.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool isPersonalDetailsExpanded = true;

  Widget buildProfileSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Header
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.accentColor,
                  child: Text(
                    "K",
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Kidan",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          // Editable Fields
          buildEditableField("Your Name", "Kidan"),
          SizedBox(height: 16),
          buildMobileNumberField(),
          SizedBox(height: 16),
          buildEditableField("Email Address", "kidumazie@gmail.com"),
        ],
      ),
    );
  }

  Widget buildExpandableSection({
    required IconData icon,
    required String title,
    required bool isExpanded,
    required VoidCallback onToggle,
  }) {
    return Column(
      children: [
        Container(
          // color: AppColors.cardColor,
          child: ListTile(
            leading: Icon(icon, color: AppColors.accentColor),
            title: Text(title),
            trailing: isExpanded
                ? Icon(Icons.keyboard_arrow_down)
                : Icon(Icons.arrow_forward_ios, size: 16),
            onTap: onToggle,
          ),
        ),
      ],
    );
  }

  Widget buildSection({
    required IconData icon,
    required String title,
  }) {
    return Container(
      // color: AppColors.cardColor,
      child: ListTile(
        leading: Icon(icon, color: AppColors.accentColor),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          showLogOutDialog(context);
        },
      ),
    );
  }

  Widget buildEditableField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.grey)),
        SizedBox(height: 4),
        TextField(
          decoration: InputDecoration(
            hintText: value,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildMobileNumberField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Mobile Number", style: TextStyle(color: Colors.grey)),
        SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                value: "+251",
                items: ["+251", "+1", "+44", "+91"]
                    .map((code) => DropdownMenuItem(
                          value: code,
                          child: Text(code),
                        ))
                    .toList(),
                onChanged: (value) {
                  // Handle country code change
                },
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 5,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "921889274",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                keyboardType: TextInputType.phone,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        title: Text("Edit Profile"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Expandable Sections
            buildExpandableSection(
              icon: Icons.person,
              title: "Personal Details",
              isExpanded: isPersonalDetailsExpanded,
              onToggle: () {
                setState(() {
                  isPersonalDetailsExpanded = !isPersonalDetailsExpanded;
                });
              },
            ),

            // Profile Section (now below Personal Details)
            if (isPersonalDetailsExpanded) buildProfileSection(),

            buildSection(
              icon: Icons.info,
              title: "Other Details",
            ),
            buildSection(
              icon: Icons.person_outline,
              title: "Deactivate Account",
            ),
            buildSection(
              icon: Icons.logout,
              title: "Logout",
            ),

            SizedBox(height: 30),

            // Save Changes Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Save changes
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  "Save Changes",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
