class MoveModel {
  bool? success;
  int? statusCode;
  String? message;
  Meta? meta;
  List<Data>? data;

  MoveModel(
      {this.success, this.statusCode, this.message, this.meta, this.data});

  static MoveModel parseMoveModel(Map<String, dynamic> json) {
    return MoveModel.fromJson(json);
  }

  MoveModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message']?.toString();
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['data'] is List) {
      data = <Data>[];
      for (var v in json['data']) {
        if (v is Map<String, dynamic>) {
          data!.add(Data.fromJson(v));
        }
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meta {
  int? total;
  int? page;
  int? limit;
  int? totalPage;

  Meta({this.total, this.page, this.limit, this.totalPage});

  Meta.fromJson(Map<String, dynamic> json) {
    total = json['total'] is int ? json['total'] : int.tryParse(json['total']?.toString() ?? '');
    page = json['page'] is int ? json['page'] : int.tryParse(json['page']?.toString() ?? '');
    limit = json['limit'] is int ? json['limit'] : int.tryParse(json['limit']?.toString() ?? '');
    totalPage = json['totalPage'] is int ? json['totalPage'] : int.tryParse(json['totalPage']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['totalPage'] = this.totalPage;
    return data;
  }
}

class Data {
  String? id;
  String? authorId;
  List<Media>? media;
  String? status;
  String? createdAt;
  String? updatedAt;
  PickupAddress? pickupAddress;
  PickupAddress? dropoffAddress;
  String? scheduleDate;
  String? scheduleTime;
  String? houseType;
  List<Furniture>? furniture;
  int? offerPrice;
  int? totalOffers;

  Data(
      {this.id,
        this.authorId,
        this.media,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.pickupAddress,
        this.dropoffAddress,
        this.scheduleDate,
        this.scheduleTime,
        this.houseType,
        this.furniture,
        this.offerPrice,
        this.totalOffers});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    authorId = json['authorId'] is Map ? json['authorId']['id']?.toString() : json['authorId']?.toString();
    if (json['media'] is List) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(new Media.fromJson(v));
      });
    }
    status = json['status']?.toString();
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
    pickupAddress = json['pickupAddress'] != null && json['pickupAddress'] is Map<String, dynamic>
        ? new PickupAddress.fromJson(json['pickupAddress'])
        : null;
    dropoffAddress = json['dropoffAddress'] != null && json['dropoffAddress'] is Map<String, dynamic>
        ? new PickupAddress.fromJson(json['dropoffAddress'])
        : null;
    scheduleDate = json['scheduleDate']?.toString();
    scheduleTime = json['scheduleTime']?.toString();
    houseType = json['houseType']?.toString();
    if (json['furniture'] is List) {
      furniture = <Furniture>[];
      json['furniture'].forEach((v) {
        furniture!.add(new Furniture.fromJson(v));
      });
    }
    offerPrice = json['offerPrice'] is int ? json['offerPrice'] : (json['offerPrice'] as num?)?.toInt();
    totalOffers = json['totalOffers'] is int ? json['totalOffers'] : (json['totalOffers'] as num?)?.toInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['authorId'] = this.authorId;
    if (this.media != null) {
      data['media'] = this.media!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.pickupAddress != null) {
      data['pickupAddress'] = this.pickupAddress!.toJson();
    }
    if (this.dropoffAddress != null) {
      data['dropoffAddress'] = this.dropoffAddress!.toJson();
    }
    data['scheduleDate'] = this.scheduleDate;
    data['scheduleTime'] = this.scheduleTime;
    data['houseType'] = this.houseType;
    if (this.furniture != null) {
      data['furniture'] = this.furniture!.map((v) => v.toJson()).toList();
    }
    data['offerPrice'] = this.offerPrice;
    data['totalOffers'] = this.totalOffers;
    return data;
  }
}

class Media {
  String? type;
  String? url;
  String? key;

  Media({this.type, this.url, this.key, this.thumbnail});
  String? thumbnail;

  Media.fromJson(Map<String, dynamic> json) {
    type = json['type']?.toString();
    url = json['url']?.toString();
    key = json['key']?.toString();
    thumbnail = json['thumbnail']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['url'] = this.url;
    data['key'] = this.key;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}

class PickupAddress {
  String? address;
  double? latitude;
  double? longitude;

  PickupAddress({this.address, this.latitude, this.longitude});

  PickupAddress.fromJson(Map<String, dynamic> json) {
    address = json['address']?.toString();
    latitude = json['latitude'] is num ? (json['latitude'] as num).toDouble() : double.tryParse(json['latitude']?.toString() ?? '');
    longitude = json['longitude'] is num ? (json['longitude'] as num).toDouble() : double.tryParse(json['longitude']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}

class Furniture {
  String? name;
  int? quantity;

  Furniture({this.name, this.quantity});

  Furniture.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    quantity = json['quantity'] is int ? json['quantity'] : (json['quantity'] as num?)?.toInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    return data;
  }
}
