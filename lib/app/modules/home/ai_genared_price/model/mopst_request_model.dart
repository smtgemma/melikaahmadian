class postRequestModel {
  int? offerPrice;
  String? scheduleDate;
  String? scheduleTime;
  String? houseType;
  PickupAddress? pickupAddress;
  PickupAddress? dropoffAddress;
  List<Furniture>? furniture;

  postRequestModel(
      {this.offerPrice,
        this.scheduleDate,
        this.scheduleTime,
        this.houseType,
        this.pickupAddress,
        this.dropoffAddress,
        this.furniture});

  postRequestModel.fromJson(Map<String, dynamic> json) {
    offerPrice = json['offerPrice'];
    scheduleDate = json['scheduleDate'];
    scheduleTime = json['scheduleTime'];
    houseType = json['houseType'];
    pickupAddress = json['pickupAddress'] != null
        ? new PickupAddress.fromJson(json['pickupAddress'])
        : null;
    dropoffAddress = json['dropoffAddress'] != null
        ? new PickupAddress.fromJson(json['dropoffAddress'])
        : null;
    if (json['furniture'] != null) {
      furniture = <Furniture>[];
      json['furniture'].forEach((v) {
        furniture!.add(new Furniture.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offerPrice'] = this.offerPrice;
    data['scheduleDate'] = this.scheduleDate;
    data['scheduleTime'] = this.scheduleTime;
    data['houseType'] = this.houseType;
    if (this.pickupAddress != null) {
      data['pickupAddress'] = this.pickupAddress!.toJson();
    }
    if (this.dropoffAddress != null) {
      data['dropoffAddress'] = this.dropoffAddress!.toJson();
    }
    if (this.furniture != null) {
      data['furniture'] = this.furniture!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PickupAddress {
  double? latitude;
  double? longitude;
  String? address;

  PickupAddress({this.latitude, this.longitude, this.address});

  PickupAddress.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['address'] = this.address;
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
