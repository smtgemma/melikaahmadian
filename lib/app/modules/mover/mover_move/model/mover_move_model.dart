class MoverMoveModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  MoverMoveModel({this.success, this.statusCode, this.message, this.data});

  factory MoverMoveModel.fromJson(Map<String, dynamic> json) => MoverMoveModel(
    success: json['success'],
    statusCode: json['statusCode'],
    message: json['message'],
    data: json['data'] != null ? Data.fromJson(json['data']) : null,
  );

  Map<String, dynamic> toJson() => {
    'success': success,
    'statusCode': statusCode,
    'message': message,
    'data': data?.toJson(),
  };
}

class Data {
  Meta? meta;
  List<OfferData>? data;

  Data({this.meta, this.data});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
    data: json['data'] != null
        ? List<OfferData>.from(
        json['data'].map((x) => OfferData.fromJson(x)))
        : [],
  );

  Map<String, dynamic> toJson() => {
    'meta': meta?.toJson(),
    'data': data?.map((x) => x.toJson()).toList(),
  };
}

class Meta {
  int? total;
  int? page;
  int? limit;
  int? totalPage;

  Meta({this.total, this.page, this.limit, this.totalPage});

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    total: json['total'],
    page: json['page'],
    limit: json['limit'],
    totalPage: json['totalPage'],
  );

  Map<String, dynamic> toJson() => {
    'total': total,
    'page': page,
    'limit': limit,
    'totalPage': totalPage,
  };
}

class OfferData {
  String? id;
  String? postId;
  String? providerId;
  int? offerPrice;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? cancellationReason;
  Post? post;

  OfferData(
      {this.id,
        this.postId,
        this.providerId,
        this.offerPrice,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.cancellationReason,
        this.post});

  factory OfferData.fromJson(Map<String, dynamic> json) => OfferData(
    id: json['id'],
    postId: json['postId'],
    providerId: json['providerId'],
    offerPrice: json['offerPrice'],
    status: json['status'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
    cancellationReason: json['cancellationReason'],
    post: json['post'] != null ? Post.fromJson(json['post']) : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'postId': postId,
    'providerId': providerId,
    'offerPrice': offerPrice,
    'status': status,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'cancellationReason': cancellationReason,
    'post': post?.toJson(),
  };
}

class Post {
  List<Media>? media;
  Address? pickupAddress;
  Address? dropoffAddress;
  List<Furniture>? furniture;
  String? id;
  String? authorId;
  String? status;
  String? moveStatus;
  String? createdAt;
  String? updatedAt;
  bool? isDeleted;
  String? scheduleDate;
  String? scheduleTime;
  String? houseType;
  int? offerPrice;
  String? cancellationReason;
  Author? author;

  Post({
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
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
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
    offerPrice: json['offerPrice'],
    cancellationReason: json['cancellationReason'],
    author: json['author'] != null ? Author.fromJson(json['author']) : null,
  );

  Map<String, dynamic> toJson() => {
    'media': media?.map((x) => x.toJson()).toList(),
    'pickupAddress': pickupAddress?.toJson(),
    'dropoffAddress': dropoffAddress?.toJson(),
    'furniture': furniture?.map((x) => x.toJson()).toList(),
    'id': id,
    'authorId': authorId,
    'status': status,
    'moveStatus': moveStatus,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'isDeleted': isDeleted,
    'scheduleDate': scheduleDate,
    'scheduleTime': scheduleTime,
    'houseType': houseType,
    'offerPrice': offerPrice,
    'cancellationReason': cancellationReason,
    'author': author?.toJson(),
  };
}

class Media {
  String? type;
  String? url;
  String? key;
  String? thumbnail;

  Media({this.type, this.url, this.key, this.thumbnail});

  factory Media.fromJson(Map<String, dynamic> json) => Media(
    type: json['type'],
    url: json['url'],
    key: json['key'],
    thumbnail: json['thumbnail'],
  );

  Map<String, dynamic> toJson() =>
      {'type': type, 'url': url, 'key': key, 'thumbnail': thumbnail};
}

class Address {
  String? address;
  double? latitude;
  double? longitude;

  Address({this.address, this.latitude, this.longitude});

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    address: json['address'],
    latitude: (json['latitude'] as num?)?.toDouble(),
    longitude: (json['longitude'] as num?)?.toDouble(),
  );

  Map<String, dynamic> toJson() =>
      {'address': address, 'latitude': latitude, 'longitude': longitude};
}

class Furniture {
  String? name;
  int? quantity;

  Furniture({this.name, this.quantity});

  factory Furniture.fromJson(Map<String, dynamic> json) => Furniture(
    name: json['name'],
    quantity: json['quantity'],
  );

  Map<String, dynamic> toJson() => {'name': name, 'quantity': quantity};
}

class Author {
  String? id;
  String? fullName;
  String? image;

  Author({this.id, this.fullName, this.image});

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    id: json['id'],
    fullName: json['fullName'],
    image: json['image'],
  );

  Map<String, dynamic> toJson() =>
      {'id': id, 'fullName': fullName, 'image': image};
}
