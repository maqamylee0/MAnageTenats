import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitubs/models/ModelProvider.dart';
import 'package:kitubs/screens/dashboard.dart';
import 'package:kitubs/screens/home/home.dart';
import 'package:kitubs/screens/home/model/payment_model.dart';
import 'package:kitubs/screens/home/model/tenant_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../../providers/payment_provider.dart';
import '../../providers/tenant_provider.dart';
import 'agreement.dart';
import 'edit_tenant.dart';

class TenantDetail extends StatefulWidget {
  const TenantDetail({Key? key, required this.tenant}) : super(key: key);
final TenantModel tenant;

  @override
  State<TenantDetail> createState() => _TenantDetailState();
}

class _TenantDetailState extends State<TenantDetail> {
  @override
  Widget build(BuildContext context) {
    TextEditingController paymentController = TextEditingController();
    final tenants = Provider.of<TenantsProvider>(context);
    final payments = Provider.of<PaymentProvider>(context);

    return
      Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }
              , icon: Icon(Icons.arrow_back)),
          actions: [
            PopupMenuButton(
              // add icon, by default "3 dot" icon
              // icon: Icon(Icons.book)
                itemBuilder: (context){
                  return [
                    PopupMenuItem<int>(
                      value: 0,
                      child: Text("Agreement"),
                    ),

                    PopupMenuItem<int>(
                      value: 1,
                      child: Text("Delete"),
                    ),

                    PopupMenuItem<int>(
                      value: 2,
                      child: Text("Edit"),
                    ),
                  ];
                },
                onSelected:(value){
                  if(value == 0){
                    tenants.setkey(widget.tenant.key);

                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Agreement(tenant:widget.tenant)));
                  }else if(value == 1){
                    _showMyDialog(tenants);
                  }else if(value == 2){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>EditTenant(tenant:widget.tenant)));
                  }
                }
            ),

          ],
          title: Text("${widget.tenant.name}"),
        ),
        body: SingleChildScrollView(
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
                        UrlLauncher.launch('tel:${widget.tenant.cell}');
                        // print("twwww ${widget.tenant.cell}");

                        // UrlLauncher.launch("tel:${tenant.cell}");
                      }, icon: Icon(Icons.call,size: 40,)),
                      SizedBox(width: 10,),
                      Text('${widget.tenant.name}')
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 5,),
            SizedBox(
              height: 50,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text('Phone Number:'),
                      Text('${widget.tenant.cell}'),
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
                      Text('${widget.tenant.balance}'),
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
                        Text('${widget.tenant.amount}'),
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
                  var date = DateTime.now();
                  // print('ddddddddddddddddddd${date.year}-${date.month}-${date.day}Z');

                  tenants.updateBalance(context,widget.tenant,paymentController.text);
                 PaymentModel payment = PaymentModel(
                   amount: paymentController.text,
                   payer: widget.tenant.name,
                   date:  date.toString()
                 );
                 await payments.addPayment(context, payment);
                  Navigator
                      .of(context)
                      .pushReplacement(new MaterialPageRoute(builder: (BuildContext context) {
                    return  Dashboard();
                  }));
                }, child: Text('PAY')),
                // ElevatedButton(onPressed: (){
                //
                //
                //   Navigator.pop(context);
                // }, child: Text('CLOSE'))
              ],
            ),


            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     ElevatedButton(onPressed: (){
            //
            //       _showMyDialog(tenants);
            //     }, child: Text('DELETE')),
            //     ElevatedButton(onPressed: (){
            //
            //       _showMyDialog(tenants);
            //     }, child: Text('Agreement'))
            //   ],
            // )

          ],
    ),
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

  Future<void> _showMyDialog(tenantProvider) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete balances'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text('Are you sure you want to delete ${widget.tenant.name}.'),
                // Text('Would you like to continue?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Confirm'),
              onPressed: () async {
                print('Confirmed');
                await tenantProvider.deleteTenant(widget.tenant.id);
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Dashboard()));
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

