import 'dart:core';

class Payment{
  String? id;
  String? payer;
  String? amount;
  String? date;

  Payment({this.id, this.payer, this.amount,this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'payer': this.payer,
      'amount': this.amount,
      'date': this.date
    };
  }

  factory Payment.fromJson(Map<String, dynamic> map) {
    return Payment(
      id: map['id'] as String,
      payer: map['payer'] as String,
      amount: map['amount'] as String,
      date: map['date'] as String
    );
  }
}