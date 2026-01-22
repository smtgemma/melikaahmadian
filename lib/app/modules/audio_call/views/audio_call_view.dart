import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/audio_call_controller.dart';

class AudioCallView extends GetView<AudioCallController> {
  const AudioCallView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent back button from closing the call
        return false;
      },
      child: Scaffold(
        body: Obx(() {
          return Container(
            decoration: BoxDecoration(color: Colors.white),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Top Section - Call Status
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          controller.localJoined.value
                              ? "Connected"
                              : "Connecting...",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (controller.localJoined.value)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.shade400,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  "Call Active",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          const SizedBox.shrink(),
                      ],
                    ),
                  ),

                  // Middle Section - User Status
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.2),
                              border: Border.all(
                                color: controller.remoteUid.value != null
                                    ? Colors.green.shade400
                                    : Colors.green,
                                width: 3,
                              ),
                            ),
                            child: ClipOval(
                              child: Image.network(
                                controller.profileImage.value,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.person,
                                    size: 60,
                                    color: Colors.white70,
                                  );
                                },
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return const Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      );
                                    },
                              ),
                            ),
                          ),

                          Text(
                            controller.userName.value,
                            style: TextStyle(
                              fontSize: 28,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 24),
                          Text(
                            controller.remoteUid.value != null
                                ? "Call in Progress"
                                : "Waiting for caller...",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (controller.remoteUid.value != null)
                            Text(
                              "Remote UID: ${controller.remoteUid.value}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withOpacity(0.7),
                              ),
                            ),
                          const SizedBox(height: 20),
                          // Call duration timer - Only when remote user joined
                          if (controller.remoteUid.value != null &&
                              controller.localJoined.value)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.timer,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 6),
                                  Obx(
                                    () => Text(
                                      controller.getFormattedDuration(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                  // Bottom Section - Controls
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 40,
                    ),
                    child: Column(
                      children: [
                        // Three buttons in a row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Mute/Unmute Button
                            _ControlButton(
                              onPressed: controller.toggleMute,
                              icon: Obx(
                                () => Icon(
                                  controller.muted.value
                                      ? Icons.mic_off
                                      : Icons.mic,
                                  color: Colors.black,
                                  size: 28,
                                ),
                              ),
                              label: "Mute",
                              backgroundColor: controller.muted.value
                                  ? Colors.white
                                  : Color(0xffF5F5F5),
                            ),

                            // Speaker Button
                            _ControlButton(
                              onPressed: controller.toggleSpeaker,
                              icon: Obx(
                                () => Icon(
                                  controller.speakerOn.value
                                      ? Icons.speaker
                                      : Icons.speaker_phone,
                                  color: Colors.black,
                                  size: 28,
                                ),
                              ),
                              label: "Speaker",
                              backgroundColor: controller.speakerOn.value
                                  ? Colors.white
                                  : Color(0xffF5F5F5),
                            ),

                            // End Call Button
                            _ControlButton(
                              onPressed: () {
                                controller.leave();
                                Get.back();
                              },
                              icon: const Icon(
                                Icons.call_end,
                                color: Colors.white,
                                size: 28,
                              ),
                              label: "End",
                              backgroundColor: Colors.red.shade500,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

// Custom control button widget
class _ControlButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;
  final String label;
  final dynamic backgroundColor;

  const _ControlButton({
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              customBorder: const CircleBorder(),
              child: Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: backgroundColor is Obx
                      ? backgroundColor
                      : backgroundColor,
                ),
                child: Center(child: icon),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
