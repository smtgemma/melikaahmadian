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
import '../rpository/mover_move_repository.dart';
import 'first_update.dart';

class UpdateStatus extends StatelessWidget {
  String? posid ;
   UpdateStatus({super.key,this.posid});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MoverMoveDetilsController());

    return SingleChildScrollView(
      child: Column(
        children: [
          //const SizedBox(height: 10),

          Obx(() {
            if (controller.statusmodel.value.data?.isCompleted == true){
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.uiStatus.length,
                  itemBuilder: (context, index) {
                 // final data = controller.uiStatus;
                  return Padding(
                    padding:  EdgeInsets.only(bottom: 08),
                    child: ThirdUpdate(
                        titel: controller.uiStatus[index],
                    ),
                  );
                },
              );
            } else {
              final completedCount = controller.statusmodel.value.data?.completedMoveStatuses?.length ?? 0;

              final itemCount = completedCount + 1;

              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  final data = controller.uiStatus;
                  final isLast = index == itemCount - 1;
                  final postStatus = (controller.uploadeStatus[index] ) ;



                  if (isLast) {
                    return Padding(
                      padding:  EdgeInsets.only(bottom: 8),
                      child: GestureDetector(
                        onTap: () {
                          print( postStatus);
                          print("Last item clicked");
                          MoverMoveDetailsRepository.moveStatusChange(id: controller.postId,status: postStatus);

                        },
                        child: SecoundUpdate(
                          titel: data[index],
                        ),
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: ThirdUpdate(
                      titel: data[index],
                    ),
                  );
                },
              );


            }
          }),




          // Obx(() {
          //   return Column(
          //     children: List.generate(
          //       controller.status.length,
          //           (index) {
          //         final data = controller.status[index];
          //
          //         Widget child;
          //
          //         if (data.sttus == 0) {
          //           child = FirstUpdate(titel: data.statusString);
          //         } else if (data.sttus == 1) {
          //           child = SecoundUpdate(titel: data.statusString);
          //         } else {
          //           child = ThirdUpdate(titel: data.statusString);
          //         }
          //
          //         return GestureDetector(
          //           onTap: data.statusStatus == true ? null : ()  {
          //             // previous completed
          //             debugPrint(index.toString());
          //             if (index > 0) {
          //               controller.status[index - 1] =
          //                   controller.status[index - 1]
          //                       .copyWith(sttus: 2, statusStatus: true);
          //                 }
          //             if (index == 4) {
          //               controller.status[4] =
          //                   controller.status[4].copyWith(sttus: 2);
          //               debugPrint("index 4 ${controller.status[4].sttus}");
          //
          //               debugPrint("yes i am ");
          //             }
          //
          //             // current active
          //             controller.status[index] =
          //                 controller.status[index]
          //                     .copyWith(sttus: 1);
          //           },
          //           child: Padding(
          //             padding: const EdgeInsets.only(bottom: 10),
          //             child: child,
          //           ),
          //         );
          //       },
          //     ),
          //   );
          // }),
        ],
      ),
    );
  }
}

