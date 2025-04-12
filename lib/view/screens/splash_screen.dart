import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../utils/constants/app_strings.dart';
import '../../utils/constants/screen_urls.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    final box = Hive.box(AppStrings.boxKey);
    final String tokenKey = AppStrings.accessToken;
    // Replace with your actual authentication check
    String? token = box.get(tokenKey);
    await Future.delayed(const Duration(seconds: 2)); // Optional delay

    if (token != '' && token != null) {
      Get.offAllNamed(ScreenUrls.mainUrl);
    } else {
      Get.offAllNamed(ScreenUrls.loginUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}