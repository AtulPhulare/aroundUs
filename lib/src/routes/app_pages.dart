import 'package:get/get.dart';
import '../utils/splash_screen.dart';
import '../features/auth/screens/login.dart';
import '../features/auth/screens/signup_screen.dart';
import '../features/auth/screens/otp_screen.dart';
import '../features/home/screens/main_screen.dart';
import '../features/community/screens/explore_screen.dart';
import '../features/community/screens/group_list_screen.dart';
import '../features/community/screens/create_group_screen.dart';
import '../features/chat/screens/group_chat_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import '../features/notifications/screens/notification_screen.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = AppRoutes.splash;

  static final routes = [
    GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),
    GetPage(name: AppRoutes.login, page: () => const LoginScreen()),
    GetPage(name: AppRoutes.signup, page: () => const SignupScreen()),
    GetPage(name: AppRoutes.otp, page: () => const OtpScreen()),
    GetPage(name: AppRoutes.main, page: () => const MainScreen()),
    GetPage(name: AppRoutes.explore, page: () => const ExploreScreen()),
    GetPage(name: AppRoutes.groupList, page: () => const GroupListScreen()),
    GetPage(name: AppRoutes.groupChat, page: () => const GroupChatScreen()),
    GetPage(name: AppRoutes.createGroup, page: () => const CreateGroupScreen()),
    GetPage(name: AppRoutes.profile, page: () => const ProfileScreen()),
    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationScreen(),
    ),
  ];
}
