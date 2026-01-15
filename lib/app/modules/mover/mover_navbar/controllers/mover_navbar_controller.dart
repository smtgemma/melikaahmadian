import 'package:get/get.dart';
import 'package:melikaahmadian/app/modules/mover/mover_chat/views/mover_chat_view.dart';
import 'package:melikaahmadian/app/modules/mover/mover_home/views/mover_home_view.dart';
import 'package:melikaahmadian/app/modules/mover/mover_move/views/mover_move_view.dart';

import '../../mover_profile/views/mover_profile_view.dart';

class MoverNavbarController extends GetxController {
  //TODO: Implement MoverNavbarController

  RxInt selectedIndex = 0.obs;
  RxList item = [
    MoverHomeView(),
    MoverMoveView(),
    MoverChatView(),
    MoverProfileView()
  ].obs ;
}
