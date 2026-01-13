import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:melikaahmadian/app/core/const/app_urls.dart';
import 'package:melikaahmadian/app/core/network/dio_client.dart';
import 'package:melikaahmadian/app/modules/mover/mover_chat/model/chat_list_model.dart'
    show ConversationResponse;

class MoverChatController extends GetxController {
  final messageChatController = TextEditingController();
  final _networkCaller = DioClient();

  // Chat list from API
  final chatListModel = Rxn<ConversationResponse>();

  // WebSocket related
  late IO.Socket socket;
  final messages = <Map<String, dynamic>>[].obs;
  final onlineUsers = <String>[].obs;
  final isTyping = false.obs;
  final currentConversationId = Rxn<String>();
  final isSocketConnected = false.obs;
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    log('🟢 MoverChatController onInit called');
    getAllChatList();
    _initializeSocket();
  }

  // Initialize WebSocket connection
  void _initializeSocket() {
    try {
      log('🔹 Starting WebSocket initialization...');

      // Try ws:// first (without SSL) since wss:// is giving handshake errors
      // Change back to wss:// once server has valid SSL certificate
      socket = IO.io(
        'ws://206.162.244.175:6008',
        IO.OptionBuilder()
            .setTransports(['websocket', 'polling'])
            .disableAutoConnect()
            .setReconnectionDelay(1000)
            .setReconnectionDelayMax(5000)
            .setReconnectionAttempts(10)
            .build(),
      );

      // Connection established
      socket.onConnect((_) {
        log('✅ WebSocket Connected!');
        isSocketConnected.value = true;
        _emitUserOnline();
        getOnlineUsers();
      });

      // Disconnection
      socket.onDisconnect((_) {
        log('❌ WebSocket Disconnected');
        isSocketConnected.value = false;
      });

      // Connection error
      socket.onError((error) {
        log('⚠️ WebSocket Error: $error');
        isSocketConnected.value = false;
      });

      // Connect error
      socket.onConnectError((data) {
        log('⚠️ WebSocket Connect Error: $data');
        isSocketConnected.value = false;
      });

      // Setup event listeners
      _setupEventListeners();

      // Connect to socket
      log('🔹 Calling socket.connect()...');
      socket.connect();

    } catch (e, s) {
      log('❌ Error initializing socket: $e', stackTrace: s);
    }
  }

  void _setupEventListeners() {
    // User online event
    socket.on('user_online', (data) {
      log('👤 User online: $data');
      if (data is String && !onlineUsers.contains(data)) {
        onlineUsers.add(data);
      }
    });

    // Get online users list
    socket.on('get_online_users', (data) {
      log('👥 Online users received: $data');
      if (data is List) {
        onlineUsers.value = List<String>.from(data);
      }
    });

    // New message received
    socket.on('new_message', (data) {
      log('💬 New message received: $data');
      if (data is Map<String, dynamic>) {
        messages.add(data);
      }
    });

    // Typing indicators
    socket.on('typing', (data) {
      log('⌨️ User typing: $data');
      isTyping.value = true;
    });

    socket.on('stop_typing', (data) {
      log('🛑 User stopped typing: $data');
      isTyping.value = false;
    });

    // Chat room events
    socket.on('join_chat', (data) {
      log('🚪 User joined chat: $data');
    });

    socket.on('leave_chat', (data) {
      log('🚪 User left chat: $data');
    });
  }

  void _emitUserOnline() {
    try {
      socket.emit('user_online', {
        'userId': 'current_user_id', // Replace with actual user ID
        'timestamp': DateTime.now().toIso8601String(),
      });
      log('📤 Emitted user_online event');
    } catch (e) {
      log('❌ Error emitting user_online: $e');
    }
  }

  // Fetch all conversations from API
  Future<void> getAllChatList() async {
    try {
      log('➡️ Calling getAllChat API: ${AppUrls.getAllChat}');
      final response = await _networkCaller.get(AppUrls.getAllChat);
      log('📩 Response received with status: ${response.statusCode}');
      log('📝 Raw response data: ${response.data}');

      if (response.statusCode == 200) {
        final data = response.data;
        chatListModel.value = ConversationResponse.fromJson(data);
        log('✅ Chat list parsed successfully with '
            '${chatListModel.value?.data.length} conversations');
      } else {
        log('⚠️ API call failed with status: ${response.statusCode}');
      }
    } catch (e, s) {
      log('❌ Error in getAllChatList(): $e', stackTrace: s);
    }
  }

  // Join a specific conversation
  void joinConversation(String conversationId) {
    if (!isSocketConnected.value) {
      log('⚠️ Socket not connected, attempting to reconnect...');
      socket.connect();
      Future.delayed(const Duration(milliseconds: 500), () {
        _joinConversationInternal(conversationId);
      });
    } else {
      _joinConversationInternal(conversationId);
    }
  }

  void _joinConversationInternal(String conversationId) {
    try {
      currentConversationId.value = conversationId;
      socket.emit('join_chat', {'conversationId': conversationId});
      messages.clear();
      log('📍 Joined conversation: $conversationId');
    } catch (e) {
      log('❌ Error joining conversation: $e');
    }
  }

  // Leave current conversation
  void leaveConversation() {
    if (currentConversationId.value != null) {
      try {
        socket.emit('leave_chat', {
          'conversationId': currentConversationId.value
        });
        log('📍 Left conversation: ${currentConversationId.value}');
      } catch (e) {
        log('❌ Error leaving conversation: $e');
      }
    }
    currentConversationId.value = null;
    messages.clear();
  }

  // Send message via WebSocket
  void sendMessage(String text, {String? image, String? file}) {
    if (text.trim().isEmpty || currentConversationId.value == null) {
      log('⚠️ Cannot send message: empty text or no conversation');
      return;
    }

    if (!isSocketConnected.value) {
      log('⚠️ Socket not connected');
      return;
    }

    try {
      final messageData = {
        'conversationId': currentConversationId.value,
        'text': text.trim(),
        'timestamp': DateTime.now().toIso8601String(),
        if (image != null) 'image': image,
        if (file != null) 'file': file,
      };

      socket.emit('send_message', messageData);
      messageChatController.clear();
      log('📨 Message sent to ${currentConversationId.value}');
    } catch (e) {
      log('❌ Error sending message: $e');
    }
  }

  // Set typing status
  void setTyping(bool typing) {
    if (currentConversationId.value == null || !isSocketConnected.value) {
      return;
    }

    try {
      if (typing) {
        socket.emit('typing', {
          'conversationId': currentConversationId.value
        });
      } else {
        socket.emit('stop_typing', {
          'conversationId': currentConversationId.value
        });
      }
    } catch (e) {
      log('❌ Error setting typing status: $e');
    }
  }

  // Get online users
  void getOnlineUsers() {
    try {
      socket.emit('get_online_users');
    } catch (e) {
      log('❌ Error getting online users: $e');
    }
  }

  // Refresh chat list
  Future<void> refreshChatList() async {
    await getAllChatList();
  }

  // Manual socket reconnect
  void reconnectSocket() {
    log('🔄 Attempting to reconnect socket...');
    if (!socket.connected) {
      socket.connect();
    }
  }

  // Check socket status
  String getSocketStatus() {
    return isSocketConnected.value ? '🟢 Connected' : '🔴 Disconnected';
  }

  @override
  void onClose() {
    log('🔴 MoverChatController closing...');
    messageChatController.dispose();
    leaveConversation();
    socket.disconnect();
    super.onClose();
  }

  void increment() => count.value++;
}