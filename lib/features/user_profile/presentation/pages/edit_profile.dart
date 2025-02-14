import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart'; // For image picking
import 'package:sewlesew_fund/features/user_profile/presentation/widgets/dialog_box.dart';
import 'package:sewlesew_fund/features/user_profile/domain/entities/profile_entity.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/resources/generic_state.dart';
import '../../../../core/util/ethiopian_phone_validator.dart';
import '../../../auth/presentation/widgets/flutter_toast.dart';
import '../bloc/profile_cubit.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool isPersonalDetailsExpanded = true;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;
  File? _profilePicture;
  DateTime? _dateOfBirth;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneNumberController = TextEditingController();

    // Fetch profile data on initialization
    context.read<ProfileCubit>().getMyProfile();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profilePicture = File(pickedFile.path);
      });
    }
  }

  Widget buildProfileSection(ProfileEntity? profile) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
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
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: profile?.profilePictueUrl == null
                        ? AppColors.accentColor
                        : null,
                    backgroundImage: _profilePicture != null
                        ? FileImage(_profilePicture!)
                        : profile?.profilePictueUrl != null
                            ? CachedNetworkImageProvider(
                                profile!.profilePictueUrl!)
                            : null,
                    child: _profilePicture == null &&
                            profile?.profilePictueUrl == null
                        ? Text(
                            profile?.firstName!.isNotEmpty == true
                                ? profile!.firstName![0].toUpperCase()
                                : '',
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          )
                        : null,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  profile?.firstName ?? '',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          // Editable Fields
          buildEditableField(
              label: "First Name", controller: _firstNameController),
          SizedBox(height: 12.h),
          buildEditableField(
              label: "Last Name", controller: _lastNameController),
          SizedBox(height: 12.h),
          buildEditableField(
              label: "Email Address", controller: _emailController),
          SizedBox(height: 12.h),
          buildEditableField(
              label: "Phone Number",
              controller: _phoneNumberController,
              validator: (value) {
                if (!EthiopianPhoneValidator.isValidPhoneNumber(value!)) {
                  return "Please enter a valid phone number";
                }

                return null;
              }),

          SizedBox(height: 12.h),
          buildDateOfBirthField(context)
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _dateOfBirth) {
      setState(() {
        _dateOfBirth = picked;
      });
    }
  }

  Widget buildDateOfBirthField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Date of Birth", style: TextStyle(color: Colors.grey)),
        SizedBox(height: 4),
        InkWell(
          onTap: () => _selectDate(context),
          child: InputDecorator(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _dateOfBirth!.toIso8601String().split('T').first,
                  style: TextStyle(fontSize: 16),
                ),
                Icon(Icons.calendar_today, color: AppColors.accentColor),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildEditableField(
      {String? label,
      TextEditingController? controller,
      String? Function(String?)? validator}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label!, style: TextStyle(color: Colors.grey)),
      SizedBox(height: 4),
      TextFormField(
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocConsumer<ProfileCubit, GenericState>(
        listener: (context, state) {
          // if (state.isSuccess!) {
          //   toastInfo(msg: "Profile updated successfully");
          // }
          // if (state.failure != null) {
          //   toastInfo(msg: state.failure!);
          // }
        },
        builder: (context, state) {
          if (state.isLoading!) {
            return Center(child: CircularProgressIndicator());
          }

          final profile = state.data as ProfileEntity?;
          if (profile != null) {
            _firstNameController.text = profile.firstName!;
            _lastNameController.text = profile.lastName!;
            _emailController.text = profile.email!;
            _phoneNumberController.text = profile.phoneNumber ?? '';
            _dateOfBirth = profile.dateOfBirth;
          }

          return SingleChildScrollView(
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

                // Profile Section
                if (isPersonalDetailsExpanded) buildProfileSection(profile),
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
                      final updatedProfile = ProfileEntity(
                        // id: profile!.id,
                        email: _emailController.text,
                        firstName: _firstNameController.text,
                        lastName: _lastNameController.text,
                        profilePicture:
                            _profilePicture ?? profile!.profilePicture,
                        dateOfBirth: _dateOfBirth,
                        phoneNumber: EthiopianPhoneValidator.normalize(
                            _phoneNumberController.text),
                      );
                      // print all entity
                      print(
                          'Date of Birth:  ${updatedProfile.dateOfBirth}, ProfilePicture: ${updatedProfile.profilePicture}, PhoneNumber : ${updatedProfile.phoneNumber}, ${updatedProfile.email}, FirstName:  ${updatedProfile.firstName}, LastName: ${updatedProfile.lastName}');
                      // print("Updated Profile: $updatedProfile"});
                      context
                          .read<ProfileCubit>()
                          .updateProfile(updatedProfile);
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
          );
        },
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
}
