class MoverSearsePostModel {
  bool? success;
  int? statusCode;
  String? message;
  List<Data>? data;

  MoverSearsePostModel(
      {this.success, this.statusCode, this.message, this.data});

  MoverSearsePostModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
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
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? city;
  String? state;
  String? country;
  double? latitude;
  double? longitude;

  Data({this.city, this.state, this.country, this.latitude, this.longitude});

  Data.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    state = json['state'];
    country = json['country'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
