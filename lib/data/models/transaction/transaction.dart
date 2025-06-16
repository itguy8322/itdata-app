// ignore_for_file: non_constant_identifier_names

class Transaction {
  String? id;
  String? type;
  String? service;
  String? provider;
  String? amount;
  String? tel;
  String? pin;
  String? plan;
  String? units;
  String? status;
  String? date;
  Transaction({
    this.id,
    this.type,
    this.service,
    this.provider,
    this.amount,
    this.tel,
    this.pin,
    this.plan,
    this.units,
    this.status,
    this.date,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      type: json['type'],
      service: json['service'],
      provider: json['provider'],
      amount: json['amount'],
      tel: json['tel'],
      pin: json['pin'],
      plan: json['plan'],
      units: json['units'],
      status: json['status'],
      date: json['date'],
    );
  }

  static Map<String, dynamic> toJson(Transaction transaction) {
    return {
      "id": transaction.id,
      "type": transaction.type,
      "service": transaction.service,
      "provider": transaction.provider,
      "amount": transaction.amount,
      "tel": transaction.tel,
      "pin": transaction.pin,
      "plan": transaction.plan,
      "units": transaction.units,
      "status": transaction.status,
      "date": transaction.date,
    };
  }
}
