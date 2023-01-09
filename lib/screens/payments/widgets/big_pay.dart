import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitubs/screens/home/model/payment_model.dart';

class BigPay extends StatelessWidget {
  const BigPay({Key? key,  required this.payment}) : super(key: key);
final Payment payment;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Icon(Icons.receipt_long_outlined),
                  SizedBox(height: 10,),
                  Text('${payment.date}'),
                ],
              ),
              SizedBox(height: 20,),
              Column(
                children: [
                  Text('${payment.payer?.toUpperCase()}'),
                  SizedBox(height: 10,),
                  Text('${payment.amount}'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
