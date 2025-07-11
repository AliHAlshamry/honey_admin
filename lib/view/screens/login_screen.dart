import 'package:flutter/services.dart';
import '../../utils/constants/app_strings.dart';
import '../../utils/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../widgets/login_appbar_widget.dart';

class LoginScreen extends GetView<AuthController> {
  LoginScreen({super.key});

  final phoneFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LoginAppBarWidget(),
      body: SingleChildScrollView(
        child: AutofillGroup(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('./assets/icons/logo.png', height: 150, width: 250),

              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  '${AppStrings.welcomeText} \n ${AppStrings.loginText}',
                  textAlign: TextAlign.center,
                  style: TextStyles.textRegular20,
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextField(
                  controller: controller.phoneController,
                  autofillHints: const [AutofillHints.username],
                  decoration: InputDecoration(
                    hintText: AppStrings.userNameText,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset('./assets/icons/ic_profile.svg'),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: controller.passwordController,
                  obscureText: true,
                  autofillHints: const [AutofillHints.password],
                  decoration: InputDecoration(
                    hintText: AppStrings.enterYourPwdText,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset('./assets/icons/ic_eye_closed.svg'),
                    ),
                  ),
                  onEditingComplete: () => TextInput.finishAutofillContext(),
                ),
              ),

              Obx(() => CheckboxListTile(
                value: controller.rememberMe.value,
                onChanged: (value) => controller.rememberMe.value = value ?? false,
                title: Text('تذكرني'),
                controlAffinity: ListTileControlAffinity.leading,
              )),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    bool isLogged = await controller.signIn(
                      controller.phoneController.text.trim(),
                      controller.passwordController.text.trim(),
                      '',
                    );
                    if (isLogged) {
                      Get.toNamed('/');
                    } else {
                      Get.snackbar('خطأ في تسجيل الدخول', 'الرجاء التأكد من المعلومات المدخلة');
                    }
                  },
                  child: Text(AppStrings.loginText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

