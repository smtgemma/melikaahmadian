import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/model/product_model.dart';

import '../../../../../generated/assets.dart';

class CustomFurnitureController extends GetxController {
  //TODO: Implement CustomFurnitureController
   //catagory
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
  RxList<ProductModel> addProduct =<ProductModel>[].obs ;


  //
  RxList moverCatagory  = [ "Ongoing","All Moves","Posted","Completed","Cancelled"].obs;
  RxList moverMoveCatagory  = [ "Offered","All Moves","Ongoing","Completed","Cancelled"].obs;


  RxList<ProductModel> allItem =[
    ProductModel(titel: "Oven",iconPath: Assets.iconsOven,count: 0),
    ProductModel(titel: "Frizz",iconPath: Assets.iconsFrizz,count: 0),
    ProductModel(titel: "Miror",iconPath: Assets.iconsMiror,count: 0),
    ProductModel(titel: "Self Book",iconPath: Assets.iconsSelfBook,count: 0),
    ProductModel(titel: "Almari",iconPath: Assets.iconsAlmari,count: 0),
    ProductModel(titel: "Ac",iconPath: Assets.iconsAc,count: 0),
    ProductModel(titel: "Side table",iconPath: Assets.iconsSidetable,count: 0),
    ProductModel(titel: "Tv",iconPath: Assets.iconsTv,count: 0),
    ProductModel(titel: "Bed",iconPath: Assets.iconsBed,count: 0),
    ProductModel(titel: "Self Book",iconPath: Assets.iconsSelfBook,count: 0),
    ProductModel(titel: "Tv Stand",iconPath: Assets.iconsTvstand,count: 0),
    ProductModel(titel: "Coffe Table",iconPath: Assets.iconsCoffetable,count: 0),
  ].obs ;

  RxList<ProductModel> drawingRoom =[
    ProductModel(titel: "Oven",iconPath: Assets.iconsOven,count: 0),
    ProductModel(titel: "Frizz",iconPath: Assets.iconsFrizz,count: 0),
    ProductModel(titel: "Bed",iconPath: Assets.iconsBed,count: 0),
    ProductModel(titel: "Self Book",iconPath: Assets.iconsSelfBook,count: 0),
    ProductModel(titel: "Tv Stand",iconPath: Assets.iconsTvstand,count: 0),
    ProductModel(titel: "Coffe Table",iconPath: Assets.iconsCoffetable,count: 0),
  ].obs ;

  RxList<ProductModel> bed_room =[

    ProductModel(titel: "Almari",iconPath: Assets.iconsAlmari,count: 0),
    ProductModel(titel: "Ac",iconPath: Assets.iconsAc,count: 0),
    ProductModel(titel: "Side table",iconPath: Assets.iconsSidetable,count: 0),
    ProductModel(titel: "Tv",iconPath: Assets.iconsTv,count: 0),
    ProductModel(titel: "Bed",iconPath: Assets.iconsBed,count: 0),
    ProductModel(titel: "Self Book",iconPath: Assets.iconsSelfBook,count: 0),
    ProductModel(titel: "Tv Stand",iconPath: Assets.iconsTvstand,count: 0),
    ProductModel(titel: "Coffe Table",iconPath: Assets.iconsCoffetable,count: 0),
  ].obs ;

  RxList<ProductModel> dining_room =[
    ProductModel(titel: "Oven",iconPath: Assets.iconsOven,count: 0),
    ProductModel(titel: "Frizz",iconPath: Assets.iconsFrizz,count: 0),
    ProductModel(titel: "Miror",iconPath: Assets.iconsMiror,count: 0),
    ProductModel(titel: "Self Book",iconPath: Assets.iconsSelfBook,count: 0),
    ProductModel(titel: "Almari",iconPath: Assets.iconsAlmari,count: 0),
    ProductModel(titel: "Ac",iconPath: Assets.iconsAc,count: 0),
    ProductModel(titel: "Side table",iconPath: Assets.iconsSidetable,count: 0),
    ProductModel(titel: "Tv",iconPath: Assets.iconsTv,count: 0),

  ].obs ;
  RxList<ProductModel> kitcen =[
    ProductModel(titel: "Oven",iconPath: Assets.iconsOven,count: 0),
    ProductModel(titel: "Frizz",iconPath: Assets.iconsFrizz,count: 0),
    ProductModel(titel: "Tv Stand",iconPath: Assets.iconsTvstand,count: 0),
    ProductModel(titel: "Coffe Table",iconPath: Assets.iconsCoffetable,count: 0),
  ].obs ;
  RxList<ProductModel> washroom =[
    ProductModel(titel: "Oven",iconPath: Assets.iconsOven,count: 0),
    ProductModel(titel: "Frizz",iconPath: Assets.iconsFrizz,count: 0),
    ProductModel(titel: "Miror",iconPath: Assets.iconsMiror,count: 0),


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

  void toggleProduct(ProductModel product) {
    if (addProduct.any((e) => e.titel == product.titel)) {
      addProduct.removeWhere((e) => e.titel == product.titel);
    } else {
      addProduct.add(product);
    }
  }


}
