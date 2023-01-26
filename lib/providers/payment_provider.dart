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
  num total = 0;

  PaymentProvider(){
    getAllpayments();
  }
  
  set setshowCircle(bool value) {
    showCircle = value;
    notifyListeners();
    sumPayments();
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
    for (var element in listOfPayments) {
      TemporalDate froDate = TemporalDate(fromDate);
      if(element.date!.compareTo(froDate) > 0){
        listOfPaymentsFrom.add(element);
        listOfPaymentsFromdummy.add(element);

        print("DT1 is after DT2");
      }
    }
    notifyListeners();
    sumPayments();

  }
  void filterPaymentsTo(){
    for (var element in listOfPaymentsFromdummy) {
      TemporalDate tooDate = TemporalDate(toDate);
      if(element.date!.compareTo(tooDate) >= 0){
        listOfPaymentsFrom.remove(element);

      }
    }
    notifyListeners();
    sumPayments();

  }
  void sumPayments(){
    total = 0;

    if(filter){
      for (var element in listOfPaymentsFrom) {
        total = total + int.parse(element.amount!);
        notifyListeners();
      }
    }else{
      for (var element in listOfPayments) {
        total = total + int.parse(element.amount!);
        notifyListeners();
      }
    }

  }
}