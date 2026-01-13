class ProfileModel {
  final bool success;
  final int statusCode;
  final String message;
  final ProfileData data;

  ProfileModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      success: json['success'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: ProfileData.fromJson(json['data'] ?? {}),
    );
  }
}

// --------------------------------------------------------

class ProfileData {
  final String id;
  final String fullName;
  final String image;
  final String role;
  final String status;
  final String email;
  final String createdAt;
  final String accountWith;
  final bool isVerified;
  final bool isEmailVerified;
  final String bio;
  final List<String> specialization;
  final double averageRating;
  final int totalReview;
  final List<ProviderDocument> providerDocuments;

  ProfileData({
    required this.id,
    required this.fullName,
    required this.image,
    required this.role,
    required this.status,
    required this.email,
    required this.createdAt,
    required this.accountWith,
    required this.isVerified,
    required this.isEmailVerified,
    required this.bio,
    required this.specialization,
    required this.averageRating,
    required this.totalReview,
    required this.providerDocuments,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      id: json['id'] ?? '',
      fullName: json['fullName'] ?? '',
      image: json['image'] ?? '',
      role: json['role'] ?? '',
      status: json['status'] ?? '',
      email: json['email'] ?? '',
      createdAt: json['createdAt'] ?? '',
      accountWith: json['accountWith'] ?? '',
      isVerified: json['isVerified'] ?? false,
      isEmailVerified: json['isEmailVerified'] ?? false,
      bio: json['bio'] ?? '',
      specialization: List<String>.from(json['specialization'] ?? []),
      averageRating: (json['averageRating'] ?? 0).toDouble(),
      totalReview: json['totalReview'] ?? 0,
      providerDocuments: (json['ProviderDocuments'] as List? ?? [])
          .map((e) => ProviderDocument.fromJson(e))
          .toList(),
    );
  }
}

// --------------------------------------------------------

class ProviderDocument {
  final String name;
  final String url;

  ProviderDocument({
    required this.name,
    required this.url,
  });

  factory ProviderDocument.fromJson(Map<String, dynamic> json) {
    return ProviderDocument(
      name: json['name'] ?? '',
      url: json['url'] ?? '',
    );
  }
}
