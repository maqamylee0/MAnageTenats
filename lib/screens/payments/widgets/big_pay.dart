import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitubs/models/ModelProvider.dart';
import 'package:kitubs/screens/home/model/payment_model.dart';

class BigPay extends StatelessWidget {
  const BigPay({Key? key,  required this.payment}) : super(key: key);
final PaymentModel payment;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.amber),
            borderRadius: BorderRadius.circular(10)
      ),

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Icon(Icons.receipt_long_outlined,size: 30,),
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
      );

  }
}
