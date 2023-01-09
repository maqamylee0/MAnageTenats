import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitubs/screens/home/model/payment_model.dart';
import 'package:kitubs/screens/home/model/tenant_model.dart';
import 'package:provider/provider.dart';

import '../../providers/payment_provider.dart';
import '../../providers/tenant_provider.dart';

class TenantDetail extends StatelessWidget {
  const TenantDetail({Key? key, required this.tenant}) : super(key: key);
final Tenant tenant;

  @override
  Widget build(BuildContext context) {
    TextEditingController paymentController = TextEditingController();
    final tenants = Provider.of<TenantsProvider>(context);
    final payments = Provider.of<PaymentProvider>(context);

    return Container(
      margin: EdgeInsets.all(20),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(10),
      //   color: Colors.white,
      //   border: Border(
      //     left: BorderSide(
      //       color: Colors.green,
      //     ),
      //   ),
      // ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.grey
      ),
      height: MediaQuery.of(context).size.height*0.7,
      padding: EdgeInsets.all(30),
    child: Column(



      children: [
        Container(
          padding: EdgeInsets.all(20),
          child: Text("Tenant Details"),
        ),
        SizedBox(
          height: 80,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(onPressed: (){

                  }, icon: Icon(Icons.call,size: 40,)),
                  SizedBox(width: 40,),
                  Text('${tenant.name}')
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 20,),
        SizedBox(
          height: 50,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('Phone Number:'),
                  Text('${tenant.cell}'),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 20,),

        SizedBox(
          height: 50,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('Amount Due:'),
                  Text('${tenant.balance}'),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 20,),

        SizedBox(
          height: 50,

            child: Card(

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text('Charge Per Month:'),
                    Text('${tenant.amount}'),
                  ],
                ),
              ),
            ),

        ),
        SizedBox(height: 20,),

        Text("Register payment"),
        SizedBox(height: 20,),

        TextFormField(
          controller: paymentController,
          keyboardType: TextInputType.number,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value)=>
          value == '' ? "Enter amount": null,
          decoration: InputDecoration(labelText: 'Amount'),

        ),
        SizedBox(height: 20,),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(onPressed: (){
             tenants.changeBalance(context,tenant,paymentController.text);
             Payment payment = Payment();
             payment.id='';
             payment.amount= paymentController.text;
             payment.payer = tenant.name;
             payment.date = DateTime.now().toString();
             payments.addPayment(context, payment.toMap());
            }, child: Text('PAY')),
            ElevatedButton(onPressed: (){


              Navigator.pop(context);
            }, child: Text('CLOSE'))
          ],
        ),




      ],
    ),
    );
  }
}
