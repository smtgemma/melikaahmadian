class DetailsModel {
  final bool? success;
  final int? statusCode;
  final String? message;
  final PostDetailsModel? data;

  DetailsModel({this.success, this.statusCode, this.message, this.data});

  factory DetailsModel.fromJson(Map<String, dynamic> json) {
    return DetailsModel(
      success: json['success'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? PostDetailsModel.fromJson(json['data'])
          : null,
    );
  }
}

/* -------------------- POST DETAILS -------------------- */

class PostDetailsModel {
  final List<MediaModel> media;
  final AddressModel? pickupAddress;
  final AddressModel? dropoffAddress;
  final List<FurnitureModel> furniture;

  final String id;
  final String authorId;
  final String status;
  final String moveStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool isDeleted;
  final DateTime? scheduleDate;
  final String scheduleTime;
  final String houseType;
  final double offerPrice;
  final String? cancellationReason;
  final int totalOffers;
  final AcceptedOfferModel? acceptedOffer;

  PostDetailsModel({
    required this.media,
    required this.pickupAddress,
    required this.dropoffAddress,
    required this.moveStatus,
    required this.furniture,
    required this.id,
    required this.authorId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.isDeleted,
    required this.scheduleDate,
    required this.scheduleTime,
    required this.houseType,
    required this.offerPrice,
    required this.cancellationReason,
    required this.totalOffers,
    required this.acceptedOffer,
  });

  factory PostDetailsModel.fromJson(Map<String, dynamic> json) {
    return PostDetailsModel(
      media: (json['media'] as List? ?? [])
          .map((e) => MediaModel.fromJson(e))
          .toList(),
      pickupAddress: json['pickupAddress'] != null
          ? AddressModel.fromJson(json['pickupAddress'])
          : null,
      dropoffAddress: json['dropoffAddress'] != null
          ? AddressModel.fromJson(json['dropoffAddress'])
          : null,
      furniture: (json['furniture'] as List? ?? [])
          .map((e) => FurnitureModel.fromJson(e))
          .toList(),
      id: json['id'] ?? '',
      authorId: json['authorId'] ?? '',
      status: json['status'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
      isDeleted: json['isDeleted'] ?? false,
      scheduleDate: json['scheduleDate'] != null
          ? DateTime.tryParse(json['scheduleDate'])
          : null,
      scheduleTime: json['scheduleTime'] ?? '',
      houseType: json['houseType'] ?? '',
      offerPrice: (json['offerPrice'] as num?)?.toDouble() ?? 0.0,
      cancellationReason: json['cancellationReason'],
      totalOffers: json['totalOffers'] ?? 0,
      acceptedOffer: json['acceptedOffer'] != null
          ? AcceptedOfferModel.fromJson(json['acceptedOffer'])
          : null, moveStatus: json['moveStatus'] ?? '',

    );
  }
}

/* -------------------- MEDIA -------------------- */

class MediaModel {
  final String type;
  final String url;
  final String key;
  final String? thumbnail;

  MediaModel({
    required this.type,
    required this.url,
    required this.key,
    this.thumbnail,
  });

  factory MediaModel.fromJson(Map<String, dynamic> json) {
    return MediaModel(
      type: json['type'] ?? '',
      url: json['url'] ?? '',
      key: json['key'] ?? '',
      thumbnail: json['thumbnail'],
    );
  }
}

/* -------------------- ADDRESS -------------------- */

class AddressModel {
  final String? address;
  final double latitude;
  final double longitude;

  AddressModel({
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      address: json['address'],
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

/* -------------------- FURNITURE -------------------- */

class FurnitureModel {
  final String name;
  final int quantity;

  FurnitureModel({required this.name, required this.quantity});

  factory FurnitureModel.fromJson(Map<String, dynamic> json) {
    return FurnitureModel(
      name: json['name'] ?? '',
      quantity: json['quantity'] ?? 0,
    );
  }
}

/* -------------------- ACCEPTED OFFER -------------------- */

class AcceptedOfferModel {
  final String id;
  final String postId;
  final String providerId;
  final double offerPrice;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? cancellationReason;
  final UserModel? provider;
  final UserModel? author;

  AcceptedOfferModel({
    required this.id,
    required this.postId,
    required this.providerId,
    required this.offerPrice,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.cancellationReason,
    required this.provider,
    required this.author,
  });

  factory AcceptedOfferModel.fromJson(Map<String, dynamic> json) {
    return AcceptedOfferModel(
      id: json['id'] ?? '',
      postId: json['postId'] ?? '',
      providerId: json['providerId'] ?? '',
      offerPrice: (json['offerPrice'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
      cancellationReason: json['cancellationReason'],
      provider: json['provider'] != null
          ? UserModel.fromJson(json['provider'])
          : null,
      author: json['author'] != null
          ? UserModel.fromJson(json['author'])
          : null,
    );
  }
}

/* -------------------- USER -------------------- */

class UserModel {
  final String id;
  final String fullName;
  final String? image;
  final String phone;
  final double averageRating;
  final int totalReviews;

  UserModel({
    required this.id,
    required this.fullName,
    required this.image,
    required this.phone,
    required this.averageRating,
    required this.totalReviews,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      fullName: json['fullName'] ?? '',
      image: json['image'],
      phone: json['phone'] ?? '',
      averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0.0,
      totalReviews: json['totalReviews'] ?? 0,
    );
  }
}
