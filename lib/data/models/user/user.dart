// ignore_for_file: non_constant_identifier_names

class UserData {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  double? wallet_bal;
  String? bvn;
  String? nin;
  String? pin;
  List<Map<String, dynamic>>? permanentAccounts;
  UserData({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.wallet_bal,
    this.bvn,
    this.nin,
    this.pin,
    this.permanentAccounts,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      wallet_bal: double.tryParse("${json['wallet_bal']}"),
      bvn: json['bvn'],
      nin: json['nin'],
      pin: json['pin'],
      permanentAccounts: json['permanentAccounts'],
    );
  }

  static Map<String, dynamic> fromUserData(UserData user) {
    return {
      "id": user.id,
      "name": user.name,
      "email": user.email,
      "phone": user.phone,
      "address": user.address,
      "wallet_bal": user.wallet_bal,
      "bvn": user.bvn,
      "nin": user.nin,
      "pin": user.pin,
      "permanentAccounts": user.permanentAccounts,
    };
  }
}
