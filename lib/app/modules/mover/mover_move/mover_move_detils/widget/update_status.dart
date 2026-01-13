import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:melikaahmadian/app/core/const/app_colors.dart';
import 'package:melikaahmadian/app/core/widget/App_button.dart';
import 'package:melikaahmadian/app/modules/mover/mover_move/mover_move_detils/model/status_model.dart';
import 'package:melikaahmadian/app/modules/mover/mover_move/mover_move_detils/widget/secound_update.dart';
import 'package:melikaahmadian/app/modules/mover/mover_move/mover_move_detils/widget/third_update.dart';
import 'package:melikaahmadian/generated/assets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';
import '../controllers/mover_move_detils_controller.dart';
import 'first_update.dart';

class UpdateStatus extends StatelessWidget {
  const UpdateStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MoverMoveDetilsController());

    return Column(
      children: [
        const SizedBox(height: 10),

        Obx(() {
          return Column(
            children: List.generate(
              controller.status.length,
                  (index) {
                final data = controller.status[index];

                Widget child;

                if (data.sttus == 0) {
                  child = FirstUpdate(titel: data.statusString);
                } else if (data.sttus == 1) {
                  child = SecoundUpdate(titel: data.statusString);
                } else {
                  child = ThirdUpdate(titel: data.statusString);
                }

                return GestureDetector(
                  onTap: data.statusStatus == true ? null : ()  {
                    // previous completed
                    debugPrint(index.toString());
                    if (index > 0) {
                      controller.status[index - 1] =
                          controller.status[index - 1]
                              .copyWith(sttus: 2, statusStatus: true);
                        }
                    if (index == 4) {
                      controller.status[4] =
                          controller.status[4].copyWith(sttus: 2);
                      debugPrint("index 4 ${controller.status[4].sttus}");

                      debugPrint("yes i am ");
                    }

                    // current active
                    controller.status[index] =
                        controller.status[index]
                            .copyWith(sttus: 1);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: child,
                  ),
                );
              },
            ),
          );
        }),
      ],
    );
  }
}

