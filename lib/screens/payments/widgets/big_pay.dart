import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kitubs/models/ModelProvider.dart';
import 'package:kitubs/screens/home/model/payment_model.dart';

class BigPay extends StatelessWidget {
  const BigPay({Key? key,  required this.payment}) : super(key: key);
final PaymentModel payment;
  @override
  Widget build(BuildContext context) {
    final formatCurrency = new NumberFormat.currency(locale: 'en_UG', symbol: "",decimalDigits: 1);
       DateTime dateTime = DateTime.parse(payment.date!);

    // TemporalDate? t = payment.date;
    // DateTime ti = t.toDate();
    // var time = DateFormat.jm().format(ti);
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.amber),
            borderRadius: BorderRadius.circular(10)
      ),

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('${ DateFormat.yMEd().add_jms().format(dateTime)
                  }'),

              Column(
                children: [
                  Icon(Icons.receipt_long_outlined,size: 30,),
                  SizedBox(height: 10,),
                ],
              ),
              SizedBox(height: 20,),
              Column(
                children: [
                  Text('${payment.payer?.toUpperCase()}'),
                  SizedBox(height: 10,),
                  Text('${formatCurrency.format(int.parse(payment.amount!))}'),
                ],
              )
            ],
          ),
        ),
      );

  }
}
