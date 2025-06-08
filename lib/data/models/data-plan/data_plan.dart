class DataPlan {
  String? provider;
  String? type;
  String? plan;
  String? validate;
  String? costPrice;
  String? salePrice;

  DataPlan(
    this.provider,
    this.type,
    this.plan,
    this.validate,
    this.costPrice,
    this.salePrice,
  );

  factory DataPlan.fromJson(Map<String, dynamic> json) {
    return DataPlan(
      json["provider"],
      json["type"],
      json["plan"],
      json["validate"],
      json["costPrice"],
      json["salePrice"],
    );
  }
}
