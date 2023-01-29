import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitubs/models/TenantModel.dart';
import 'package:provider/provider.dart';

import '../../providers/tenant_provider.dart';
import '../dashboard.dart';

class EditTenant extends StatefulWidget {
  const EditTenant({Key? key, required this.tenant}) : super(key: key);
  final TenantModel tenant;

  @override
  State<EditTenant> createState() => _EditTenantState();
}

class _EditTenantState extends State<EditTenant> {
  TextEditingController newController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final tenantsProvider = Provider.of<TenantsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text("Name"),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Name"),
                    TextButton(onPressed: (){
                      String a="name";
                      _showMyDialog(tenantsProvider,a);
                    }, child: Text("Edit"))
                  ],
                ),
                Text("${widget.tenant.name}"),

              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text("Name"),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Amount Per Month"),
                    TextButton(onPressed: (){
                       String a="amount";
                       _showMyDialog(tenantsProvider,a);
                    }, child: Text("Edit"))
                  ],
                ),
                Text("${widget.tenant.amount}"),

              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text("Name"),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Phone Number"),
                    TextButton(onPressed: (){
                      String a="cell";
                      _showMyDialog(tenantsProvider,a);
                    }, child: Text("Edit"))
                  ],
                ),
                Text("${widget.tenant.cell}"),

              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog(tenantsProvider,key) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update $key'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: newController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // validator: (email) =>
                  // email != null && EmailValidator.validate(email)
                  //     ? null
                  //     : "Enter valid Email",
                  decoration: InputDecoration(
                    labelText: '$key',
                    // hintText: 'johndoe@gmail.com',
                    // Here is key idea
                    suffixIcon: IconButton(
                      icon: Icon(Icons.edit),
                      color: Colors.grey,
                      onPressed: () {},
                    ),
                  ),
                ),
                // Text('Would you like to continue?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Confirm'),
              onPressed: () async {
                print('Edit');
                await tenantsProvider.updateTenant(widget.tenant,key,newController.text);
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
