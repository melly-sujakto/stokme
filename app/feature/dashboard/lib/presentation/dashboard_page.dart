import 'package:feature_dashboard/presentation/dashboard_constants.dart';
import 'package:feature_dashboard/presentation/journey/home/home_page.dart';
import 'package:feature_dashboard/presentation/journey/more/more_page.dart';
import 'package:feature_dashboard/presentation/journey/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:module_common/i18n/i18n_extension.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int activeBottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getContent(context),
      bottomNavigationBar: getBottomNavBar(context),
    );
  }

  Widget getContent(BuildContext context) {
    switch (activeBottomNavIndex) {
      case 1:
        return const ProfilePage();
      case 2:
        return const MorePage();
      default:
        return const HomePage();
    }
  }

  BottomNavigationBar getBottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor:
          activeBottomNavIndex != 0 ? CustomColors.primary.c95 : null,
      currentIndex: activeBottomNavIndex,
      onTap: (index) {
        setState(() {
          activeBottomNavIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            DashboardAssets.homeAssetPathInactive,
            height: LayoutDimen.dimen_35.w,
          ),
          label: DashboardStrings.homeBottomNavBar.i18n(context),
          activeIcon: Image.asset(
            DashboardAssets.homeAssetPathActive,
            height: LayoutDimen.dimen_35.w,
          ),
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            DashboardAssets.profileAssetPathInactive,
            height: LayoutDimen.dimen_35.w,
          ),
          label: DashboardStrings.profileBottomNavBar.i18n(context),
          activeIcon: Image.asset(
            DashboardAssets.profileAssetPathActive,
            height: LayoutDimen.dimen_35.w,
          ),
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            DashboardAssets.moreAssetPathInactive,
            height: LayoutDimen.dimen_35.w,
          ),
          label: DashboardStrings.moreBottomNavBar.i18n(context),
          activeIcon: Image.asset(
            DashboardAssets.moreAssetPathActive,
            height: LayoutDimen.dimen_35.w,
          ),
        ),
      ],
    );
  }
}
