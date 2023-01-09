import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitubs/screens/home/widgets/big_post.dart';
import 'package:provider/provider.dart';

import '../../providers/tenant_provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final tenants = Provider.of<TenantsProvider>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          title: Text("Tenants"),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: tenants.listOfTenants.isEmpty ?
          CircularProgressIndicator():
          ListView.builder(
              itemCount: tenants.listOfTenants.length,
              itemBuilder: (context, index){
                return Column(
                  children: [
                    BigPost(tenant: tenants.listOfTenants[index],),
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
