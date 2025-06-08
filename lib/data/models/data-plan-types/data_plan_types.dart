class DataPlanTypes {
  final String? mtn;
  final String? glo;
  final String? nineMobile;
  final String? airtel;
  DataPlanTypes(this.mtn, this.glo, this.nineMobile, this.airtel);

  static Map<String, dynamic> toJson(DataPlanTypes dataPlanTypes) {
    return {
      dataPlanTypes.mtn!: "MTN",
      dataPlanTypes.glo!: "GLO",
      dataPlanTypes.nineMobile!: "9MOBILE",
      dataPlanTypes.airtel!: "AIRTEL",
    };
  }
}
