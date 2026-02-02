import 'dart:async';
import 'dart:convert';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/network/shared_prepharence_helper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

class AudioCallController extends GetxController {
  late RtcEngine _engine;
  var localJoined = false.obs;
  var remoteUid = RxnInt();
  var muted = false.obs;
  var speakerOn = true.obs;
  var isInitializing = false.obs;
  var callDuration = 0.obs;
  Timer? _callTimer;

  final String staticUserId = "69636e0c83df709e29a42015";
  final String staticUserId2 = "6965bb067e75ba66656664bb";
  final otherUserId = ''.obs;

  String? appId;
  String? token;
  String? channelName;
  int? uid;

  final accessToken = ''.obs;
  final myUserId = ''.obs;
  final profileImage = ''.obs;
  final userName = ''.obs;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments as Map<String, dynamic>?;

    if (args != null) {
      otherUserId.value = args['userId'] ?? '';
      profileImage.value = args['image'] ?? '';
      userName.value = args['name'] ?? '';
      print('profile image is ${profileImage.value}');
    }

    debugPrint("🎧 AudioCallController initialized");
    initCall();
  }

  Future<void> getAccessToken() async {
    accessToken.value =
        await SharedPrefHelper.getString(SharedPrefHelper.accessToken) ?? '';
    myUserId.value =
        await SharedPrefHelper.getString(SharedPrefHelper.userId) ?? '';
    debugPrint("👤 Logged user: ${myUserId.value}");

    // Auto select other user
    if (myUserId.value == staticUserId) {
      otherUserId.value = staticUserId2;
      debugPrint('👉 other user: ${otherUserId.value}');
    } else {
      otherUserId.value = staticUserId;
      debugPrint('👉 other user Id: ${otherUserId.value}');
    }
    debugPrint("👉 Other user will be: ${otherUserId.value}");
  }

  Future<void> _fetchAgoraToken() async {
    final url =
        "https://api.ablefellasmoving.com/agora/generate-token?otherUserId=${otherUserId.value}";
    debugPrint("🌍 GET $url");
    debugPrint("🧾 Authorization Bearer token sending...");

    try {
      final response = await http
          .get(
            Uri.parse(url),
            headers: {
              "Authorization": "Bearer ${accessToken.value}",
              "Content-Type": "application/json",
            },
          )
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              throw Exception('Token fetch timeout');
            },
          );

      debugPrint("📥 API Status Code: ${response.statusCode}");
      debugPrint("📥 Raw Response: ${response.body}");

      final json = jsonDecode(response.body);
      if (json["success"] == true) {
        debugPrint("✅ Agora token API success");
        appId = json["data"]["appId"];
        token = json["data"]["token"];
        channelName = json["data"]["channelName"];
        uid = json["data"]["uid"];
        debugPrint("🆔 App ID: $appId");
        debugPrint("📡 Channel: $channelName");
        debugPrint("👤 UID: $uid");
      } else {
        throw Exception("❌ Agora API error: ${json["message"]}");
      }
    } catch (e) {
      debugPrint("🔥 Exception while fetching token: $e");
      rethrow;
    }
  }

  // Start call timer
  void _startCallTimer() {
    // Only start if not already running
    if (_callTimer != null && _callTimer!.isActive) {
      return;
    }
    callDuration.value = 0;
    _callTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      callDuration.value++;
    });
    debugPrint("⏱ Call timer started");
  }

  // Format duration to MM:SS
  String getFormattedDuration() {
    final minutes = (callDuration.value ~/ 60).toString().padLeft(2, '0');
    final seconds = (callDuration.value % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  Future<void> initCall() async {
    // Prevent multiple initializations
    if (isInitializing.value) {
      debugPrint("⚠️ Already initializing, skipping...");
      return;
    }

    try {
      isInitializing.value = true;

      debugPrint("🎙 Requesting microphone permission...");
      var micStatus = await Permission.microphone.request();
      debugPrint("🎙 Microphone permission status: $micStatus");

      if (!micStatus.isGranted) {
        throw Exception("Microphone permission denied");
      }

      await getAccessToken();

      debugPrint("🌐 Fetching Agora token from server...");
      await _fetchAgoraToken();

      // Validate token data
      if (appId == null ||
          token == null ||
          channelName == null ||
          uid == null) {
        throw Exception("Invalid token data received");
      }

      debugPrint("⚙️ Initializing Agora engine...");
      _engine = createAgoraRtcEngine();

      await _engine.initialize(
        RtcEngineContext(
          appId: appId!,
          channelProfile: ChannelProfileType.channelProfileCommunication,
        ),
      );
      debugPrint("⚙️ Agora engine initialized");

      _engine.registerEventHandler(
        RtcEngineEventHandler(
          onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
            debugPrint("✅ Joined channel successfully");
            debugPrint("👤 Local UID: ${connection.localUid}");
            debugPrint("⏱ Time elapsed: $elapsed ms");
            localJoined.value = true;
            _startCallTimer(); // Start timer when successfully joined
          },
          onUserJoined: (RtcConnection connection, int rUid, int elapsed) {
            debugPrint("👥 Remote user joined: $rUid");
            debugPrint("⏱ Time elapsed: $elapsed ms");
            remoteUid.value = rUid;
            // Reset and start timer when remote user joins
            _startCallTimer();
          },
          onUserOffline: (RtcConnection connection, int rUid, reason) {
            debugPrint("🚪 Remote user left: $rUid");
            debugPrint("❓ Reason: $reason");
            remoteUid.value = null;

            // Auto-disconnect when remote user leaves
            debugPrint("🔴 Remote user disconnected, ending call...");
            leave();
            Get.back(); // Go back to previous screen
            Get.snackbar(
              "Call Ended",
              "The other user has ended the call",
              duration: const Duration(seconds: 3),
            );
          },
          onError: (ErrorCodeType code, String msg) {
            debugPrint("⛔ Agora error: $code - $msg");
          },
        ),
      );

      await _engine.enableAudio();
      await _engine.disableVideo();
      debugPrint("🔊 Audio enabled, video disabled");

      debugPrint("🚀 Joining Agora channel...");
      debugPrint("📡 Channel: $channelName");
      debugPrint("🔑 Token: ${token?.substring(0, 20)}...");

      await _engine.joinChannel(
        token: token ?? '',
        channelId: channelName!,
        uid: uid!,
        options: const ChannelMediaOptions(),
      );
    } catch (e) {
      debugPrint("🔥 Error during initialization: $e");
      // Show error dialog to user
      Get.snackbar(
        "Error",
        "Failed to initialize call: $e",
        duration: const Duration(seconds: 5),
      );
      rethrow;
    } finally {
      isInitializing.value = false;
    }
  }

  void toggleMute() {
    muted.value = !muted.value;
    _engine.muteLocalAudioStream(muted.value);
    debugPrint(muted.value ? "🔇 Mic muted" : "🎙 Mic unmuted");
  }

  void toggleSpeaker() {
    speakerOn.value = !speakerOn.value;
    _engine.setEnableSpeakerphone(speakerOn.value);
    debugPrint(speakerOn.value ? "🔊 Speaker on" : "📱 Speaker off");
  }

  Future<void> leave() async {
    try {
      debugPrint("🚪 Leaving channel...");

      // Cancel timer
      _callTimer?.cancel();
      callDuration.value = 0;

      await _engine.leaveChannel();
      await _engine.release();
      debugPrint("🛑 Engine released");
      localJoined.value = false;
      remoteUid.value = null;
      muted.value = false;
      speakerOn.value = true;
    } catch (e) {
      debugPrint("🔥 Error while leaving: $e");
    }
  }

  @override
  void onClose() {
    debugPrint("🧹 Controller disposed — cleaning up");
    _callTimer?.cancel();
    leave();
    super.onClose();
  }
}
