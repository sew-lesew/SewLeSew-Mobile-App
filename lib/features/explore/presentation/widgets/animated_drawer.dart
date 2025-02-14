import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewlesew_fund/config/theme/colors.dart';
import 'package:sewlesew_fund/core/resources/generic_state.dart';
import 'package:sewlesew_fund/features/auth/presentation/bloc/sign_out_cubit.dart';
import 'package:sewlesew_fund/features/explore/presentation/bloc/theme_cubit.dart';
import 'dart:math' as math;

import 'package:sewlesew_fund/features/explore/presentation/pages/home.dart';
import 'package:sewlesew_fund/features/explore/presentation/widgets/show_dialog.dart';
import 'package:sewlesew_fund/features/user_profile/domain/entities/profile_entity.dart';
import 'package:sewlesew_fund/features/user_profile/presentation/bloc/profile_cubit.dart';

import '../../../../config/routes/names.dart';
import 'profile_shimmer.dart';

class CustomDrawer extends StatefulWidget {
  final Widget? child;

  const CustomDrawer({super.key, this.child});

  @override
  State<CustomDrawer> createState() => CustomDrawerState();
}

class CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late double maxSlide;
  late double minSlide;
  final double minDragStartEdge = 50.0;
  late bool _canBeDragged;
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getMyProfile();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    // context.read<ProfileCubit>().getMyProfile();
  }

  void toggleDrawer() {
    if (animationController.isDismissed) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    maxSlide = MediaQuery.of(context).size.width * 0.75; // Drawer occupies 75%
    minSlide = MediaQuery.of(context).size.width * 0.25;
    return GestureDetector(
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, _) {
          double slide = maxSlide * animationController.value;
          double rotationAngle = math.pi / 2 * animationController.value;

          return Stack(
            children: [
              _buildDrawer(),
              Transform.translate(
                offset: Offset(slide, 0),
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(-rotationAngle),
                  alignment: Alignment.centerRight,
                  child: const Scaffold(
                    body: Home(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDrawer() {
    return Material(
      color: Theme.of(context)
          .scaffoldBackgroundColor, // Matches app background color
      child: Row(
        children: [
          Container(
            width: maxSlide, // Drawer width
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<ProfileCubit, GenericState>(
                  builder: (context, state) {
                    if (state.isLoading ?? false) {
                      return ProfileShimmer();
                    }
                    if (state.failure != null) {
                      print("Error: ${state.failure}");
                    }
                    final ProfileEntity profile = state.data;
                    print(profile.profilePictueUrl);
                    final url = profile.profilePictueUrl ??
                        "https://www.example.com/default-avatar.png";
                    final email = profile.email;
                    return Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(url),
                          radius: 35,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Icon(Icons.person,
                              size: 40, color: Color(0xFF4A4E69)),
                        ),
                        SizedBox(width: 15),
                        BlocBuilder<ProfileCubit, GenericState>(
                          builder: (context, state) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Welcome',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.color,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  email ?? "",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.color,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20),
                Divider(color: Theme.of(context).dividerColor),

                // Menu Options
                Expanded(
                  child: ListView(
                    children: [
                      _buildDrawerItem(
                        icon: Icons.home,
                        title: 'Home',
                        onTap: () {
                          Navigator.of(context).pushNamed(AppRoutes.MAIN);
                        },
                      ),
                      _buildDrawerItem(
                        icon: Icons.explore,
                        title: 'Explore',
                        onTap: () {},
                      ),
                      _buildDrawerItem(
                        icon: Icons.settings,
                        title: 'Settings',
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(AppRoutes.EDIT_PROFILE);
                        },
                      ),
                      _buildDrawerItem(
                        icon: Icons.support_agent,
                        title: 'Support',
                        onTap: () {},
                      ),
                      const SizedBox(height: 20),
                      Divider(color: Theme.of(context).dividerColor),
                      BlocBuilder<SignOutCubit, GenericState>(
                          builder: (context, state) {
                        return _buildDrawerItem(
                          icon: Icons.logout,
                          title: 'Logout',
                          onTap: () {
                            showLogoutDialog(context);
                          },
                          iconColor: Colors.redAccent,
                          textColor: Colors.redAccent,
                        );
                      }),
                      _toggelDarkMode(),
                    ],
                  ),
                ),

                // Footer
                Text(
                  'Version 1.0.0',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: animationController.forward,
            child: Container(
              width: minSlide,
              color: Colors.transparent,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? iconColor,
    Color? textColor,
  }) {
    return ListTile(
      leading:
          Icon(icon, color: iconColor ?? Theme.of(context).iconTheme.color),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? Theme.of(context).textTheme.bodyMedium?.color,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _toggelDarkMode() {
    return ListTile(
      onTap: () => context.read<ThemeCubit>().toggleTheme(),
      title: Row(
        children: [
          Text(
            "Dark Mode",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          BlocBuilder<ThemeCubit, bool>(
            builder: (context, isDarkMode) {
              return SizedBox(
                height: 1,
                child: Switch(
                    value: isDarkMode,
                    onChanged: (value) =>
                        context.read<ThemeCubit>().toggleTheme()),
              );
            },
          )
        ],
      ),
    );
  }

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = animationController.isDismissed &&
        details.globalPosition.dx < minDragStartEdge;
    bool isDragCloseFromRight = animationController.isCompleted &&
        details.globalPosition.dx > maxSlide - minDragStartEdge;

    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta! / maxSlide;
      animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    if (animationController.isDismissed || animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= 365.0) {
      double velocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;
      animationController.fling(velocity: velocity);
    } else if (animationController.value < 0.5) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
  }
}
