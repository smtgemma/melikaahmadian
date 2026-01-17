class ProfileModel {
  final bool? success;
  final int? statusCode;
  final String? message;
  final ProfileData? data;

  ProfileModel({
     this.success,
     this.statusCode,
     this.message,
     this.data,
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

// ------------------------------------------------------

class ProfileData {
  final String id;
  final String fullName;
  final String image;
  final String bio;
  final List<String> specialization;
  final String createdAt;
  final int moves;
  final bool isVerified;
  final List<ProviderDocument> providerDocuments;
  final String experience;
  final String joinedAt;
  final double averageRating;
  final int totalReviews;
  final List<Gallery> gallery;

  ProfileData({
    required this.id,
    required this.fullName,
    required this.image,
    required this.bio,
    required this.specialization,
    required this.createdAt,
    required this.moves,
    required this.isVerified,
    required this.providerDocuments,
    required this.experience,
    required this.joinedAt,
    required this.averageRating,
    required this.totalReviews,
    required this.gallery,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      id: json['id'] ?? '',
      fullName: json['fullName'] ?? '',
      image: json['image'] ?? '',
      bio: json['bio'] ?? '',
      specialization: List<String>.from(json['specialization'] ?? []),
      createdAt: json['createdAt'] ?? '',
      moves: json['moves'] ?? 0,
      isVerified: json['isVerified'] ?? false,
      providerDocuments: (json['ProviderDocuments'] as List? ?? [])
          .map((e) => ProviderDocument.fromJson(e))
          .toList(),
      experience: json['experience'] ?? '',
      joinedAt: json['joinedAt'] ?? '',
      averageRating: (json['averageRating'] ?? 0).toDouble(),
      totalReviews: json['totalReviews'] ?? 0,
      gallery: (json['gallery'] as List? ?? [])
          .map((e) => Gallery.fromJson(e))
          .toList(),
    );
  }
}

// ------------------------------------------------------

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

// ------------------------------------------------------

class Gallery {
  final String name;
  final String url;

  Gallery({
    required this.name,
    required this.url,
  });

  factory Gallery.fromJson(Map<String, dynamic> json) {
    return Gallery(
      name: json['name'] ?? '',
      url: json['url'] ?? '',
    );
  }
}
