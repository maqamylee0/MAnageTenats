import 'dart:developer';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:kitubs/providers/tenant_provider.dart';
import 'package:kitubs/screens/home/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
        DevicePreview(builder: (BuildContext context) {
         return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => TenantsProvider()),
            ],
            child: const MyApp(),
          ) ;
        }));


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

        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}
