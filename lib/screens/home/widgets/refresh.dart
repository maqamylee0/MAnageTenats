import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/tenant_provider.dart';

class Refresh extends StatefulWidget {
  const Refresh({Key? key}) : super(key: key);

  @override
  State<Refresh> createState() => _RefreshState();
}

class _RefreshState extends State<Refresh> {
  @override
  Widget build(BuildContext context) {
    final tenants = Provider.of<TenantsProvider>(context);

    return Container(
      child :SizedBox(
        width: 200,
        child: ElevatedButton(

          child: Text("Renew",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20),),
          onPressed: () async  {
            // tenants.setshowCircle = true;
            // await saveDetails(context,tenants);
              _showMyDialog(tenants);
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(50),


            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _showMyDialog(tenantProvider) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Renew balances'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text('Remember this is only done for a new month.'),
                Text('Would you like to continue?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Confirm'),
              onPressed: () async {
                print('Confirmed');
                await tenantProvider.renewBalance();
                Navigator.of(context).pop();
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
