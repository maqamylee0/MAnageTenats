import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kitubs/screens/add_tenant/add_tenant.dart';
import 'package:kitubs/screens/home/widgets/big_post.dart';
import 'package:kitubs/screens/home/widgets/refresh.dart';
import 'package:provider/provider.dart';

import '../../providers/tenant_provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final tenants = Provider.of<TenantsProvider>(context);
    final formatCurrency = new NumberFormat.currency(locale: 'en_UG', symbol: "",decimalDigits: 1);

    return Scaffold(
      // appBar: PreferredSize(
      //
      //   preferredSize: Size.fromHeight(80),
      //   child: AppBar(
      //     title: Column(
      //       children: [
      //         SizedBox(height: 30,),
      //         Text("Tenants",style: TextStyle(fontSize: 25),),
      //       ],
      //     ),
      //   ),
      // ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: tenants.listOfTenants.isEmpty ?
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(child: Text("No Tenants Yet",style: TextStyle(fontSize: 20,color: Colors.green),)),


              // Center(child: CircularProgressIndicator()

            ],
          ):
          Column(
            children: [
              GestureDetector(
                onTap: (){
                  showModalBottomSheet(

                      context: context, builder: (BuildContext context){
                    return Refresh();});


                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.cyan,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // color: Colors.cyan,
                        child: Text(
                            "Tenant Name",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15)
                        ),
                      ),
                      Container(
                        // color:Colors.cyan ,
                        child: Text(
                            "Amount Due",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15)
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Expanded(
                child: ListView.builder(
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
              Container(
                padding: EdgeInsets.all(10),
                // color: Colors.cyan,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      // color: Colors.cyan,
                      child: Text(
                          "Total Amount :",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 10,)
                      ),
                    ),
                    Container(
                      // color:Colors.cyan ,
                      child: Text(
                          "${formatCurrency.format(tenants.advance)}",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15,color: Colors.red)
                      ),
                    ),
                    Container(
                      // color:Colors.cyan ,
                      child: Text(
                          "${formatCurrency.format(tenants.totalAmount)}",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15,color: Colors.green)
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
}
