class AllItemModel {
  double? totalCost;
  List<double>? costRange;

  AllItemModel({this.totalCost, this.costRange});

  AllItemModel.fromJson(Map<String, dynamic> json) {
    totalCost = json['total_cost'];
    costRange = json['cost_range'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_cost'] = this.totalCost;
    data['cost_range'] = this.costRange;
    return data;
  }
}
