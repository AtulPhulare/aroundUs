import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'src/config/logger/debug_log_service.dart';
import 'src/config/logger/log_service.dart';
import 'src/config/theme/theme_controller.dart';
import 'src/utils/theme/app_theme.dart';
import 'src/routes/app_pages.dart';
import 'src/routes/app_routes.dart';

late final LogService logService;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  logService = DebugLogService();

  // Initialise the theme controller so it's available everywhere
  Get.put(ThemeController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Around Us',
      theme: ThemeData(fontFamily: 'Sora'),
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,
    );
  }
}
