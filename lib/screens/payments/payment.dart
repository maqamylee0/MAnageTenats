import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitubs/screens/payments/widgets/big_pay.dart';
import 'package:provider/provider.dart';

import '../../providers/payment_provider.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  // TimeOfDay time = TimeOfDay(hour: 8, minute: 00);
  // DateTime date = DateTime(2023);
  // DateTime date1 = DateTime(2023);

  @override
  Widget build(BuildContext context) {
    final payments = Provider.of<PaymentProvider>(context);

    return Scaffold(
      appBar: PreferredSize(


        preferredSize: Size.fromHeight(80),
        child: AppBar(

          actions: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                child: IconButton(
                  icon: Icon(Icons.filter),
                  onPressed: () {
                    payments.filter= false;
                  },

                ),
              ),
            )
          ],
          title: Column(
            children: [
              SizedBox(height: 30,),
              Text("Payments",style: TextStyle(fontSize: 25),),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: payments.listOfPayments.isEmpty ?
          CircularProgressIndicator():
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("From",style: TextStyle(fontSize: 15),),
                  Text("To",style: TextStyle(fontSize: 15)),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_drop_down),
                        color: Colors.grey,
                        onPressed: () {
                          _showDatePicker(payments);

                        },
                      ),
                      Text("${payments.fromDate.day} / ${payments.fromDate.month} / ${payments.fromDate.year}")
                    ],
                  ),
                  SizedBox(width: 20,),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_drop_down),
                        color: Colors.grey,
                        onPressed: () {
                          _showDatePicker1(payments);

                        },
                      ),
                      Text("${payments.toDate.day} / ${payments.toDate.month} / ${payments.toDate.year}")
                    ],
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: payments.filter ? payments.listOfPaymentsFrom.length: payments.listOfPayments.length,
                    itemBuilder: (context, index){
                      return Column(
                        children: [
                          BigPay(payment:payments.filter ? payments.listOfPaymentsFrom[index] : payments.listOfPayments[index],),
                          Divider()
                        ],
                      );
                    }
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                // color: Colors.cyan,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      // color: Colors.cyan,
                      child: Text(
                          "Total Amount for Payments :",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15,)
                      ),
                    ),

                    Container(
                      // color:Colors.cyan ,
                      child: Text(
                          "${payments.total}",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15,color: Colors.green)
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  _showDatePicker(payment){
    payment.filter = true;
    showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2025)
    ).then((value) {
       payment.setfromDates(value) ;
      payment.filterPaymentsFrom();
       payment.filterPaymentsTo();
    }
        // setState((){
        //   date  = value!  ;
        //
        // }

        );

  }
  _showDatePicker1(payment){
    payment.filter = true;
    showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2025)
    ).then((value) {
      // print('lllll $value');
      payment.setToDate(value);
      payment.filterPaymentsFrom();
      payment.filterPaymentsTo();
    }
        // setState((){
        //   date1  = value!  ;
        // }
        // )

    );
  }
}
