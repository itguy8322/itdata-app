class NetworkProviders {
  final String? mtn;
  final String? glo;
  final String? nineMobile;
  final String? airtel;
  NetworkProviders(this.mtn, this.glo, this.nineMobile, this.airtel);

  static Map<String, dynamic> toJson(NetworkProviders networkProviders) {
    return {
      networkProviders.mtn!: "MTN",
      networkProviders.glo!: "GLO",
      networkProviders.nineMobile!: "9MOBILE",
      networkProviders.airtel!: "AIRTEL",
    };
  }
}
