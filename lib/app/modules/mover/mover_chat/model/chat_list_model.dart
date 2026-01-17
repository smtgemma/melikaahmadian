class ConversationResponse {
  final bool success;
  final int statusCode;
  final String message;
  final List<Conversation> data;

  ConversationResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory ConversationResponse.fromJson(Map<String, dynamic> json) {
    return ConversationResponse(
      success: json['success'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? "",
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => Conversation.fromJson(e))
          .toList(),
    );
  }
}

class Conversation {
  final String id;
  final List<String> participants;
  final String createdAt;
   String updatedAt;
  final List<dynamic> messages;
  final OtherParticipant? otherParticipant;
   dynamic lastMessage;

  Conversation({
    required this.id,
    required this.participants,
    required this.createdAt,
    required this.updatedAt,
    required this.messages,
    this.otherParticipant,
    this.lastMessage,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['id'] ?? "",
      participants:
      (json['participants'] as List<dynamic>? ?? []).cast<String>(),
      createdAt: json['createdAt'] ?? "",
      updatedAt: json['updatedAt'] ?? "",
      messages: json['messages'] as List<dynamic>? ?? [],
      otherParticipant: json['otherParticipant'] != null
          ? OtherParticipant.fromJson(json['otherParticipant'])
          : null,
      lastMessage: json['lastMessage'],
    );
  }
}

class OtherParticipant {
  final String id;
  final String fullName;
  final String? image;
  final String role;
  final String email;

  OtherParticipant({
    required this.id,
    required this.fullName,
    this.image,
    required this.role,
    required this.email,
  });

  factory OtherParticipant.fromJson(Map<String, dynamic> json) {
    return OtherParticipant(
      id: json['id'] ?? "",
      fullName: json['fullName'] ?? "",
      image: json['image'],
      role: json['role'] ?? "",
      email: json['email'] ?? "",
    );
  }
}
