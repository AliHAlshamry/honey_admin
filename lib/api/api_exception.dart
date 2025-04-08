import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ApiException implements Exception {
  ApiException.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = 'exception_canceled'.tr;
        break;
      case DioExceptionType.connectionTimeout:
        message = 'exception_timeout'.tr;
        break;
      case DioExceptionType.receiveTimeout:
        message = 'exception_receive_timeout'.tr;
        break;
      case DioExceptionType.badResponse:
        message = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        break;
      case DioExceptionType.sendTimeout:
        message = 'exception_send_timeout'.tr;
        break;
      case DioExceptionType.unknown:
        if (dioError.message != null &&
            dioError.message!.contains("SocketException")) {
          message = 'exception_no_internet'.tr;
          break;
        }
        message = 'exception_unexpected'.tr;
        break;
      default:
        message = 'exception_something_wrong'.tr;
        break;
    }
  }

  late String message;

  @override
  String toString() => message;

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'status_bad'.tr;
      case 401:
        return 'status_unauthorized'.tr;
      case 403:
        return 'status_forbidden'.tr;
      case 404:
        return 'status_not_found'.tr;
      case 500:
        return 'status_server_error'.tr;
      case 502:
        return 'status_bad_gateway'.tr;
      default:
        return 'status_something_wrong'.tr;
    }
  }
}
