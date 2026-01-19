class TermsConditionModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  TermsConditionModel({this.success, this.statusCode, this.message, this.data});

  TermsConditionModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  Content? content;
  String? createdAt;
  String? updatedAt;

  Data({this.id, this.content, this.createdAt, this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content =
    json['content'] != null ?
    Content.fromJson(json['content']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Content {
  List<Ops>? ops;

  Content({this.ops});

  Content.fromJson(Map<String, dynamic> json) {
    if (json['ops'] != null) {
      ops = <Ops>[];
      json['ops'].forEach((v) {
        ops!.add(new Ops.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ops != null) {
      data['ops'] = this.ops!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ops {
  String? insert;
  Attributes? attributes;

  Ops({this.insert, this.attributes});

  Ops.fromJson(Map<String, dynamic> json) {
    insert = json['insert'];
    attributes = json['attributes'] != null
        ? new Attributes.fromJson(json['attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['insert'] = this.insert;
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.toJson();
    }
    return data;
  }
}

class Attributes {
  int? header;
  bool? bold;
  String? list;
  bool? italic;

  Attributes({this.header, this.bold, this.list});

  Attributes.fromJson(Map<String, dynamic> json) {
    header = json['header'];
    bold = json['bold'];
    list = json['list'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['header'] = this.header;
    data['bold'] = this.bold;
    data['list'] = this.list;
    return data;
  }
}
