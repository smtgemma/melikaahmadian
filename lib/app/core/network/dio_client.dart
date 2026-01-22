import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:melikaahmadian/app/core/const/app_urls.dart';
import 'package:melikaahmadian/app/core/network/shared_prepharence_helper.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import '../../routes/app_pages.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;

  late Dio dio;
  bool _isRefreshing = false;
  final List<Function()> _retryQueue = [];

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppUrls.baseUrl,
        connectTimeout: const Duration(seconds: 120),
        receiveTimeout: const Duration(seconds: 120),
        headers: {"Accept": "application/json"},
      ),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        // 🔹 REQUEST
        onRequest: (options, handler) async {
          final token = await _getAccessToken();
          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }
          // ✅ LOG REQUEST
          debugPrint("➡️ REQUEST [${options.method}] => ${options.uri}");
          debugPrint("Headers: ${options.headers}");
          debugPrint("Body: ${options.data}");
          return handler.next(options);
        },
        // 🔹 RESPONSE
        onResponse: (response, handler) {
          // ✅ LOG RESPONSE
          debugPrint(
              "✅ RESPONSE [${response.statusCode}] => ${response.data}");
          return handler.next(response);
        },
        // 🔹 ERROR (401 HANDLER + LOGGING)
        onError: (DioException e, handler) async {
          // ✅ LOG ERROR
          debugPrint("❌ ERROR [${e.response?.statusCode}] => ${e.message}");
          if (e.type == DioExceptionType.connectionTimeout) {
            debugPrint("⏱ Connection Timeout – try again later");
          } else if (e.type == DioExceptionType.receiveTimeout) {
            debugPrint("⏱ Receive Timeout – server is too slow");
          }

          if (e.response?.statusCode == 401) {
            final requestOptions = e.requestOptions;
            // Prevent infinite loop
            if (requestOptions.extra["retry"] == true) {
              debugPrint("⚠️ Token refresh already tried, logout.");
              // ✅ FIX: Call logout safely
              await _performLogout();
              return handler.next(e);
            }

            requestOptions.extra["retry"] = true;

            if (!_isRefreshing) {
              _isRefreshing = true;
              try {
                debugPrint("🔄 Refreshing token...");
                final newToken = await _refreshToken();
                _isRefreshing = false;

                // Retry queued requests
                for (var retry in _retryQueue) {
                  retry();
                }
                _retryQueue.clear();

                // Retry current request
                requestOptions.headers["Authorization"] = "Bearer $newToken";
                final response = await dio.fetch(requestOptions);
                debugPrint("🔁 Request retried successfully");
                return handler.resolve(response);
              } catch (err) {
                debugPrint("🚫 Refresh token failed → Logout");
                _isRefreshing = false;
                _retryQueue.clear();
                // ✅ FIX: Call logout safely
                await _performLogout();
                return handler.reject(e);
              }
            } else {
              // Queue request while refresh is running
              debugPrint("⏳ Token refresh running → queue request");
              _retryQueue.add(() async {
                requestOptions.headers["Authorization"] =
                "Bearer ${await _getAccessToken()}";
                await dio.fetch(requestOptions);
              });
            }
          }
          return handler.next(e);
        },
      ),
    );
  }

  // ================= TOKEN METHODS =================
  Future<String?> _getAccessToken() async {
    final accessToken = await SharedPrefHelper.getString(
      SharedPrefHelper.accessToken,
    );
    return accessToken;
  }

  Future<String?> _getRefreshToken() async {
    final refreshToken = await SharedPrefHelper.getString(
      SharedPrefHelper.refreshToken,
    );
    return refreshToken;
  }

  Future<String> _refreshToken() async {
    final refreshToken = await _getRefreshToken();
    final response = await Dio().post(
      AppUrls.refreshToken,
      // data: {
      //   "refresh_token": refreshToken,
      // },
    );
    final newAccessToken = response.data["data"]["accessToken"];
    // Save new token
    await _saveAccessToken(newAccessToken);
    return newAccessToken;
  }

  Future<void> _saveAccessToken(String token) async {
    SharedPrefHelper.setString(SharedPrefHelper.accessToken, token);
  }

  // ✅ FIX: Safe logout that handles being called from any thread
  Future<void> _performLogout() async {
    debugPrint("🔒 Refresh failed → Logout user");
    await SharedPrefHelper.clear();

    // ✅ IMPORTANT: Ensure we're on the main thread before calling Get
    if (Get.isRegistered<GetxController>() || Get.key.currentContext != null) {
      // Safe to use Get - we have a context
      Get.offAllNamed(Routes.LOG_IN);
    } else {
      // Fallback: Schedule on main thread
      Future.microtask(() {
        try {
          Get.offAllNamed(Routes.LOG_IN);
        } catch (e) {
          debugPrint("⚠️ Could not navigate to login: $e");
          // At least we cleared the token
        }
      });
    }
  }

  // ================= API METHODS =================
  Future<Response> get(
      String path, {
        Map<String, dynamic>? queryParameters,
      }) async {
    return dio.get(path, queryParameters: queryParameters);
  }

  /// POST request
  Future<Response> post(
      String path, {
        dynamic data,
        ProgressCallback? onSendProgress,
        Duration? duration,
      }) async {
    return dio
        .post(path, data: data, onSendProgress: onSendProgress)
        .timeout(duration ?? Duration(seconds: 30));
  }

  /// PUT request
  Future<Response> put(String path, {dynamic data}) async {
    return dio.put(path, data: data);
  }

  /// PATCH request
  Future<Response> patch(String path, {dynamic data}) async {
    return dio.patch(path, data: data);
  }

  /// DELETE request
  Future<Response> delete(String path, {dynamic data}) async {
    return dio.delete(path, data: data);
  }

  /// File upload with progress
  Future<Response> uploadFile(
      String path,
      File file, {
        Map<String, dynamic>? extraData,
        ProgressCallback? onSendProgress,
      }) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      ...?extraData,
      "file": await MultipartFile.fromFile(file.path, filename: fileName),
    });
    return dio.post(path, data: formData, onSendProgress: onSendProgress);
  }

  /// File download with progress
  Future<void> downloadFile(
      String url,
      String savePath, {
        ProgressCallback? onReceiveProgress,
      }) async {
    await dio.download(url, savePath, onReceiveProgress: onReceiveProgress);
  }
}

// ============ HELPER FUNCTION FOR MULTIPART ============
Future<void> uploadMultipart() async {
  try {
    Dio dio = Dio();
    // 🔹 Image Lists
    List<File> imagesField1 = [
      File("path/image1.jpg"),
      File("path/image2.jpg"),
      File("path/image3.jpg"),
      File("path/image4.jpg"),
    ];
    List<File> imagesField3 = [
      File("path/image5.jpg"),
      File("path/image6.jpg"),
      File("path/image7.jpg"),
    ];
    File imageField4 = File("path/image8.jpg");
    File imageField5 = File("path/image9.jpg");

    // 🔹 Create FormData
    FormData formData = FormData.fromMap({
      // ✅ Field-1 → 4 images
      "field1_images": await Future.wait(
        imagesField1.map((file) => MultipartFile.fromFile(file.path)),
      ),
      // ✅ Field-2 → Text field
      "description": "This is my text data",
      // ✅ Field-3 → 3 images
      "field3_images": await Future.wait(
        imagesField3.map((file) => MultipartFile.fromFile(file.path)),
      ),
      // ✅ Field-4 → 1 image
      "profile_image": await MultipartFile.fromFile(imageField4.path),
      // ✅ Field-5 → 1 image
      "nid_image": await MultipartFile.fromFile(imageField5.path),
    });

    // 🚀 API Call
    Response response = await dio.post(
      "https://api.example.com/upload",
      data: formData,
      options: Options(headers: {"Content-Type": "multipart/form-data"}),
    );

    print("✅ Upload Success: ${response.data}");
  } catch (e) {
    print("❌ Upload Error: $e");
  }
}