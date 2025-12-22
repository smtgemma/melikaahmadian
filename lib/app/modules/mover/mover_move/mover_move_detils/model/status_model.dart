class StatusModel {
  String statusString;
  int sttus;
  bool? statusStatus ;

  StatusModel({
    required this.statusString,
    required this.sttus,
    this.statusStatus
  });

  StatusModel copyWith({
    String? statusString,
    int? sttus,
    bool? statusStatus
  }) {
    return StatusModel(
      statusString: statusString ?? this.statusString,
      sttus: sttus ?? this.sttus,
      statusStatus: statusStatus ?? this.statusStatus);
  }
}
