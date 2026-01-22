import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/modules/mover/mover_home/model/all_post_model.dart';
import 'dart:isolate';
import '../repository/mover_home_repositroy.dart';

class MoverHomeController extends GetxController {
  Rx<AllPostModel> moverHomeModel = AllPostModel(data: []).obs;
  RxBool isLoading = false.obs;
  RxList<PostData> postItems = <PostData>[].obs;

  /// Caching
  List<PostData>? _cachedPostItems;
  AllPostModel? _cachedAllPostModel;
  DateTime? _lastFetchTime;
  static const Duration cacheDuration = Duration(minutes: 5);

  @override
  void onInit() {
    super.onInit();
    getMoves();
  }

  /// This function processes data in isolate
  static Future<List<PostData>> _processMovesInIsolate(AllPostModel result) async {
    return await compute(_filterPostedMoves, result);
  }

  /// Static function that runs in isolate
  static List<PostData> _filterPostedMoves(AllPostModel model) {
    final List<PostData> filtered = [];
    for (var element in model.data ?? []) {
      if (element.status == "POSTED") {
        filtered.add(element);
      }
    }
    return filtered;
  }

  /// Check if cache is still valid
  bool _isCacheValid() {
    if (_lastFetchTime == null) return false;
    return DateTime.now().difference(_lastFetchTime!).inSeconds < cacheDuration.inSeconds;
  }

  /// Get moves with caching and isolate processing
  Future<void> getMoves({bool forceRefresh = false}) async {
    try {
      /// ✅ Use cache if available and not forced refresh
      if (!forceRefresh && _isCacheValid() && _cachedPostItems != null) {
        debugPrint("📦 Using cached data");
        postItems.assignAll(_cachedPostItems!);
        moverHomeModel.value = _cachedAllPostModel ?? AllPostModel(data: []);
        return;
      }

      isLoading.value = true;
      debugPrint("🔄 Fetching fresh data from API...");

      /// ✅ Fetch from API
      final result = await MoverHomeRepositroy.getMoves();
      moverHomeModel.value = result;

      /// ✅ Process in isolate to avoid janky UI
      debugPrint("⚙️ Processing data in isolate...");
      final processedItems = await _processMovesInIsolate(result);

      /// ✅ Update UI and cache
      postItems.clear();
      postItems.addAll(processedItems);

      /// Cache the results
      _cachedPostItems = List.from(processedItems);
      _cachedAllPostModel = result;
      _lastFetchTime = DateTime.now();

      debugPrint("✅ Total from API: ${result.data?.length}");
      debugPrint("✅ Posted only: ${postItems.length}");
      debugPrint("✅ Cache updated at: $_lastFetchTime");
    } catch (e) {
      debugPrint("❌ moves controller Error: $e");

      /// Fallback to cache on error
      if (_cachedPostItems != null) {
        debugPrint("⚠️ Using fallback cache due to error");
        postItems.assignAll(_cachedPostItems!);
      }
    } finally {
      isLoading.value = false;
    }
  }

  /// Clear cache manually
  void clearCache() {
    _cachedPostItems = null;
    _cachedAllPostModel = null;
    _lastFetchTime = null;
    debugPrint("🗑️ Cache cleared");
  }

  /// Get cache info for debugging
  Map<String, dynamic> getCacheInfo() {
    return {
      'cachedItemsCount': _cachedPostItems?.length ?? 0,
      'lastFetchTime': _lastFetchTime?.toString() ?? 'Never',
      'isCacheValid': _isCacheValid(),
      'cacheAge': _lastFetchTime != null
          ? DateTime.now().difference(_lastFetchTime!).inSeconds
          : null,
    };
  }
}