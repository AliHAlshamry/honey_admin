import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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
    final box = GetStorage();
    // Replace with your actual authentication check
    String? token = box.read('accessToken');
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