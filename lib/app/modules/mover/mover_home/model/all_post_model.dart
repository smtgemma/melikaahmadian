class AllPostModel {
  final bool? success;
  final int? statusCode;
  final String? message;
  final Meta? meta;
  final List<PostData>? data;

  AllPostModel({
    this.success,
    this.statusCode,
    this.message,
    this.meta,
    this.data,
  });

  factory AllPostModel.fromJson(Map<String, dynamic> json) {
    return AllPostModel(
      success: json['success'],
      statusCode: json['statusCode'],
      message: json['message'],
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      data: json['data'] != null
          ? List<PostData>.from(json['data'].map((x) => PostData.fromJson(x)))
          : [],
    );
  }
}

// ---------------- META ----------------
class Meta {
  final int? total;
  final int? page;
  final int? limit;
  final int? totalPage;

  Meta({this.total, this.page, this.limit, this.totalPage});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      total: json['total'],
      page: json['page'],
      limit: json['limit'],
      totalPage: json['totalPage'],
    );
  }
}

// ---------------- POST DATA ----------------
class PostData {
  final List<Media>? media;
  final Address? pickupAddress;
  final Address? dropoffAddress;
  final List<Furniture>? furniture;
  final String? id;
  final String? authorId;
  final String? status;
  final String? moveStatus;
  final String? createdAt;
  final String? updatedAt;
  final bool? isDeleted;
  final String? scheduleDate;
  final String? scheduleTime;
  final String? houseType;
  final double? offerPrice;
  final String? cancellationReason;
  final Author? author;
  final int? totalOffers;
  final String? assignedProvider;

  PostData({
    this.media,
    this.pickupAddress,
    this.dropoffAddress,
    this.furniture,
    this.id,
    this.authorId,
    this.status,
    this.moveStatus,
    this.createdAt,
    this.updatedAt,
    this.isDeleted,
    this.scheduleDate,
    this.scheduleTime,
    this.houseType,
    this.offerPrice,
    this.cancellationReason,
    this.author,
    this.totalOffers,
    this.assignedProvider,
  });

  factory PostData.fromJson(Map<String, dynamic> json) {
    return PostData(
      media: json['media'] != null
          ? List<Media>.from(json['media'].map((x) => Media.fromJson(x)))
          : [],
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
      id: json['id'],
      authorId: json['authorId'],
      status: json['status'],
      moveStatus: json['moveStatus'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      isDeleted: json['isDeleted'],
      scheduleDate: json['scheduleDate'],
      scheduleTime: json['scheduleTime'],
      houseType: json['houseType'],
      offerPrice: json['offerPrice'] != null
          ? (json['offerPrice'] as num).toDouble()
          : null,
      cancellationReason: json['cancellationReason'],
      author: json['author'] != null ? Author.fromJson(json['author']) : null,
      totalOffers: json['totalOffers'],
      assignedProvider: json['assignedProvider'],
    );
  }
}

// ---------------- MEDIA ----------------
class Media {
  final String? type;
  final String? url;
  final String? key;
  final String? thumbnail;

  Media({this.type, this.url, this.key, this.thumbnail});

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      type: json['type'],
      url: json['url'],
      key: json['key'],
      thumbnail: json['thumbnail'],
    );
  }
}

// ---------------- ADDRESS ----------------
class Address {
  final String? address;
  final double? latitude;
  final double? longitude;

  Address({this.address, this.latitude, this.longitude});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      address: json['address'],
      latitude:
      json['latitude'] != null ? (json['latitude'] as num).toDouble() : null,
      longitude: json['longitude'] != null
          ? (json['longitude'] as num).toDouble()
          : null,
    );
  }
}

// ---------------- FURNITURE ----------------
class Furniture {
  final String? name;
  final int? quantity;

  Furniture({this.name, this.quantity});

  factory Furniture.fromJson(Map<String, dynamic> json) {
    return Furniture(
      name: json['name'],
      quantity: json['quantity'],
    );
  }
}

// ---------------- AUTHOR ----------------
class Author {
  final String? id;
  final String? fullName;
  final String? image;

  Author({this.id, this.fullName, this.image});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'],
      fullName: json['fullName'],
      image: json['image'],
    );
  }
}
