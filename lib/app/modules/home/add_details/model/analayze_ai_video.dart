class AnalayzeAiVideo {
  List<Items>? items;
  int? totalVolumeCubicFeet;

  AnalayzeAiVideo({this.items, this.totalVolumeCubicFeet});

  AnalayzeAiVideo.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    totalVolumeCubicFeet = json['total_volume_cubic_feet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['total_volume_cubic_feet'] = this.totalVolumeCubicFeet;
    return data;
  }
}

class Items {
  String? name;
  int? quantity;
  String? size;
  String? category;

  Items({this.name, this.quantity, this.size, this.category});

  Items.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    quantity = json['quantity'];
    size = json['size'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    data['size'] = this.size;
    data['category'] = this.category;
    return data;
  }
}
