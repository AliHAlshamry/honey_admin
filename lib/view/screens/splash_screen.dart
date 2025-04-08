import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:honey_admin/controllers/auth_controller.dart';

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
    final authController = Get.put(AuthController());
    // Replace with your actual authentication check
    String? token = authController.box.read('accessToken');
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