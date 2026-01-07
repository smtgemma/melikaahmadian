class GetProfileModel {
  bool? success;
  int? statusCode;
  String? message;
  ProfileData? data;

  GetProfileModel({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  factory GetProfileModel.fromJson(Map<String, dynamic> json) {
    return GetProfileModel(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] != null
          ? ProfileData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'statusCode': statusCode,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

// ------------------------------------------------------------

class ProfileData {
  String? id;
  String? fullName;
  String? phone;
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
  List<dynamic>? providerDocuments;
  double? averageRating;

  ProfileData({
    this.id,
    this.fullName,
    this.phone,
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
    this.providerDocuments,
    this.averageRating,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      id: json['id'],
      fullName: json['fullName'],
      phone: json['phone'],
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
      providerDocuments: json['ProviderDocuments'] != null
          ? List<dynamic>.from(json['ProviderDocuments'])
          : [],
      averageRating: json['averageRating'] != null
          ? double.tryParse(json['averageRating'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'phone': phone,
      'email': email,
      'profileView': profileView,
      'image': image,
      'bio': bio,
      'specialization': specialization,
      'isEmailVerified': isEmailVerified,
      'isVerified': isVerified,
      'role': role,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'status': status,
      'profileCompleted': profileCompleted,
      'accountWith': accountWith,
      'ProviderDocuments': providerDocuments,
      'averageRating': averageRating,
    };
  }
}
