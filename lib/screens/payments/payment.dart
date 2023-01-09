import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitubs/screens/payments/widgets/big_pay.dart';
import 'package:provider/provider.dart';

import '../../providers/payment_provider.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final payments = Provider.of<PaymentProvider>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          title: Text("Payments"),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(5),
          child: payments.listOfPayments.isEmpty ?
          CircularProgressIndicator():
          ListView.builder(
              itemCount: payments.listOfPayments.length,
              itemBuilder: (context, index){
                return Column(
                  children: [
                    BigPay(payment: payments.listOfPayments[index],),
                    Divider()
                  ],
                );
              }
          ),
        ),
      ),
    );
  }
}
