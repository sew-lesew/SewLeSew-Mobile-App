import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sewlesew_fund/config/theme/colors.dart';
import 'package:sewlesew_fund/features/auth/data/services/local/storage_services.dart';
import 'package:sewlesew_fund/features/campaign/presentation/pages/campaign.dart';
import 'package:sewlesew_fund/features/explore/presentation/bloc/theme_cubit.dart';
import 'package:sewlesew_fund/features/user_profile/presentation/pages/profile.dart';
import 'config/routes/pages.dart';
import 'features/donations/presentation/pages/donation.dart';
import 'features/explore/presentation/pages/home.dart';
import 'features/explore/presentation/widgets/animated_drawer.dart';
import 'injection_container.dart';

void main() async {
  await initializeDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppPages appPages = AppPages();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        ...appPages.allBlocProvider(context),
        BlocProvider(create: (_) => ThemeCubit())
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return BlocBuilder<ThemeCubit, bool>(
            builder: (context, state) {
              return MaterialApp(
                theme: sl<StorageService>().getTheme()
                    ? AppTheme.darkTheme
                    : AppTheme.lightTheme,
                debugShowCheckedModeBanner: false,
                onGenerateRoute: appPages.generateRouteSettings,
              );
            },
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  final GlobalKey<CustomDrawerState> _drawerKey =
      GlobalKey<CustomDrawerState>();

  late TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this); // Adjust for 4 tabs
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _tabController.animateTo(index);
  }

  @override
  Widget build(BuildContext context) {
    String appBarTitle;
    List<Widget> appBarActions = [];
    Widget? leading;

    switch (_currentIndex) {
      case 0: // Home
        appBarTitle = "SewLeSew Fund";
        appBarActions = [
          IconButton(
            icon: const Icon(Icons.login_rounded),
            onPressed: () {
              Navigator.of(context).pushNamed('/sign_in');
            },
          ),
        ];
        leading = IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _drawerKey.currentState?.toggleDrawer();
          },
        );
        break;
      case 1: // Donate
        appBarTitle = "Make Donation";
        leading = null; // No leading icon for other pages
        break;
      case 2: // My Campaigns
        appBarTitle = "Campaigns";
        leading = null;
        appBarActions = [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/add_report');
            },
          ),
        ];
        break;
      case 3: // Profile
        appBarTitle = "Profile";
        leading = null;
        break;
      default:
        appBarTitle = "SewLeSew Fund";
        leading = null;
    }

    Widget pageContent = _currentIndex == 0
        ? CustomDrawer(
            key: _drawerKey,
          )
        : const Home();

    return Scaffold(
      // backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        title: Text(appBarTitle),
        actions: appBarActions,
        leading: leading, // Only provide leading for Home
      ),
      bottomNavigationBar: BottomNavigationBar(
          // backgroundColor: Theme.of(context).primaryColor,
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on_outlined),
              label: 'Donate',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.campaign_outlined),
              label: 'Campaigns',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_outlined),
              label: 'Profile',
            ),
          ]),

      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          pageContent, // Home tab with the drawer
          const Donation(), // Replace with Donate widget
          const Campaign(), // Replace with My Campaigns widget
          const Profile(), // Replace with Profile widget
        ],
      ),
    );
  }
}
