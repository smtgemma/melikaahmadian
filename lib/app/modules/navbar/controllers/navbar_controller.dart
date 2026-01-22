// ignore_for_file: unnecessary_overrides

import 'package:get/get.dart';
import 'package:melikaahmadian/app/modules/chat/views/chat_view.dart';
import 'package:melikaahmadian/app/modules/home/video_cmera/views/video_cmera_view.dart';
import 'package:melikaahmadian/app/modules/home/views/home_view.dart';
import 'package:melikaahmadian/app/modules/move/views/move_view.dart';
import 'package:melikaahmadian/app/modules/setting/views/setting_view.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';

import '../../mover/mover_chat/views/mover_chat_view.dart';

class NavbarController extends GetxController {
  RxInt selectedIndex = 0.obs;
  RxList item = [
    HomeView(),
    MoveView(),
    VideoCmeraView(),
    MoverChatView(),
    SettingView(),
  ].obs;
  @override
  void onInit() {
    super.onInit();
  }
}
