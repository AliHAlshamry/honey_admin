import 'package:hive/hive.dart';

import '../../utils/constants/app_colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../api/api_utils.dart';
import '../api/end_points.dart';
import '../utils/constants/app_strings.dart';

class AuthController extends GetxController {
  final _box = Hive.box(AppStrings.boxKey);
  final String tokenKey = AppStrings.accessToken;
  final String refreshKey = AppStrings.refreshToken;

  Future<dynamic> refreshToken() async {
    try {
      final response = await ApiUtils().patch(
        endpoint: EndPoints.refreshToken
      );
      if (response.statusCode == 200 || response.statusCode == 201) {

        debugPrint('Token refreshed new token: ${response.data['accessToken']}');
        final accessToken = response.data['accessToken'];
        final refreshToken = response.data['refreshToken'];
        await ApiUtils().saveUserData(accessToken, refreshToken);
        //await postSignInProcess(accessToken, refreshToken);
        return true;
      }
    } on DioException catch (e) {
      printError(info: 'message: ${e.message}');
      rethrow;
    }
    return false;
  }

  Future<bool> signIn(phone, password, token) async {
    //EasyLoading.show(status: AppStrings.signIn);
    try {
      //final fcmToken = await box.read('FCMToken');
      final response = await ApiUtils().post(
        endpoint: EndPoints.login,
        data: {"username": phone, "password": password},
      );
      if (response.statusCode == 201) {
        final accessToken = response.data['accessToken'];
        final refreshToken = response.data['refreshToken'];
        //await postSignInProcess(accessToken, refreshToken);
        await ApiUtils().saveUserData(accessToken, refreshToken);
        Get.snackbar(AppStrings.signIn, AppStrings.loginSuccessfully);
        return true;
      }
    } on DioException catch (e) {
      printError(info: 'Dio Error! ${e.toString()}');
      //Get.snackbar(AppStrings.error, e.toString(), duration: Duration(seconds: 60));
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar(AppStrings.error, AppStrings.statusSomethingWrong);
    } finally {
      EasyLoading.dismiss();
    }
    return false;
  }

  Future<bool> resetPassword(phone, password) async {
    EasyLoading.show(status: AppStrings.resetPassword);
    try {
      final fcmToken = await _box.get('FCMToken');
      final response = await ApiUtils().post(
        endpoint: EndPoints.resetPassword,
        data: {"phone": phone, "password": password, 'token': fcmToken ?? ''},
      );
      if (response.statusCode == 200 && response.data['hasError'] != true) {
        Get.snackbar(AppStrings.congratulations, AppStrings.passwordChangedSuccessfully);
        return true;
      } else {
        Get.snackbar(AppStrings.error, response.data['message']);
        return false;
      }
    } on DioException catch (e) {
      printError(info: 'Dio Error! ${e.response!.data.toString()}');
      Get.snackbar(AppStrings.error, AppStrings.statusSomethingWrong);
    } catch (e) {
      debugPrint(e.toString());
      EasyLoading.show(status: e.toString());
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

/*  void deleteAccount() async {
    EasyLoading.show(status: AppStrings.verifyingCode);
    try {
      final res = await ApiUtils().delete(endpoint: '${EndPoints.deleteDataUrl}/${auth.value?.id}');

      if (res.statusCode != 201 && res.statusCode != 200) {
        throw Exception();
      }
      destroyAuth();
      Get.offAllNamed(ScreenUrls.mainUrl);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }*/

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
