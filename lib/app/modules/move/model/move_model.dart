class MoveModel {
  bool? success;
  int? statusCode;
  String? message;
  Meta? meta;
  List<Data>? data;

  MoveModel(
      {this.success, this.statusCode, this.message, this.meta, this.data});

  MoveModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
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
    total = json['total'];
    page = json['page'];
    limit = json['limit'];
    totalPage = json['totalPage'];
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
    id = json['id'];
    authorId = json['authorId'];
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(new Media.fromJson(v));
      });
    }
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    pickupAddress = json['pickupAddress'] != null
        ? new PickupAddress.fromJson(json['pickupAddress'])
        : null;
    dropoffAddress = json['dropoffAddress'] != null
        ? new PickupAddress.fromJson(json['dropoffAddress'])
        : null;
    scheduleDate = json['scheduleDate'];
    scheduleTime = json['scheduleTime'];
    houseType = json['houseType'];
    if (json['furniture'] != null) {
      furniture = <Furniture>[];
      json['furniture'].forEach((v) {
        furniture!.add(new Furniture.fromJson(v));
      });
    }
    offerPrice = json['offerPrice'];
    totalOffers = json['totalOffers'];
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

  Media({this.type, this.url, this.key});

  Media.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    url = json['url'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['url'] = this.url;
    data['key'] = this.key;
    return data;
  }
}

class PickupAddress {
  String? address;
  double? latitude;
  double? longitude;

  PickupAddress({this.address, this.latitude, this.longitude});

  PickupAddress.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
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
    name = json['name'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    return data;
  }
}
