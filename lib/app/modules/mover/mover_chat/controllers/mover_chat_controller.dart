import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:melikaahmadian/app/core/network/shared_prepharence_helper.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:melikaahmadian/app/core/const/app_urls.dart';
import 'package:melikaahmadian/app/core/network/dio_client.dart';
import 'package:melikaahmadian/app/modules/mover/mover_chat/model/chat_list_model.dart'
    show ConversationResponse;

class MessageModel {
  final String id;
  final String conversationId;
  final String senderId;
  final String senderName;
  final String? senderImage;
  final String text;
  final String? imageUrl;
  final String? fileUrl;
  final DateTime timestamp;
  final bool isSentByMe;
  final MessageStatus status;

  MessageModel({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.senderName,
    this.senderImage,
    required this.text,
    this.imageUrl,
    this.fileUrl,
    required this.timestamp,
    required this.isSentByMe,
    this.status = MessageStatus.sent,
  });

  factory MessageModel.fromJson(
    Map<String, dynamic> json,
    bool isMe,
    String currentUserId,
  ) {
    return MessageModel(
      id: json['_id'] ?? json['id'] ?? '',
      conversationId: json['conversationId'] ?? '',
      senderId: json['senderId'] ?? '',
      senderName: json['senderName'] ?? 'Unknown',
      senderImage: json['senderImage'],
      text: json['text'] ?? '',
      imageUrl: json['image'],
      fileUrl: json['file'],
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'].toString())
          : DateTime.now(),
      isSentByMe: isMe || json['senderId'] == currentUserId,
      status: _parseMessageStatus(json['status']),
    );
  }

  static MessageStatus _parseMessageStatus(dynamic status) {
    if (status is String) {
      switch (status.toLowerCase()) {
        case 'sending':
          return MessageStatus.sending;
        case 'sent':
          return MessageStatus.sent;
        case 'delivered':
          return MessageStatus.delivered;
        case 'read':
          return MessageStatus.read;
        case 'failed':
          return MessageStatus.failed;
        default:
          return MessageStatus.sent;
      }
    }
    return MessageStatus.sent;
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'conversationId': conversationId,
    'senderId': senderId,
    'senderName': senderName,
    'senderImage': senderImage,
    'text': text,
    'image': imageUrl,
    'file': fileUrl,
    'timestamp': timestamp.toIso8601String(),
    'status': status.toString().split('.').last,
  };
}

enum MessageStatus { sending, sent, delivered, read, failed }

class MoverChatController extends GetxController {
  final messageChatController = TextEditingController();
  final _networkCaller = DioClient();

  // Chat list from API
  final chatListModel = Rxn<ConversationResponse>();

  // WebSocket related
  late IO.Socket socket;
  final messages = <MessageModel>[].obs;
  final onlineUsers = <String>[].obs;
  final isTyping = false.obs;
  final typingUserName = ''.obs;
  final currentConversationId = Rxn<String>();
  final isSocketConnected = false.obs;
  final currentUserId = ''.obs;
  final token = ''.obs;
  final isLoadingMessages = false.obs;
  final hasMoreMessages = true.obs;
  final lastMessageTimestamp = Rxn<DateTime>();

  // Typing debounce
  Timer? _typingTimer;
  bool _isTypingLocal = false;

  @override
  void onInit() {
    super.onInit();
    log('🟢 MoverChatController onInit called');
    getAllChatList();
    getAccessToken();
  }

  Future<void> getAccessToken() async {
    token.value =
        await SharedPrefHelper.getString(SharedPrefHelper.accessToken) ?? '';
    currentUserId.value =
        await SharedPrefHelper.getString(SharedPrefHelper.userId) ?? '';

    if (token.value.isNotEmpty) {
      _initializeSocket();
    }
  }

  void _initializeSocket() {
    try {
      log('🔹 Starting WebSocket initialization...');
      socket = IO.io(
        'ws://206.162.244.175:6008',
        IO.OptionBuilder()
            .setTransports(['websocket', 'polling'])
            .disableAutoConnect()
            .setReconnectionDelay(1000)
            .setReconnectionDelayMax(5000)
            .setReconnectionAttempts(10)
            .setExtraHeaders({'Authorization': token.value})
            .build(),
      );

      socket.onConnect((_) {
        log('✅ WebSocket Connected!');
        isSocketConnected.value = true;
        _emitUserOnline();
        getOnlineUsers();
      });

      socket.onDisconnect((_) {
        log('❌ WebSocket Disconnected');
        isSocketConnected.value = false;
      });

      socket.onError((error) {
        log('⚠️ WebSocket Error: $error');
        isSocketConnected.value = false;
      });

      socket.onConnectError((data) {
        log('⚠️ WebSocket Connect Error: $data');
        isSocketConnected.value = false;
      });

      _setupEventListeners();
      log('🔹 Calling socket.connect()...');
      socket.connect();
    } catch (e, s) {
      log('❌ Error initializing socket: $e', stackTrace: s);
    }
  }

  void _setupEventListeners() {
    socket.on('user_online', (data) {
      log('👤 User online: $data');
      if (data is Map && data['userId'] != null) {
        final userId = data['userId'].toString();
        if (!onlineUsers.contains(userId)) {
          onlineUsers.add(userId);
        }
      }
    });

    socket.on('get_online_users', (data) {
      log('👥 Online users received: $data');
      if (data is List) {
        onlineUsers.value = data.map((e) => e.toString()).toList();
      }
    });

    socket.on('new_message', (data) {
      log('💬 New message received: $data');
      if (data is Map<String, dynamic>) {
        try {
          final isMe = data['senderId'] == currentUserId.value;
          final message = MessageModel.fromJson(
            data,
            isMe,
            currentUserId.value,
          );

          if (message.conversationId == currentConversationId.value) {
            messages.add(message);
            lastMessageTimestamp.value = message.timestamp;
          }

          // Update chat list
          _updateChatListWithNewMessage(message);
        } catch (e) {
          log('❌ Error parsing new message: $e');
        }
      }
    });

    socket.on('message_status', (data) {
      log('📊 Message status updated: $data');
      if (data is Map<String, dynamic>) {
        final messageId = data['messageId'];
        final status = data['status'];
        _updateMessageStatus(messageId, status);
      }
    });

    socket.on('typing', (data) {
      log('⌨️ User typing: $data');
      if (data is Map && data['userId'] != currentUserId.value) {
        typingUserName.value = data['userName'] ?? 'Someone';
        isTyping.value = true;
      }
    });

    socket.on('stop_typing', (data) {
      log('🛑 User stopped typing: $data');
      isTyping.value = false;
      typingUserName.value = '';
    });

    socket.on('join_chat', (data) {
      log('🚪 User joined chat: $data');
    });

    socket.on('leave_chat', (data) {
      log('🚪 User left chat: $data');
    });
  }

  void _updateChatListWithNewMessage(MessageModel message) {
    final chatList = chatListModel.value;
    if (chatList != null) {
      final conversationIndex = chatList.data.indexWhere(
        (conv) => conv.id == message.conversationId,
      );

      if (conversationIndex != -1) {
        final conversation = chatList.data[conversationIndex];
        conversation.lastMessage = message.toJson();
        conversation.updatedAt = DateTime.now().toIso8601String();

        // Move to top
        chatList.data.removeAt(conversationIndex);
        chatList.data.insert(0, conversation);
        chatListModel.refresh();
      }
    }
  }

  void _updateMessageStatus(String messageId, String status) {
    final messageIndex = messages.indexWhere((m) => m.id == messageId);
    if (messageIndex != -1) {
      final message = messages[messageIndex];
      final updatedMessage = MessageModel(
        id: message.id,
        conversationId: message.conversationId,
        senderId: message.senderId,
        senderName: message.senderName,
        senderImage: message.senderImage,
        text: message.text,
        imageUrl: message.imageUrl,
        fileUrl: message.fileUrl,
        timestamp: message.timestamp,
        isSentByMe: message.isSentByMe,
        status: MessageModel._parseMessageStatus(status),
      );
      messages[messageIndex] = updatedMessage;
    }
  }

  void _emitUserOnline() {
    try {
      socket.emit('user_online', {
        'userId': currentUserId.value,
        'userName': 'Current User',
        'timestamp': DateTime.now().toIso8601String(),
      });
      log('📤 Emitted user_online event');
    } catch (e) {
      log('❌ Error emitting user_online: $e');
    }
  }

  Future<void> getAllChatList() async {
    try {
      log('➡️ Calling getAllChat API: ${AppUrls.getAllChat}');
      final response = await _networkCaller.get(AppUrls.getAllChat);

      if (response.statusCode == 200) {
        chatListModel.value = ConversationResponse.fromJson(response.data);
        log(
          '✅ Chat list parsed successfully with ${chatListModel.value?.data.length} conversations',
        );
      } else {
        log('⚠️ API call failed with status: ${response.statusCode}');
      }
    } catch (e, s) {
      log('❌ Error in getAllChatList(): $e', stackTrace: s);
    }
  }

  void joinChat(String conversationId) {
    if (!isSocketConnected.value) {
      log('⚠️ Socket not connected');
      return;
    }

    currentConversationId.value = conversationId;

    socket.emit('join_chat', {
      'conversationId': conversationId,
      'userId': currentUserId.value,
    });

    messages.clear();
    log('✅ Joined chat room: $conversationId');
  }

  void leaveChat() {
    if (currentConversationId.value == null) return;

    socket.emit('leave_chat', {
      'conversationId': currentConversationId.value,
      'userId': currentUserId.value,
    });

    log('👋 Left chat room: ${currentConversationId.value}');
    currentConversationId.value = null;
    messages.clear();
  }

  void sendMessage(String text, {String? imageUrl, String? fileUrl}) {
    log('➡️ sendMessage() called');

    if (text.trim().isEmpty) {
      log('⚠️ Message text is empty, abort sending');
      return;
    }

    if (currentConversationId.value == null) {
      log('⚠️ No active conversation, cannot send message');
      return;
    }

    if (!isSocketConnected.value) {
      log('❌ Socket not connected, cannot send message');
      Get.snackbar('Error', 'Socket connection lost');
      return;
    }

    final tempId = DateTime.now().millisecondsSinceEpoch.toString();
    final payload = {
      'conversationId': currentConversationId.value,
      'text': text.trim(),
      if (imageUrl != null) 'image': imageUrl,
      if (fileUrl != null) 'file': fileUrl,
    };

    log('🆔 Generated temp message ID: $tempId');
    log('📦 Payload to send: $payload');

    // 🔹 Optimistic UI
    final optimisticMessage = MessageModel(
      id: tempId,
      conversationId: currentConversationId.value!,
      senderId: currentUserId.value,
      senderName: 'You',
      text: text.trim(),
      imageUrl: imageUrl,
      fileUrl: fileUrl,
      timestamp: DateTime.now(),
      isSentByMe: true,
      status: MessageStatus.sending,
    );

    messages.add(optimisticMessage);
    log('⚡ Optimistic UI updated: message added locally');

    try {
      socket.emitWithAck(
        'send_message',
        payload,
        ack: (data) {
          // যদি server ack event support করে
          log('✅ Server ACK received for message: $data');

          // আপনি চাইলে এখানে status update করতে পারেন
          // _updateMessageStatus(tempId, 'sent');
        },
      );

      log('📤 send_message emitted to server');
    } catch (e, s) {
      log('❌ Error emitting send_message: $e', stackTrace: s);

      // update message status to failed
      final index = messages.indexWhere((m) => m.id == tempId);
      if (index != -1) {
        messages[index] = MessageModel(
          id: optimisticMessage.id,
          conversationId: optimisticMessage.conversationId,
          senderId: optimisticMessage.senderId,
          senderName: optimisticMessage.senderName,
          text: optimisticMessage.text,
          imageUrl: optimisticMessage.imageUrl,
          fileUrl: optimisticMessage.fileUrl,
          timestamp: optimisticMessage.timestamp,
          isSentByMe: true,
          status: MessageStatus.failed,
        );
      }

      Get.snackbar('Error', 'Failed to send message');
    }

    messageChatController.clear();
  }

  void setTyping(bool typing) {
    if (currentConversationId.value == null || !isSocketConnected.value) {
      return;
    }

    if (typing && !_isTypingLocal) {
      _isTypingLocal = true;
      socket.emit('typing', {
        'conversationId': currentConversationId.value,
        'userId': currentUserId.value,
        'userName': 'Current User',
      });

      _typingTimer?.cancel();
      _typingTimer = Timer(const Duration(seconds: 3), () {
        _stopTyping();
      });
    } else if (!typing && _isTypingLocal) {
      _stopTyping();
    }
  }

  void _stopTyping() {
    if (_isTypingLocal && currentConversationId.value != null) {
      _isTypingLocal = false;
      _typingTimer?.cancel();
      socket.emit('stop_typing', {
        'conversationId': currentConversationId.value,
        'userId': currentUserId.value,
      });
    }
  }

  void getOnlineUsers() {
    try {
      socket.emit('get_online_users');
    } catch (e) {
      log('❌ Error getting online users: $e');
    }
  }

  Future<void> refreshChatList() async {
    await getAllChatList();
  }

  void reconnectSocket() {
    log('🔄 Attempting to reconnect socket...');
    if (!socket.connected) {
      socket.connect();
    }
  }

  String getSocketStatus() {
    return isSocketConnected.value ? '🟢 Connected' : '🔴 Disconnected';
  }

  int getOnlineUserCount() => onlineUsers.length;

  bool isUserOnline(String userId) => onlineUsers.contains(userId);

  @override
  void onClose() {
    log('🔴 MoverChatController closing...');
    messageChatController.dispose();
    _typingTimer?.cancel();
    leaveChat();
    socket.disconnect();
    super.onClose();
  }
}
