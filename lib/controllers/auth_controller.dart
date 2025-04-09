import '../../utils/constants/app_colors.dart';
import '../../utils/constants/screen_urls.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../api/api_utils.dart';
import '../api/end_points.dart';
import '../models/auth_model.dart';
import '../utils/constants/app_strings.dart';

class AuthController extends GetxController {
  final auth = Rxn<Auth>();
  final RxString accessToken = ''.obs;
  final RxString refreshKey = ''.obs;

  final box = GetStorage();


  @override
  void onInit() async {
    super.onInit();
    await initializeAuth();
  }

  // Future<bool> tokenStillValid() async {
  //   try {
  //     final response = await ApiUtils().get(
  //       endpoint: '${EndPoints.userProfile}/${auth.value?.id}',
  //     );
  //     if (response?.statusCode == 200) {
  //       return true;
  //     }
  //   } on DioException catch (e) {
  //     printError(info: 'message: ${e.message}');
  //   }
  //   return false;
  // }

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
    EasyLoading.show(status: AppStrings.signIn);
    try {
      //final fcmToken = await box.read('FCMToken');
      final response = await ApiUtils().post(
        endpoint:'https://api.honey-comb.store/oms/auth/login',
        data: {"username": phone, "password": password},
      );
      if (response.statusCode == 201) {
        final accessToken = response.data['accessToken'];
        final refreshToken = response.data['refreshToken'];
        //await postSignInProcess(accessToken, refreshToken);
        await ApiUtils().saveUserData(accessToken, refreshToken);
        Get.snackbar(AppStrings.signIn, AppStrings.loginSuccessfully);
        debugPrint('Access Token: ${auth.value?.accessToken}');
        return true;
      }
    } on DioException catch (e) {
      printError(info: 'Dio Error! ${e.response!.data.toString()}');
      Get.snackbar(AppStrings.error, AppStrings.statusSomethingWrong);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      EasyLoading.dismiss();
    }
    return false;
  }

  Future<bool> resetPassword(phone, password) async {
    EasyLoading.show(status: AppStrings.resetPassword);
    try {
      final fcmToken = await box.read('FCMToken');
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

  void deleteAccount() async {
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
  }

  void _signOut() async {
    if (Get.isDialogOpen == true) Get.close(1);
    EasyLoading.show(status: AppStrings.logout);
    destroyAuth();
    EasyLoading.dismiss();
    update();
    Get.toNamed('/');
  }

  void destroyAuth() async{
    await box.remove('accessToken');
    await box.remove('refreshToken');
    //refreshControllers();
  }

  bool isTokenExpired() {
    // In other words, the token needs refresh
    if (isSignedOut) {
      return false;
    } else {
      if (accessToken.value == '') {
        return false;
      }
      return true;
    }
  }

  tokenExpiredAt() => JwtDecoder.getExpirationDate(auth.value?.accessToken ?? '');

  bool get isSignedIn => accessToken.value != '';

  bool get isSignedOut => !isSignedIn;

  void refreshController<T>() {
    try {
      final controller = Get.find<T>() as GetxController;
      controller.onInit();
    } catch (e) {
      debugPrint('Trying to refresh a controller that is not exist, this is normal');
    }
  }

  Future<void> postSignInProcess(String accessToken, String refreshToken) async {
    await box.write('accessToken', accessToken);
    await box.write('refreshToken', refreshToken);
    debugPrint('Login successful, registering NID for Firebase push notifications');
    update();
  }

  // Initialize auth state
  Future<void> initializeAuth() async {
    if (isLoggedIn) {
      accessToken.value = await box.read('accessToken');
      refreshKey.value = await box.read('refreshToken');
    }
  }

  bool get isLoggedIn => accessToken.value.isNotEmpty;
}
