import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:reels_video/core/app_string.dart';
import 'package:reels_video/core/cache_helper.dart';

class DioHelper {
  DioHelper._();
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.sawalef.app/api/v1/',
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestBody: true,
          responseBody: true,
          requestHeader: true,
        ),
      );
    }
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
  }) async {
    dio.options.headers = _buildHeaders(lang);
    try {
      return await dio.get(url, queryParameters: query);
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }


  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
  }) async {
    dio.options.headers = _buildHeaders(lang);
    try {
      return await dio.post(url, queryParameters: query, data: data);
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }


  static Map<String, dynamic> _buildHeaders(String lang) {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'lang': lang,
      'Authorization': 'Bearer ${CacheHelper.getData(key: AppStrings.token) ?? ''}',
    };
  }

  static void _handleError(dynamic error) {
    if (error is DioError) {
      // Log or handle the DioError here
      print('DioError: ${error.message}');
      print('DioError Type: ${error.type}');
    } else {
      // Handle other types of errors
      print('Unexpected error: $error');
    }
  }
}