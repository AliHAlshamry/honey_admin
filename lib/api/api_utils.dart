import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:honey_admin/api/end_points.dart';
import '../utils/constants/api_urls.dart';
import '../utils/constants/app_strings.dart';

class ApiUtils {
  ApiUtils();

  static late final Dio _dio;
  final String refreshTokenKey = AppStrings.refreshToken;
  final String accessToken = AppStrings.accessToken;
  final _box = GetStorage();

  final apiKey = dotenv.env['API_KEY'];

  void initializeDio() {
    _dio = _init();
  }

  Dio _init() {
    final dio = Dio(BaseOptions(baseUrl: ApiUrls.baseUrl));
    final accessToken = _box.read('accessToken');
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          // Add the access token to the request header
          options.headers['Authorization'] = "Bearer $accessToken";
          options.headers['x-api-key'] = apiKey;
          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          //print('onResponse');
          handler.next(response);
        },
        onError: (DioException e, ErrorInterceptorHandler handler) async {
          if (e.response?.statusCode == 401) {
            // If a 401 response is received, refresh the access token
            String newAccessToken = await refreshToken();

            // Update the request header with the new access token
            e.requestOptions.headers['Authorization'] =
            'Bearer $newAccessToken';
            e.requestOptions.headers['x-api-key'] = apiKey;

            // Repeat the request with the updated header
            return handler.resolve(await dio.fetch(e.requestOptions));
          }
          handler.next(e);
        },
      ),
    );
    return dio;
  }

  Future<String> refreshToken() async {
    
    try {
      // Retrieve the refresh token from storage
      String? token = _box.read('refreshToken');

      if (token == null) {
        throw Exception("Refresh token not found.");
      }

      // Create a new Dio instance without interceptors
      final dio = Dio(BaseOptions(baseUrl: 'https://api.honey-comb.store/oms'));//todo add refresh token url

      dio.options.headers['Authorization'] = 'Bearer $token';
      dio.options.headers['x-api-key'] = apiKey;
      final Response response = await dio.patch(EndPoints.refreshToken);
      saveUserData(
          response.data['token_access'], response.data['token_refresh']);
      debugPrint("Token Has been refreshed successfully...");
      return response.data['token_refresh'];
    } catch (error) {
      // Log the error for debugging
      debugPrint("Error refreshing token: $error");
      // Rethrow the error to be handled by the caller
      rethrow;
    }
  }

  Future<Response> post({
    required endpoint,
    dynamic data,
    String? token,
    Map<String, String>? queryParameters,
  }) async {
    final response = await _dio.post(
      endpoint,
      queryParameters: queryParameters,
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader: token,
        },
      ),
      data: data,
    );
    return response;
  }

  Future<Response> patch({
    required endpoint,
    dynamic body,
    String? token,
    Map<String, String>? queryParameters,
  }) async {
    final response = await _dio.patch(
      endpoint,
      queryParameters: queryParameters,
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader: token,
        },
      ),
      data: body,
    );
    return response;
  }

  Future<Response> get({
    required endpoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    final response = await _dio.get(
      endpoint,
      data: body,
      queryParameters: queryParameters,
    );

    return response;
  }

  Future<Response> delete({
    required endpoint,
    String? token,
    Map<String, String>? queryParameters,
  }) async {
    final response = await _dio.delete(
      endpoint,
      queryParameters: queryParameters,
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader: token,
        },
      ),
    );
    return response;
  }

  void saveUserData(String? token, String refreshToken) async {
    await _box.write(AppStrings.accessToken, token);
    await _box.write(AppStrings.refreshToken, refreshToken);
  }
}
