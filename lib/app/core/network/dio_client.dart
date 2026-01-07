import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:melikaahmadian/app/core/const/app_urls.dart';
import 'package:melikaahmadian/app/core/network/shared_prepharence_helper.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;

  late Dio dio;

  DioClient._internal() {

    dio = Dio(
      BaseOptions(
        baseUrl: AppUrls.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        responseType: ResponseType.json,
        headers: {
          "Accept": "application/json",
        },
      ),
    );

    // Add interceptors
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await SharedPrefHelper.getString(SharedPrefHelper.token);
          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }

          debugPrint("➡️ REQUEST [${options.method}] => ${options.uri}");
          debugPrint("Headers: ${options.headers}");
          debugPrint("Body: ${options.data}");

          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint("✅ RESPONSE [${response.statusCode}] => ${response.data}");
          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          debugPrint("❌ ERROR [${e.response?.statusCode}] => ${e.message}");

          // Retry on timeout
          if (e.type == DioExceptionType.connectionTimeout ||
              e.type == DioExceptionType.receiveTimeout) {
            debugPrint("⏱ Timeout – retrying...");
            try {
              final retryResponse = await dio.fetch(e.requestOptions);
              return handler.resolve(retryResponse);
            } catch (err) {
              return handler.next(err as DioException);
            }
          }

          // Handle Unauthorized
          if (e.response?.statusCode == 401) {
            debugPrint("Unauthorized – redirect to login");
          }

          return handler.next(e);
        },
      ),
    );
  }

  // Example: get token from storage
  Future<String?> _getToken() async {
    // return your saved token
    return null;
  }

  // GET request
  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    return dio.get(path, queryParameters: queryParameters);
  }

  // POST request
  Future<Response> post(String path,
      {dynamic data}) async {
    return dio.post(path, data: data);
  }

  // PUT request
  Future<Response> put(String path, {dynamic data}) async {
    return dio.put(path, data: data);
  }

  // Patch
  Future<Response> patch(String path, {dynamic data}) async {
    return dio.patch(path, data: data);
  }

  // DELETE request
  Future<Response> delete(String path, {dynamic data}) async {
    return dio.delete(path, data: data);
  }

  // File upload with progress
  Future<Response> uploadFile(String path, File file,
      {Map<String, dynamic>? extraData, Function(int, int)? onSendProgress}) async {
    String fileName = file.path.split('/').last;

    FormData formData = FormData.fromMap({
      ...?extraData,
      "file": await MultipartFile.fromFile(file.path, filename: fileName),
    });

    return dio.post(path, data: formData, onSendProgress: onSendProgress);
  }

  // File download with progress
  Future<void> downloadFile(String url, String savePath,
      {Function(int, int)? onReceiveProgress}) async {
    await dio.download(url, savePath, onReceiveProgress: onReceiveProgress);
  }
}