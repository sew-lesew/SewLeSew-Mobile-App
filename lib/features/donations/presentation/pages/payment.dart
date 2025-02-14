import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../config/theme/colors.dart';
import '../../../../core/resources/generic_state.dart';
import '../../domain/entities/donation_entity.dart';
import '../bloc/donation_cubit.dart';

class DonatePayment extends StatefulWidget {
  final String? campaignId;
  const DonatePayment({super.key, this.campaignId});

  @override
  State<DonatePayment> createState() => _DonatePaymentState();
}

class _DonatePaymentState extends State<DonatePayment> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  bool _isAnonymous = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Make a Donation"),
        centerTitle: true,
        backgroundColor: AppColors.accentColor,
        elevation: 0,
      ),
      body: BlocConsumer<DonationCubit, GenericState>(
        listener: (context, state) {
          if (state.isLoading!) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Processing donation...")),
            );
          }
          if (state.failure != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.failure!)),
            );
          }

          // Handle successful donation and redirect to Chapa payment page
          if (state.isSuccess!) {
            final donationEntity = state.data as DonationEntity;
            _redirectToPayment(donationEntity.checkoutUrl!);
          }
          if (state.failure != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.failure!)),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Text(
                    "Support a Cause",
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.accentColor,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "Your contribution can make a difference. Please fill out the form below to proceed.",
                    style:
                        TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
                  ),
                  SizedBox(height: 30.h),

                  // Donation Amount
                  TextFormField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                    ],
                    decoration: InputDecoration(
                      labelText: "Donation Amount",
                      prefixIcon: Icon(Icons.attach_money,
                          color: AppColors.accentColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.w),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.w),
                        borderSide: BorderSide(color: AppColors.accentColor),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter an amount";
                      }
                      if (double.tryParse(value) == null) {
                        return "Please enter a valid amount";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.h),

                  // Donor Information
                  Text(
                    "Donor Information",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.accentColor,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      labelText: "First Name",
                      prefixIcon:
                          Icon(Icons.person, color: AppColors.accentColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.w),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.w),
                        borderSide: BorderSide(color: AppColors.accentColor),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your first name";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15.h),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      labelText: "Last Name",
                      prefixIcon:
                          Icon(Icons.person, color: AppColors.accentColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.w),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.w),
                        borderSide: BorderSide(color: AppColors.accentColor),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your last name";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15.h),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email Address",
                      prefixIcon:
                          Icon(Icons.email, color: AppColors.accentColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.w),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.w),
                        borderSide: BorderSide(color: AppColors.accentColor),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      }
                      if (!value.contains("@")) {
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15.h),

                  // Anonymous Donation
                  Row(
                    children: [
                      Checkbox(
                        value: _isAnonymous,
                        onChanged: (value) {
                          setState(() {
                            _isAnonymous = value ?? false;
                          });
                        },
                        activeColor: AppColors.accentColor,
                      ),
                      Text(
                        "Make this donation anonymous",
                        style: TextStyle(
                            fontSize: 14.sp, color: Colors.grey.shade700),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),

                  // Donate Button
                  Center(
                    child: ElevatedButton(
                      onPressed: state.isLoading!
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                final donationEntity = DonationEntity(
                                  campaignId: widget.campaignId ??
                                      "1", // Use provided campaignId or default
                                  amount: _amountController.text.trim(),
                                  email: _emailController.text.trim(),
                                  donorFirstName:
                                      _firstNameController.text.trim(),
                                  donorLastName:
                                      _lastNameController.text.trim(),
                                  isAnonymous: _isAnonymous,
                                );

                                context
                                    .read<DonationCubit>()
                                    .donate(donationEntity);
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: 16.h, horizontal: 50.w),
                        backgroundColor: AppColors.accentColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.w),
                        ),
                      ),
                      child: state.isLoading!
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              "Donate Now",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _redirectToPayment(String paymentUrl) async {
    try {
      if (await canLaunchUrl(Uri.parse(paymentUrl))) {
        await launchUrl(
          Uri.parse(paymentUrl),
          mode: LaunchMode.inAppWebView, // Open in in-app webview
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Could not open payment page")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Payment redirection failed: ${e.toString()}")),
      );
    }
  }
}
