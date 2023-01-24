import 'package:get/get.dart';
import 'package:sarbu/boundary/dashboard_page.dart';
import 'package:sarbu/boundary/login_page.dart';
import 'package:sarbu/boundary/splash_scree.dart';

class AppRouter {
  static String splash = '/';
  static String loginPage = '/login';
  static String dashboard = '/dashboard';
}

final getPages = [
  GetPage(name: AppRouter.splash, page: () => const SplashScreen()),
  GetPage(name: AppRouter.loginPage, page: () => LoginPage()),
  GetPage(name: AppRouter.dashboard, page: () => const DashBoardPage())
];
