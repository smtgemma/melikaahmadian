import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:melikaahmadian/app/core/network/dio_client.dart';
import '../../../../core/const/app_urls.dart';
import '../model/get_furniture_model.dart';

class CustomeFurnitureRepository {
  /// Fetch furniture by category with proper error handling
  static Future<GetFurnitureModel> getFurnitureByCatagory(
      String category,
      ) async {
    try {
      // Build URL
      String url = category.isEmpty
          ? AppUrls.getFurnitureByCatagory
          : "${AppUrls.getFurnitureByCatagory}?category=$category";

      debugPrint("📍 Fetching furniture from: $url");

      // Make API request
      final response = await DioClient().get(url);

      // Parse response
      if (response.statusCode == 200 || response.statusCode == 201) {
        final model = GetFurnitureModel.fromJson(response.data);

        debugPrint(
          "✅ Successfully fetched ${model.data?.length ?? 0} furniture items",
        );

        return model;
      } else {
        throw Exception(
          "Failed to fetch furniture: ${response.statusCode}",
        );
      }
    } on DioException catch (e) {
      debugPrint("❌ Dio Error in getFurnitureByCatagory: ${e.message}");

      String errorMessage = _getErrorMessage(e);
      rethrow; Exception(errorMessage);
    } catch (e) {
      debugPrint("❌ Unexpected error in getFurnitureByCatagory: $e");
      rethrow;
    }
  }

  /// Parse error messages from Dio exceptions
  static String _getErrorMessage(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return "Connection timeout. Please check your internet connection.";

      case DioExceptionType.sendTimeout:
        return "Request timeout. Please try again.";

      case DioExceptionType.receiveTimeout:
        return "Response timeout. Please try again.";

      case DioExceptionType.badResponse:
        if (error.response?.statusCode == 404) {
          return "Furniture data not found.";
        } else if (error.response?.statusCode == 500) {
          return "Server error. Please try again later.";
        }
        return "Error: ${error.response?.statusCode}";

      case DioExceptionType.cancel:
        return "Request cancelled.";

      case DioExceptionType.unknown:
        if (error.error is SocketException) {
          return "No internet connection.";
        }
        return "Unknown error occurred.";

      default:
        return "Failed to load furniture. Please try again.";
    }
  }

  /// Validate furniture model
  static bool isValidFurnitureModel(GetFurnitureModel model) {
    return model.success == true &&
        model.data != null &&
        model.data!.isNotEmpty;
  }

  /// Get safe data list
  static List<Data>? getSafeDataList(GetFurnitureModel model) {
    try {
      if (isValidFurnitureModel(model)) {
        return model.data;
      }
      return [];
    } catch (e) {
      debugPrint("Error getting safe data list: $e");
      return [];
    }
  }
}

// // Alias for Data class from model
// typedef Data = GetFurnitureModel.Data;