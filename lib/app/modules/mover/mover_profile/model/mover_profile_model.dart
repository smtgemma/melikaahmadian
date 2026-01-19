class MoverProfileModel {
  bool? success;
  int? statusCode;
  String? message;
  ProfileData? data;

  MoverProfileModel({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  factory MoverProfileModel.fromJson(Map<String, dynamic> json) {
    return MoverProfileModel(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] != null ? ProfileData.fromJson(json['data']) : null,
    );
  }
}

class ProfileData {
  String? id;
  String? fullName;
  String? phone;
  int? moves;
  String? email;
  int? profileView;
  String? image;
  String? bio;
  List<String>? specialization;
  bool? isEmailVerified;
  bool? isVerified;
  String? role;
  String? createdAt;
  String? updatedAt;
  String? status;
  bool? profileCompleted;
  String? accountWith;
  double? averageRating;
  int? totalReview;
  List<ProviderDocument>? providerDocuments;

  ProfileData({
    this.id,
    this.fullName,
    this.phone,
    this.moves,
    this.email,
    this.profileView,
    this.image,
    this.bio,
    this.specialization,
    this.isEmailVerified,
    this.isVerified,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.profileCompleted,
    this.accountWith,
    this.averageRating,
    this.totalReview,
    this.providerDocuments,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      id: json['id'],
      fullName: json['fullName'],
      phone: json['phone'],
      moves: json['moves'],
      email: json['email'],
      profileView: json['profileView'],
      image: json['image'],
      bio: json['bio'],
      specialization: json['specialization'] != null
          ? List<String>.from(json['specialization'])
          : [],
      isEmailVerified: json['isEmailVerified'],
      isVerified: json['isVerified'],
      role: json['role'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      status: json['status'],
      profileCompleted: json['profileCompleted'],
      accountWith: json['accountWith'],
      averageRating: json['averageRating']?.toDouble(),
      totalReview: json['totalReview'],
      providerDocuments: json['ProviderDocuments'] != null
          ? (json['ProviderDocuments'] as List)
          .map((e) => ProviderDocument.fromJson(e))
          .toList()
          : [],
    );
  }
}

class ProviderDocument {
  String? name;
  String? url;

  ProviderDocument({this.name, this.url});

  factory ProviderDocument.fromJson(Map<String, dynamic> json) {
    return ProviderDocument(
      name: json['name'],
      url: json['url'],
    );
  }
}
