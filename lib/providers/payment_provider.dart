import 'dart:async';

import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:kitubs/models/ModelProvider.dart';
import 'package:kitubs/providers/tenant_provider.dart';

import '../models/TenantModel.dart';
import '../screens/home/model/payment_model.dart';
import '../services/amplify_service.dart';
import '../services/payment_service.dart';

class PaymentProvider extends ChangeNotifier{
  List<PaymentModel> listOfPayments = [];
  List<PaymentModel> listOfPaymentsFrom = [];
  List<PaymentModel> listOfPaymentsFromdummy = [];

  bool refetch = false;
  bool refetchBalance = false;
  late StreamSubscription<QuerySnapshot<PaymentModel>> _subscriptionPayments;
  var amplifyService = AmplifyService();
 bool showCircle = false;
  var paymentService = PaymentService();
  var tenant = TenantsProvider();
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  bool filter = false;
  bool filter2 = false;
  num total = 0;

  PaymentProvider(){
    getAllpayments();
  }
  
  set setshowCircle(bool value) {
    showCircle = value;
    notifyListeners();
    sumPayments();
  }
   void setfilter(bool value){
    filter= value;
    notifyListeners();
   }
  void setfilter2(bool value){
    filter2 = value;
    notifyListeners();
  }
  void setfromDates(value) {
    fromDate = value;
    notifyListeners();
  }
  void setToDate(value) {
    toDate = value;
    notifyListeners();
  }
  Future<void> getAllpayments() async {
    _subscriptionPayments = Amplify.DataStore.observeQuery(PaymentModel.classType)
        .listen((QuerySnapshot<PaymentModel> snapshot) {
      setshowCircle = false ;
      listOfPayments = snapshot.items;
      // print('paymeeeeeeeeeeeeeeeeeeeeeeeee ${listOfPayments[0].payer}');
      // print(listOfPayments);
      notifyListeners();
      sumPayments();

    });}


    Future<void> addPayment(context,PaymentModel payment) async {
      // await  tenantService.addTenants(context, tenant);
      await amplifyService.savePayment(payment);
      refetch = true;
      // print('paymeeeeeeeeeeeeeeeeeeeeeeeee ${payment.payer}');
      getAllpayments();
      notifyListeners();
    }
  // Future<void> addPayment(context,var payment) async {
  //   await  paymentService.addPayment(context, payment);
  //   getAllPayments();
  //   tenant.getAllTenants();
  //   notifyListeners();
  // }
  // Future<void> getAllPayments() async {
  //   listOfPayments = await paymentService.getAllPayments();
  //   notifyListeners();
  // }
  void filterPaymentsFrom(){
    listOfPaymentsFrom =[];
    for (var element in listOfPayments) {
      DateTime elementDate = DateTime.parse(element.date!);
      if(elementDate.compareTo(fromDate) >= 0){
        listOfPaymentsFrom.add(element);
        // print("DT1 is after DT2");
      }
    }
    filterPaymentsTo();
    notifyListeners();

  }
  void filterPaymentsTo(){
    listOfPaymentsFrom = [];
    for (var element in listOfPayments) {
      DateTime elementDate = DateTime.parse(element.date!);
      if(elementDate.compareTo(fromDate) >= 0 ){
        listOfPaymentsFrom.add(element);
        notifyListeners();
        // print("DT1 is after DT2");
      }
    }
    // print("payyyeyeyyeyfrom ${listOfPaymentsFrom.length}");
    listOfPaymentsFromdummy = [];

    for (var element in listOfPaymentsFrom) {
      // toDate.add(Duration(days: 1));
      DateTime elementDate = DateTime.parse(element.date!);
      DateTime torDate = toDate.add(Duration(days: 1));
      if(elementDate.compareTo(torDate) < 0 ){
        // listOfPaymentsFrom.remove(element);
        listOfPaymentsFromdummy.add(element);

      }
    }
    // print("payyyeyeyyeydummy ${listOfPaymentsFromdummy.length}");

    notifyListeners();
    sumPayments();

  }
  void sumPayments(){
    total = 0;

   if (filter) {
      for (var element in listOfPaymentsFromdummy) {
        total = total + int.parse(element.amount!);
        notifyListeners();
      }
    }else
      {
        for (var element in listOfPayments) {
          total = total + int.parse(element.amount!);
          notifyListeners();
        }
      }
    }

  }
