import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:melikaahmadian/app/modules/move/offer_review/model/details_model.dart';
import 'package:melikaahmadian/app/modules/move/offer_review/model/offer_model.dart';

import '../../../../core/const/app_urls.dart';
import '../../../../core/network/dio_client.dart';

class OfferReviewRepository {


  static Future<OfferModel> getOffer({String? pram}) async {
    try {
      var response = await DioClient().get(AppUrls.getOfferForSpecificPost(pram));
      if(response.statusCode == 200){
        return OfferModel.fromJson(response.data);
      }else{
        throw Exception("Failed to load posts");

      }
    }on DioError catch (e) {
      debugPrint("⚠️ API Error: ${e.response?.statusCode}");
      debugPrint("⚠️ API Error Data: ${e.response?.data}");
      debugPrint("⚠️ API Error Message: ${e.message}");
      return OfferModel();
    } catch (e) {

      debugPrint("⚠️ Unknown Error: $e");
      return OfferModel();
    }
  }

  static Future<DetailsModel> getDetails({String? pram}) async {
    try {
      var response = await DioClient().get(AppUrls.getSinglePost(pram));
      if(response.statusCode == 200){
        return DetailsModel.fromJson(response.data);
      }else{
        throw Exception("Failed to load posts");

      }
    }on DioError catch (e) {
      debugPrint("⚠️ API Error: ${e.response?.statusCode}");
      debugPrint("⚠️ API Error Data: ${e.response?.data}");
      debugPrint("⚠️ API Error Message: ${e.message}");
      return DetailsModel();
    } catch (e) {

      debugPrint("⚠️ Unknown Error: $e");
      return DetailsModel();
    }
  }



}