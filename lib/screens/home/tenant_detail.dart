import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitubs/screens/home/model/tenant_model.dart';

class TenantDetail extends StatelessWidget {
  const TenantDetail({Key? key, required this.tenant}) : super(key: key);
final Tenant tenant;

  @override
  Widget build(BuildContext context) {
    TextEditingController paymentController = TextEditingController();

    return Container(
      padding: EdgeInsets.all(20),
    child: Column(
      children: [
        Row(
          children: [
            IconButton(onPressed: (){

            }, icon: Icon(Icons.call,size: 50,)),
            Text('${tenant.name}')
          ],
        ),
        SizedBox(height: 20,),
        Row(
          children: [
            Text('Phone Number:'),
            Text('${tenant.cell}'),
          ],
        ),
        SizedBox(height: 20,),

        Row(
          children: [
            Text('Amount Due:'),
            Text('${tenant.balance}'),
          ],
        ),
        SizedBox(height: 20,),

        Row(
          children: [
            Text('Charge Per Month:'),
            Text('${tenant.balancedUp}'),
          ],
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

        ElevatedButton(onPressed: (){

        }, child: Text('PAY'))


      ],
    ),
    );
  }
}
