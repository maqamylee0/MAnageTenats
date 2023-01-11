import 'dart:developer';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
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
import 'package:workmanager/workmanager.dart';

import 'amplifyconfiguration.dart';
import 'models/ModelProvider.dart';

// // @pragma('vm:entry-point')
// void callbackDispatcher(){
//   Workmanager().executeTask((taskname,inputData) async {
//     print("Task executed $taskname");
//     await increasePayment();
//     return Future.value(true);
//   });
// }
// Future<void> increasePayment() async {
//   TenantService tenantService = TenantService();
//   List<Tenant> listOfTenants = await tenantService.getAllTenants();
//   for(Tenant tenant in listOfTenants){
//     var balance =(int.parse(tenant.balance!)   + int.parse(tenant.amount!)).toString();
//     var data = {"balance": "${balance}"};
//     await tenantService.changeBalance(tenant, data);
//   }
// }
Future<void> _configureAmplify() async {
  try{
    final _dataStorePlugin = AmplifyDataStore(modelProvider: ModelProvider.instance);
    final apiPlugin = AmplifyAPI();
    final amplifyAuthCognito = AmplifyAuthCognito();
    await Amplify.addPlugins([amplifyAuthCognito,_dataStorePlugin,]);
    await  Amplify.configure(amplifyconfig);
  }catch(e){
    print('Failed to configure Amplify $e');
  }}
Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();
await _configureAmplify();

  bool updated = false;
  // if(updated == false){
  // final cron = Cron();
  // //0 0 1 * *
  //   cron.schedule(Schedule.parse('*/1 * * * *'), ()  async{
  //     await Workmanager().initialize(callbackDispatcher);
  //    await  Workmanager().registerOneOffTask('test', 'task',constraints:Constraints(networkType: NetworkType.connected));
  //     if (kDebugMode) {
  //       print(DateTime.now());
  //       // increasePayment();
  //       updated = !updated;
  //     }});

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



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Authenticator(
      child: MaterialApp(
        builder: Authenticator.builder(),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home: Dashboard(),
      ),
    );
  }
}
