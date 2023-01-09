import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitubs/screens/home/home.dart';
import 'package:kitubs/screens/payments/payment.dart';

import 'add_tenant/add_tenant.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: IndexedStack(
        children: [
          Home(),

          AddTenant(),
          PaymentPage()

          // Notifications()
        ],
        index: _currentIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index){
          // Navigator.pop(context);
          setState(()=>_currentIndex = index);
        },
        items:  [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline_sharp),
              label: "Tenants"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on_rounded),
              label: "Payments"
          ),
          // BottomNavigationBarItem(
          //     icon: FaIcon(FontAwesomeIcons.clock,color: Colors.brown,),
          //     label: "Notifications"
          // ),

        ],
      ),

    );
  }
}
