import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitubs/models/ModelProvider.dart';
import 'package:kitubs/screens/dashboard.dart';
import 'package:kitubs/screens/home/model/payment_model.dart';
import 'package:kitubs/screens/home/model/tenant_model.dart';
import 'package:provider/provider.dart';

import '../../models/TenantModel.dart';
import '../../providers/payment_provider.dart';
import '../../providers/tenant_provider.dart';

class TenantDetail extends StatelessWidget {
  const TenantDetail({Key? key, required this.tenant}) : super(key: key);
final TenantModel tenant;

  @override
  Widget build(BuildContext context) {
    TextEditingController paymentController = TextEditingController();
    final tenants = Provider.of<TenantsProvider>(context);
    final payments = Provider.of<PaymentProvider>(context);

    return
      SingleChildScrollView(
        child: Container(
        margin: EdgeInsets.all(10),
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
        height: MediaQuery.of(context).size.height*0.8,
        padding: EdgeInsets.all(20),
    child: Column(



        children: [
          Container(
            padding: EdgeInsets.all(10),
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
          SizedBox(height: 10,),

          TextFormField(
            controller: paymentController,
            keyboardType: TextInputType.number,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value)=>
            value == '' ? "Enter amount": null,
            decoration: InputDecoration(labelText: 'Amount'),

          ),
          SizedBox(height: 10,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(onPressed: () async {
                // showLoaderDialog(context);
               tenants.updateBalance(context,tenant,paymentController.text);
               PaymentModel payment = PaymentModel(
                 amount: paymentController.text,
                 payer: tenant.name,
                 date: DateTime.now().toString()
               );

               await payments.addPayment(context, payment);
                Navigator
                    .of(context)
                    .pushReplacement(new MaterialPageRoute(builder: (BuildContext context) {
                  return  Dashboard();
                }));
              }, child: Text('PAY')),
              ElevatedButton(onPressed: (){


                Navigator.pop(context);
              }, child: Text('CLOSE'))
            ],
          ),




        ],
    ),
    ),
      );
  }

  void showLoaderDialog(BuildContext context) {
      AlertDialog alert=AlertDialog(
        content: new Row(
          children: [
            CircularProgressIndicator(),
            Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
          ],),
      );
      showDialog(barrierDismissible: false,
        context:context,
        builder:(BuildContext context){
          return alert;
        },
      );
    }
  }

