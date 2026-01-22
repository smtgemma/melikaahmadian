import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/const/app_urls.dart';
import 'package:melikaahmadian/app/core/network/dio_client.dart';
import 'package:melikaahmadian/app/modules/mover/mover_profile/my_eraning/model/provider_earning_model.dart';

class MyEraningController extends GetxController {
  final _networkcaller = DioClient();

  final myEarning = Rxn<ProviderEarningsResponse>();
  final isLoading = false.obs;
  final isLoadingMore = false.obs;

  RxList<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ].obs;

  final monthIndex = 0.obs;
  final selectedMonth = "January".obs;

  // Pagination variables
  final currentPage = 1.obs;
  final limit = 1.obs;
  final hasMore = true.obs;
  final completedMovesList = <CompletedMove>[].obs;

  // ScrollController for pagination
  late ScrollController scrollController;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    getMyEarning();
  }

  // Scroll listener for pagination
  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (!isLoadingMore.value && hasMore.value) {
        loadMore();
      }
    }
  }

  // Initial API call
  Future<void> getMyEarning({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage.value = 1;
      completedMovesList.clear();
      hasMore.value = true;
    }

    isLoading.value = true;

    try {
      final response = await _networkcaller.get(
        AppUrls.getMyEarning(currentPage.value, limit.value, selectedMonth.value),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        myEarning.value = ProviderEarningsResponse.fromJson(data);

        if (myEarning.value?.data?.completedMoves != null) {
          completedMovesList.addAll(myEarning.value!.data!.completedMoves!);
        }

        // Check if there are more pages
        final meta = myEarning.value?.data?.meta;
        if (meta != null) {
          hasMore.value = currentPage.value < (meta.totalPage ?? 0);
        }

        print('Loaded ${completedMovesList.length} moves');
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      Get.snackbar(
        'Error',
        'Failed to load earnings',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Load more for pagination
  Future<void> loadMore() async {
    if (isLoadingMore.value || !hasMore.value) return;

    isLoadingMore.value = true;
    currentPage.value++;

    try {
      final response = await _networkcaller.get(
        AppUrls.getMyEarning(currentPage.value, limit.value, selectedMonth.value),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        final newData = ProviderEarningsResponse.fromJson(data);

        if (newData.data?.completedMoves != null) {
          completedMovesList.addAll(newData.data!.completedMoves!);
        }

        // Check if there are more pages
        final meta = newData.data?.meta;
        if (meta != null) {
          hasMore.value = currentPage.value < (meta.totalPage ?? 0);
        }

        print('Total moves: ${completedMovesList.length}');
      }
    } catch (e) {
      currentPage.value--; // Revert page number on error
      print('Load more error: ${e.toString()}');
    } finally {
      isLoadingMore.value = false;
    }
  }

  // Change month and reload data
  void changeMonth(int index, String month) {
    monthIndex.value = index;
    selectedMonth.value = month;
    currentPage.value = 1;
    completedMovesList.clear();
    hasMore.value = true;
    getMyEarning();
  }

  // Refresh data
  Future<void> refreshData() async {
    await getMyEarning(isRefresh: true);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}