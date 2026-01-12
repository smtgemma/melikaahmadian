class DetailsModel {
  final bool? success;
  final int? statusCode;
  final String? message;
  final PostData? data;

  DetailsModel({
     this.success,
     this.statusCode,
     this.message,
    this.data,
  });

  factory DetailsModel.fromJson(Map<String, dynamic> json) {
    return DetailsModel(
      success: json['success'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? PostData.fromJson(json['data'])
          : null,
    );
  }
}

class PostData {
  final String id;
  final String authorId;
  final List<Media> media;
  final String status;
  final String createdAt;
  final String updatedAt;
  final Address? pickupAddress;
  final Address? dropoffAddress;
  final String scheduleDate;
  final String scheduleTime;
  final String houseType;
  final List<Furniture> furniture;
  final int offerPrice;
  final int totalOffers;

  PostData({
    required this.id,
    required this.authorId,
    required this.media,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.pickupAddress,
    this.dropoffAddress,
    required this.scheduleDate,
    required this.scheduleTime,
    required this.houseType,
    required this.furniture,
    required this.offerPrice,
    required this.totalOffers,
  });

  factory PostData.fromJson(Map<String, dynamic> json) {
    return PostData(
      id: json['id'] ?? '',
      authorId: json['authorId'] ?? '',
      media: (json['media'] as List? ?? [])
          .map((e) => Media.fromJson(e))
          .toList(),
      status: json['status'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      pickupAddress: json['pickupAddress'] != null
          ? Address.fromJson(json['pickupAddress'])
          : null,
      dropoffAddress: json['dropoffAddress'] != null
          ? Address.fromJson(json['dropoffAddress'])
          : null,
      scheduleDate: json['scheduleDate'] ?? '',
      scheduleTime: json['scheduleTime'] ?? '',
      houseType: json['houseType'] ?? '',
      furniture: (json['furniture'] as List? ?? [])
          .map((e) => Furniture.fromJson(e))
          .toList(),
      offerPrice: json['offerPrice'] ?? 0,
      totalOffers: json['totalOffers'] ?? 0,
    );
  }
}

class Media {
  final String type;
  final String url;
  final String key;

  Media({
    required this.type,
    required this.url,
    required this.key,
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      type: json['type'] ?? '',
      url: json['url'] ?? '',
      key: json['key'] ?? '',
    );
  }
}

class Address {
  final String address;
  final double latitude;
  final double longitude;

  Address({
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      address: json['address'] ?? '',
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
    );
  }
}

class Furniture {
  final String name;
  final int quantity;

  Furniture({
    required this.name,
    required this.quantity,
  });

  factory Furniture.fromJson(Map<String, dynamic> json) {
    return Furniture(
      name: json['name'] ?? '',
      quantity: json['quantity'] ?? 0,
    );
  }
}
