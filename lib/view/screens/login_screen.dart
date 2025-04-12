import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_strings.dart';
import '../../utils/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../widgets/login_appbar_widget.dart';

class LoginScreen extends GetView<AuthController> {
  LoginScreen({super.key});

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LoginAppBarWidget(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // app logo
            Image.asset('./assets/icons/logo.png', height: 150, width: 250, fit: BoxFit.contain),

            //welcome text
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                '${AppStrings.welcomeText} \n ${AppStrings.loginText}',
                textAlign: TextAlign.center,
                style: TextStyles.textRegular20,
              ),
            ),
            const SizedBox(height: 34),

            // phone number text field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  hintText: AppStrings.userNameText,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(
                      './assets/icons/ic_profile.svg',
                      height: 24,
                      width: 24,
                      fit: BoxFit.cover,
                      colorFilter: const ColorFilter.mode(AppColors.grey400Color, BlendMode.srcIn),
                    ),
                  ),
                ),
              ),
            ),

            //password text field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: AppStrings.enterYourPwdText,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(
                      './assets/icons/ic_eye_closed.svg',
                      height: 24,
                      width: 24,
                      fit: BoxFit.cover,
                      colorFilter: const ColorFilter.mode(AppColors.grey400Color, BlendMode.srcIn),
                    ),
                  ),
                ),
              ),
            ),

            //confirm button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ElevatedButton(
                onPressed: () async {
                  bool isLLogged = await controller.signIn(phoneController.text, passwordController.text, '');
                  if(isLLogged){
                    Get.toNamed('/');
                  }else{
                    Get.snackbar('خطا في تسجيل الدخول', 'الرجاء التاكد من المعلومات المدخلة');
                  }
                },
                child: Text(
                  AppStrings.loginText,
                  style: TextStyles.textBold16.copyWith(color: AppColors.onPrimaryColor),
                ),
              ),
            ),
            //Center(child: SvgPicture.asset('./assets/images/toolbar_image.svg'),),
          ],
        ),
      ),
    );
  }

  void checkValidation() {
    // String phone = phoneController.text;
    // String password = passwordController.text;

    // if (phone.length == 14 && password.length >= 4) {
    //
    // } else {
    //   Get.snackbar('خطا في تسجيل الدخول', 'الرجاء التاكد من المعلومات المدخلة');
    // }
  }
}
