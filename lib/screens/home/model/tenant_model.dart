import 'dart:core';

class Tenant{
  String? id;
  String? name;
  String? amount;
  String? cell;
  String? balance;
  String? remaining;

  Tenant({this.id, this.name, this.amount, this.cell, this.balance,
      this.remaining});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'amount': this.amount,
      'cell': this.cell,
      'balance': this.balance,
      'remaining': this.remaining,
    };
  }

  factory Tenant.fromJson(Map<String, dynamic> map) {
    return Tenant(
      id: map['id'] as String,
      name: map['name'] as String,
      amount: map['amount'] as String,
      cell: map['cell'] as String,
      balance: map['balance'] as String,
      remaining: map['remaining'] as String,
    );
  }
}