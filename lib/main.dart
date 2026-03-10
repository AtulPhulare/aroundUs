import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'src/config/logger/debug_log_service.dart';
import 'src/config/logger/log_service.dart';
import 'src/routes/app_pages.dart';
import 'src/routes/app_routes.dart';

late final LogService logService;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  logService = DebugLogService();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final mediaQuery = MediaQuery.of(
          context,
        ).copyWith(textScaler: TextScaler.linear(1.0));

        return MediaQuery(
          data: mediaQuery,
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Lunara App',
            theme: ThemeData(
              // primaryColor: AppColors.primaryColor,
              fontFamily: 'Manrope',
              scaffoldBackgroundColor: const Color(0xFFFFF7EC),
              appBarTheme: const AppBarTheme(
                centerTitle: true,
                backgroundColor: Color(0xFFFFF7EC),
                elevation: 0,
                surfaceTintColor: Colors.transparent,
                shadowColor: Colors.transparent,
                foregroundColor: Colors.black,
              ),
            ),
            initialRoute: AppRoutes.splash,
            getPages: AppPages.routes,
          ),
        );
      },
    );
  }
}
