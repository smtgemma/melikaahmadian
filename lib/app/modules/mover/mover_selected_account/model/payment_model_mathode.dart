class PayoutMethodModel {
  final String id;
  final String providerId;
  final String country;
  final String methodType;
  final PayoutDetails details;
  final bool isVerified;
  final bool isActive;
  final String createdAt;
  final String updatedAt;
  final Provider provider;

  PayoutMethodModel({
    required this.id,
    required this.providerId,
    required this.country,
    required this.methodType,
    required this.details,
    required this.isVerified,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.provider,
  });

  factory PayoutMethodModel.fromJson(Map<String, dynamic> json) {
    return PayoutMethodModel(
      id: json['id'] ?? '',
      providerId: json['providerId'] ?? '',
      country: json['country'] ?? '',
      methodType: json['methodType'] ?? '',
      details: PayoutDetails.fromJson(json['details'] ?? {}),
      isVerified: json['isVerified'] ?? false,
      isActive: json['isActive'] ?? false,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      provider: Provider.fromJson(json['provider'] ?? {}),
    );
  }
}

class PayoutDetails {
  final String email;
  final String securityQuestion;
  final String securityAnswer;

  PayoutDetails({
    required this.email,
    required this.securityQuestion,
    required this.securityAnswer,
  });

  factory PayoutDetails.fromJson(Map<String, dynamic> json) {
    return PayoutDetails(
      email: json['email'] ?? '',
      securityQuestion: json['securityQuestion'] ?? '',
      securityAnswer: json['securityAnswer'] ?? '',
    );
  }
}

class Provider {
  final String id;
  final String fullName;
  final String email;

  Provider({
    required this.id,
    required this.fullName,
    required this.email,
  });

  factory Provider.fromJson(Map<String, dynamic> json) {
    return Provider(
      id: json['id'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
    );
  }
}