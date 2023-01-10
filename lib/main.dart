import 'dart:developer';

import 'package:cron/cron.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kitubs/providers/payment_provider.dart';
import 'package:kitubs/providers/tenant_provider.dart';
import 'package:kitubs/screens/dashboard.dart';
import 'package:kitubs/screens/home/home.dart';
import 'package:kitubs/screens/home/model/tenant_model.dart';
import 'package:kitubs/services/tenant_service.dart';
import 'package:provider/provider.dart';

void main() {
  bool updated = false;
  // if(updated == false){

  final cron = Cron();
    cron.schedule(Schedule.parse('0 0 1 * *'), ()  async{
      if (kDebugMode) {
        print(DateTime.now());
        increasePayment();
        updated = !updated;
      }});

  runApp(
        // DevicePreview(builder: (BuildContext context) {
        //  return

           MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => TenantsProvider()),
              ChangeNotifierProvider(create: (_) => PaymentProvider()),

            ],
            child: const MyApp(),
          ));
       // }
      // ));
  // }else{
  //   runApp(
  //       DevicePreview(builder: (BuildContext context) {
  //         return MultiProvider(
  //           providers: [
  //             ChangeNotifierProvider(create: (_) => TenantsProvider()),
  //             ChangeNotifierProvider(create: (_) => PaymentProvider()),
  //
  //           ],
  //           child: const MyApp(),
  //         ) ;
  //       }));
  // }


}

Future<void> increasePayment() async {
  TenantService tenantService = TenantService();
  List<Tenant> listOfTenants = await tenantService.getAllTenants();
  for(Tenant tenant in listOfTenants){
    var balance =(int.parse(tenant.balance! )   + int.parse(tenant.amount!)).toString();
    var data = {"balance": "${balance}"};
    await tenantService.changeBalance(tenant, data);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.amber,
      ),
      home: Dashboard(),
    );
  }
}
