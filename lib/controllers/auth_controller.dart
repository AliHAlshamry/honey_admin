import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../api/api_utils.dart';
import '../api/end_points.dart';
import '../utils/constants/app_colors.dart';
import '../utils/constants/app_strings.dart';
import '../view/screens/login_screen.dart';

class AuthController extends GetxController {
  final _box = Hive.box(AppStrings.boxKey);
  final String tokenKey = AppStrings.accessToken;
  final String refreshKey = AppStrings.refreshToken;
  final String usernameKey = 'saved_username';
  final String passwordKey = 'saved_password';
  final String rememberMeKey = 'remember_me';
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  final rememberMe = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSavedCredentials();
  }

  void _loadSavedCredentials() {
    final saved = _box.get(rememberMeKey, defaultValue: false);
    rememberMe.value = saved;

    if (saved) {
      final username = _box.get(usernameKey);
      final password = _box.get(passwordKey);
      phoneController.text = username ?? '';
      passwordController.text = password ?? '';
    }
  }


  Future<void> _saveLoginInfo(String username, String password) async {
    await _box.put(usernameKey, username);
    await _box.put(passwordKey, password);
    await _box.put(rememberMeKey, true);
  }

  Future<void> clearSavedLoginInfo() async {
    await _box.delete(usernameKey);
    await _box.delete(passwordKey);
    await _box.put(rememberMeKey, false);
  }

  Future<bool> signIn(String phone, String password, String token) async {
    try {
      final response = await ApiUtils().post(
        endpoint: EndPoints.login,
        data: {"username": phone, "password": password},
      );
      if (response.statusCode == 201) {
        final accessToken = response.data['accessToken'];
        final refreshToken = response.data['refreshToken'];
        await ApiUtils().saveUserData(accessToken, refreshToken);
        Get.snackbar(AppStrings.signIn, AppStrings.loginSuccessfully);

        if (rememberMe.value) {
          await _saveLoginInfo(phone, password);
        } else {
          await clearSavedLoginInfo();
        }

        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar(AppStrings.error, AppStrings.statusSomethingWrong);
    } finally {
      EasyLoading.dismiss();
    }
    return false;
  }

  void signOut([bool withoutConfirmation = false]) {
    if (withoutConfirmation) {
      _signOut();
      return;
    }
    Get.defaultDialog(
      title: AppStrings.logout,
      content: Text(AppStrings.signOutConfirmationSubtitle),
      confirm: OutlinedButton(
        onPressed: _signOut,
        style: OutlinedButton.styleFrom(backgroundColor: AppColors.yellow500Color, foregroundColor: Colors.white),
        child: Text(AppStrings.logout),
      ),
      cancel: TextButton(onPressed: () => Get.close(1), child: Text(AppStrings.cancel)),
    );
  }

  void _signOut() async {
    if (Get.isDialogOpen == true) Get.close(1);
    destroyAuth();
    update();
    Get.toNamed('/');
  }

  void destroyAuth() async{
    await _box.delete(refreshKey);
    await _box.delete(tokenKey);
    //refreshControllers();
  }
}
