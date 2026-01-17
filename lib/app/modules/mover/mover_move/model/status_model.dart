class MoverStatusModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  MoverStatusModel({this.success, this.statusCode, this.message, this.data});

  MoverStatusModel.fromJson(Map<String, dynamic> json) {
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
  String? currentMoveStatus;
  List<String>? completedMoveStatuses;
  bool? isCompleted;

  Data(
      {this.id,
        this.currentMoveStatus,
        this.completedMoveStatuses,
        this.isCompleted});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    currentMoveStatus = json['currentMoveStatus'];
    completedMoveStatuses = json['completedMoveStatuses'].cast<String>();
    isCompleted = json['isCompleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['currentMoveStatus'] = this.currentMoveStatus;
    data['completedMoveStatuses'] = this.completedMoveStatuses;
    data['isCompleted'] = this.isCompleted;
    return data;
  }
}
