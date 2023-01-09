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
    child: Column(
      children: [
        Row(
          children: [
            IconButton(onPressed: (){

            }, icon: Icon(Icons.call,size: 50,)),
            Text('${tenant.name}')
          ],
        ),
        Row(
          children: [
            Text('Phone Number:'),
            Text('${tenant.cell}'),
          ],
        ),
        Row(
          children: [
            Text('Amount Due:'),
            Text('${tenant.balance}'),
          ],
        ),
        Row(
          children: [
            Text('Charge Per Month:'),
            Text('${tenant.balancedUp}'),
          ],
        ),
        Text("Register payment"),
        TextFormField(
          controller: paymentController,
          keyboardType: TextInputType.number,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value)=>
          value == '' ? "Enter amount": null,
          decoration: InputDecoration(labelText: 'Amount'),

        ),
        ElevatedButton(onPressed: (){

        }, child: Text('PAY'))


      ],
    ),
    );
  }
}
