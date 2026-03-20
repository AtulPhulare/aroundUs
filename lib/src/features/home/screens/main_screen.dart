import 'package:around_us/src/utils/theme/app_colors.dart';
import 'package:around_us/src/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../community/screens/explore_screen.dart';
import '../../community/screens/group_list_screen.dart';
import '../../notifications/screens/notification_screen.dart';
import '../../profile/screens/profile_screen.dart';

class MainController extends GetxController {
  var currentIndex = 0.obs;
  void changePage(int index) => currentIndex.value = index;
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(MainController());

    final screens = <Widget>[
      const ExploreScreen(),
      const GroupListScreen(),
      const NotificationScreen(),
      const ProfileScreen(),
    ];
    final c = AppColors.of(context);
    final t = AppTextStyles.of(context);
    return Scaffold(
      backgroundColor: c.background,
      body: Obx(() => screens[ctrl.currentIndex.value]),
      bottomNavigationBar: Obx(
        () => Container(
          height: 84,
          decoration: BoxDecoration(
            color: c.background,
            border: Border(
              top: BorderSide(
                color: Colors.white.withValues(alpha: 0.05),
                width: 0.5,
              ),
            ),
          ),
          child: NavigationBar(
            selectedIndex: ctrl.currentIndex.value,
            onDestinationSelected: ctrl.changePage,
            backgroundColor: Colors.transparent,
            elevation: 0,
            indicatorColor: AppColors.orange.withValues(alpha: 0.1),
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            destinations: [
              _navDest(
                Icons.explore_rounded,
                Icons.explore_outlined,
                'Explore',
              ),
              _navDest(
                Icons.groups_rounded,
                Icons.groups_outlined,
                'My Groups',
              ),
              _navDest(
                Icons.notifications_rounded,
                Icons.notifications_outlined,
                'Alerts',
              ),
              _navDest(Icons.person_rounded, Icons.person_outlined, 'Profile'),
            ],
          ),
        ),
      ),
    );
  }

  NavigationDestination _navDest(
    IconData selected,
    IconData unselected,
    String label,
  ) {
    return NavigationDestination(
      icon: Icon(unselected, color: const Color(0x61FFFFFF)),
      selectedIcon: Icon(selected, color: AppColors.orangeStart),
      label: label,
    );
  }
}
