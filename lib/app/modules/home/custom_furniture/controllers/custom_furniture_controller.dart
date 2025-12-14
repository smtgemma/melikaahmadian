import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/model/product_model.dart';

import '../../../../../generated/assets.dart';

class CustomFurnitureController extends GetxController {
  //TODO: Implement CustomFurnitureController

  RxList catagory = [
    "All",
    "Drawing Room",
    "Bed Room",
    "Dining Room",
    "Kitchen",
    "Washroom",
  ].obs ;
  RxList commersialCatagory  = [ "Restaurant","Bakery","Factory"].obs;

  RxInt catagoryIndex = 0.obs ;
  final selectedCatagory = "".obs;

  // item list
  RxInt itemIndex = 0.obs ;
  final selectedItem = "".obs;

  RxList<ProductModel> allItem =[
    ProductModel(titel: "Oven",iconPath: Assets.iconsOven),
    ProductModel(titel: "Frizz",iconPath: Assets.iconsFrizz),
    ProductModel(titel: "Miror",iconPath: Assets.iconsMiror),
    ProductModel(titel: "Self Book",iconPath: Assets.iconsSelfBook),
    ProductModel(titel: "Almari",iconPath: Assets.iconsAlmari),
    ProductModel(titel: "Ac",iconPath: Assets.iconsAc),
    ProductModel(titel: "Side table",iconPath: Assets.iconsSidetable),
    ProductModel(titel: "Tv",iconPath: Assets.iconsTv),
    ProductModel(titel: "Bed",iconPath: Assets.iconsBed),
    ProductModel(titel: "Self Book",iconPath: Assets.iconsSelfBook),
    ProductModel(titel: "Tv Stand",iconPath: Assets.iconsTvstand),
    ProductModel(titel: "Coffe Table",iconPath: Assets.iconsCoffetable),
  ].obs ;

  RxList<ProductModel> drawingRoom =[
    ProductModel(titel: "Oven",iconPath: Assets.iconsOven),
    ProductModel(titel: "Frizz",iconPath: Assets.iconsFrizz),
    ProductModel(titel: "Bed",iconPath: Assets.iconsBed),
    ProductModel(titel: "Self Book",iconPath: Assets.iconsSelfBook),
    ProductModel(titel: "Tv Stand",iconPath: Assets.iconsTvstand),
    ProductModel(titel: "Coffe Table",iconPath: Assets.iconsCoffetable),
  ].obs ;

  RxList<ProductModel> bed_room =[

    ProductModel(titel: "Almari",iconPath: Assets.iconsAlmari),
    ProductModel(titel: "Ac",iconPath: Assets.iconsAc),
    ProductModel(titel: "Side table",iconPath: Assets.iconsSidetable),
    ProductModel(titel: "Tv",iconPath: Assets.iconsTv),
    ProductModel(titel: "Bed",iconPath: Assets.iconsBed),
    ProductModel(titel: "Self Book",iconPath: Assets.iconsSelfBook),
    ProductModel(titel: "Tv Stand",iconPath: Assets.iconsTvstand),
    ProductModel(titel: "Coffe Table",iconPath: Assets.iconsCoffetable),
  ].obs ;

  RxList<ProductModel> dining_room =[
    ProductModel(titel: "Oven",iconPath: Assets.iconsOven),
    ProductModel(titel: "Frizz",iconPath: Assets.iconsFrizz),
    ProductModel(titel: "Miror",iconPath: Assets.iconsMiror),
    ProductModel(titel: "Self Book",iconPath: Assets.iconsSelfBook),
    ProductModel(titel: "Almari",iconPath: Assets.iconsAlmari),
    ProductModel(titel: "Ac",iconPath: Assets.iconsAc),
    ProductModel(titel: "Side table",iconPath: Assets.iconsSidetable),
    ProductModel(titel: "Tv",iconPath: Assets.iconsTv),

  ].obs ;
  RxList<ProductModel> kitcen =[
    ProductModel(titel: "Oven",iconPath: Assets.iconsOven),
    ProductModel(titel: "Frizz",iconPath: Assets.iconsFrizz),
    ProductModel(titel: "Tv Stand",iconPath: Assets.iconsTvstand),
    ProductModel(titel: "Coffe Table",iconPath: Assets.iconsCoffetable),
  ].obs ;
  RxList<ProductModel> washroom =[
    ProductModel(titel: "Oven",iconPath: Assets.iconsOven),
    ProductModel(titel: "Frizz",iconPath: Assets.iconsFrizz),
    ProductModel(titel: "Miror",iconPath: Assets.iconsMiror),


  ].obs ;




  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }


}
