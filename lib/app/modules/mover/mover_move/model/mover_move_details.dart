class MoverMoveDetailsModel {
  bool? success;
  int? statusCode;
  String? message;
  List<MoverMoveItem>? data;

  MoverMoveDetailsModel({this.success, this.statusCode, this.message, this.data});

  factory MoverMoveDetailsModel.fromJson(Map<String, dynamic> json) {
    return MoverMoveDetailsModel(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] != null
          ? List<MoverMoveItem>.from(
          json['data'].map((x) => MoverMoveItem.fromJson(x)))
          : [],
    );
  }
}

/* -------------------- ITEM -------------------- */

class MoverMoveItem {
  String? id;
  String? postId;
  String? providerId;
  int? offerPrice;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? cancellationReason;

  List<PostMedia>? postMedia;
  PostDetails? postDetails;
  UserInfo? author;
  ProviderInfo? provider;

  MoverMoveItem({
    this.id,
    this.postId,
    this.providerId,
    this.offerPrice,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.cancellationReason,
    this.postMedia,
    this.postDetails,
    this.author,
    this.provider,
  });

  factory MoverMoveItem.fromJson(Map<String, dynamic> json) {
    return MoverMoveItem(
      id: json['id'],
      postId: json['postId'],
      providerId: json['providerId'],
      offerPrice: json['offerPrice'],
      status: json['status'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      cancellationReason: json['cancellationReason'],
      postMedia: json['postMedia'] != null
          ? List<PostMedia>.from(
          json['postMedia'].map((x) => PostMedia.fromJson(x)))
          : [],
      postDetails: json['postDetails'] != null
          ? PostDetails.fromJson(json['postDetails'])
          : null,
      author:
      json['author'] != null ? UserInfo.fromJson(json['author']) : null,
      provider: json['provider'] != null
          ? ProviderInfo.fromJson(json['provider'])
          : null,
    );
  }
}

/* -------------------- MEDIA -------------------- */

class PostMedia {
  String? type;
  String? url;
  String? key;
  String? thumbnail;

  PostMedia({this.type, this.url, this.key, this.thumbnail});

  factory PostMedia.fromJson(Map<String, dynamic> json) {
    return PostMedia(
      type: json['type'],
      url: json['url'],
      key: json['key'],
      thumbnail: json['thumbnail'],
    );
  }
}

/* -------------------- POST DETAILS -------------------- */

class PostDetails {
  int? offerPrice;
  Address? pickupAddress;
  Address? dropoffAddress;
  List<Furniture>? furniture;
  String? scheduleDate;
  String? scheduleTime;
  String? houseType;

  PostDetails({
    this.offerPrice,
    this.pickupAddress,
    this.dropoffAddress,
    this.furniture,
    this.scheduleDate,
    this.scheduleTime,
    this.houseType,
  });

  factory PostDetails.fromJson(Map<String, dynamic> json) {
    return PostDetails(
      offerPrice: json['offerPrice'],
      pickupAddress: json['pickupAddress'] != null
          ? Address.fromJson(json['pickupAddress'])
          : null,
      dropoffAddress: json['dropoffAddress'] != null
          ? Address.fromJson(json['dropoffAddress'])
          : null,
      furniture: json['furniture'] != null
          ? List<Furniture>.from(
          json['furniture'].map((x) => Furniture.fromJson(x)))
          : [],
      scheduleDate: json['scheduleDate'],
      scheduleTime: json['scheduleTime'],
      houseType: json['houseType'],
    );
  }
}

/* -------------------- ADDRESS -------------------- */

class Address {
  String? address;
  double? latitude;
  double? longitude;

  Address({this.address, this.latitude, this.longitude});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      address: json['address'],
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );
  }
}

/* -------------------- FURNITURE -------------------- */

class Furniture {
  String? name;
  int? quantity;

  Furniture({this.name, this.quantity});

  factory Furniture.fromJson(Map<String, dynamic> json) {
    return Furniture(
      name: json['name'],
      quantity: json['quantity'],
    );
  }
}

/* -------------------- AUTHOR -------------------- */

class UserInfo {
  String? id;
  String? fullName;
  String? image;
  double? averageRating;
  int? totalReview;

  UserInfo({
    this.id,
    this.fullName,
    this.image,
    this.averageRating,
    this.totalReview,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'],
      fullName: json['fullName'],
      image: json['image'],
      averageRating: (json['averageRating'] as num?)?.toDouble(),
      totalReview: json['totalReview'],
    );
  }
}

/* -------------------- PROVIDER -------------------- */

class ProviderInfo {
  String? id;
  String? fullName;
  String? image;
  List<String>? specialization;
  double? averageRating;
  int? totalReview;

  ProviderInfo({
    this.id,
    this.fullName,
    this.image,
    this.specialization,
    this.averageRating,
    this.totalReview,
  });

  factory ProviderInfo.fromJson(Map<String, dynamic> json) {
    return ProviderInfo(
      id: json['id'],
      fullName: json['fullName'],
      image: json['image'],
      specialization: json['specialization'] != null
          ? List<String>.from(json['specialization'])
          : [],
      averageRating: (json['averageRating'] as num?)?.toDouble(),
      totalReview: json['totalReview'],
    );
  }
}
