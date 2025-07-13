import 'package:get/get.dart';
import '../utils/bindings/bindings.dart';
import '../utils/constants/screen_urls.dart';
import '../view/screens/home_screen.dart';
import '../view/screens/splash_screen.dart';
import '../view/screens/login_screen.dart';

final routes = [
  GetPage(
    name: '/', // Initial route
    page: () => const SplashScreen(),
  ),
  GetPage(
    name: ScreenUrls.homeUrl,
    page: () =>  HomeScreen(),
    binding: HomeBinding(),
  ),

  GetPage(
    name: ScreenUrls.loginUrl,
    page: () => LoginScreen(),
    binding: LoginBinding(),
  ),
];
