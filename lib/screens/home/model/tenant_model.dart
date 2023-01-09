import 'dart:core';

class Tenant{
  String? id;
  String? name;
  String? amount;
  String? cell;
  String? balance;
  String? balancedUp;

  Tenant({this.id, this.name, this.amount, this.cell, this.balance,
      this.balancedUp});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'amount': this.amount,
      'cell': this.cell,
      'balance': this.balance,
      'balancedUp': this.balancedUp,
    };
  }

  factory Tenant.fromJson(Map<String, dynamic> map) {
    return Tenant(
      id: map['ID'] as String,
      name: map['NAME'] as String,
      amount: map['AMOUNT'] as String,
      cell: map['CELL'] as String,
      balance: map['BALANCE'] as String,
      balancedUp: map['BALANCEdUP'] as String,
    );
  }
}