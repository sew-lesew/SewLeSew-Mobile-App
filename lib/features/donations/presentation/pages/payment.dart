import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config/theme/colors.dart';
import '../../data/services/payment_service.dart';

class DonatePayment extends StatefulWidget {
  const DonatePayment({super.key});

  @override
  State<DonatePayment> createState() => _DonatePaymentState();
}

class _DonatePaymentState extends State<DonatePayment> {
  final TextEditingController _amountController = TextEditingController();
  String selectedFund = "General Fund"; // Default fund
  final List<String> funds = [
    "General Fund",
    "Education Support",
    "Healthcare Assistance",
    "Emergency Relief",
  ];

  bool isLoading = false;

  final PaymentService _paymentService = PaymentService(Dio());

  Future<void> _processChapaPayment() async {
    final amount = _amountController.text.trim();

    if (amount.isEmpty || double.tryParse(amount) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid donation amount.")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final paymentUrl = await _paymentService.initializeChapaPayment(
        amount: amount,
        email: "donor@example.com", // Replace with user email if available
        firstName: "First", // Replace with user first name if available
        lastName: "Last", // Replace with user last name if available
        fundTitle: "Donation to $selectedFund",
      );

      // Redirect user to Chapa payment page
      _redirectToPayment(paymentUrl);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Payment failed: $e")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _redirectToPayment(String paymentUrl) async {
    if (await canLaunchUrl(Uri.parse(paymentUrl))) {
      await launchUrl(Uri.parse(paymentUrl),
          mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not launch payment URL.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Donate Payment"),
        centerTitle: true,
        backgroundColor: AppColors.accentColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
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
                "Make a difference by donating to a fund of your choice.",
                style: TextStyle(fontSize: 16.sp, color: Colors.grey.shade700),
              ),
              SizedBox(height: 30.h),

              // Donation Amount
              Text(
                "Enter Donation Amount",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 10.h),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon:
                      Icon(Icons.attach_money, color: AppColors.accentColor),
                  hintText: "Enter amount",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.w),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.w),
                    borderSide: BorderSide(color: AppColors.accentColor),
                  ),
                ),
              ),
              SizedBox(height: 30.h),

              // Select Fund
              Text(
                "Choose a Fund",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 10.h),
              DropdownButton<String>(
                value: selectedFund,
                isExpanded: true,
                icon: Icon(Icons.arrow_drop_down, color: AppColors.accentColor),
                items: funds.map((fund) {
                  return DropdownMenuItem(
                    value: fund,
                    child: Text(fund, style: TextStyle(fontSize: 16.sp)),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedFund = value!;
                  });
                },
                style: TextStyle(color: Colors.grey.shade800, fontSize: 16.sp),
                underline: Container(
                  height: 2.h,
                  color: AppColors.accentColor,
                ),
              ),
              SizedBox(height: 50.h),

              // Donate Button
              Center(
                child: ElevatedButton(
                  onPressed: isLoading ? null : _processChapaPayment,
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(vertical: 16.h, horizontal: 50.w),
                    backgroundColor: AppColors.accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.w),
                    ),
                  ),
                  child: isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                          "Donate Now",
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
