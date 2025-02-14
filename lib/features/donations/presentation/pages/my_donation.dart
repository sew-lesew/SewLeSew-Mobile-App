import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/resources/generic_state.dart';
import '../../../auth/presentation/widgets/flutter_toast.dart';
import '../../domain/entities/donation_entity.dart';
import '../bloc/donation_cubit.dart';
import 'donation_detail.dart';

class MyDonationPage extends StatefulWidget {
  const MyDonationPage({super.key});

  @override
  _MyDonationPageState createState() => _MyDonationPageState();
}

class _MyDonationPageState extends State<MyDonationPage> {
  @override
  void initState() {
    super.initState();
    context.read<DonationCubit>().getDonationByUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Donations'),
      ),
      body: _buildPreviousDonationTile(),
    );
  }

  Widget _buildPreviousDonationTile() {
    return BlocBuilder<DonationCubit, GenericState>(
      builder: (context, state) {
        if (state.isLoading ?? false) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        // if (state.failure != null) {
        //   return toastInfo(msg: state.failure);
        // }

        final data = state.data as List<DonationEntity>;
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final donation = data[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DonationDetail(donation: donation)));
                },
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.accentColor.withAlpha(128),
                    child: const Icon(Icons.campaign,
                        color: AppColors.accentColor),
                  ),
                  title: Text(
                    "${donation.donorFirstName} ${donation.donorLastName}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      size: 16, color: AppColors.accentColor),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
