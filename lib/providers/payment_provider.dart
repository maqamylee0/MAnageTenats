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
  bool refetch = false;
  bool refetchBalance = false;
  late StreamSubscription<QuerySnapshot<PaymentModel>> _subscriptionPayments;
  var amplifyService = AmplifyService();
 bool showCircle = false;
  var paymentService = PaymentService();
  var tenant = TenantsProvider();
  PaymentProvider(){
    getAllpayments();
  }
  set setshowCircle(bool value) {
    showCircle = value;
    notifyListeners();
  }
  Future<void> getAllpayments() async {
    _subscriptionPayments = Amplify.DataStore.observeQuery(PaymentModel.classType)
        .listen((QuerySnapshot<PaymentModel> snapshot) {
      setshowCircle = false ;
      listOfPayments = snapshot.items;
      print('paymeeeeeeeeeeeeeeeeeeeeeeeee ${listOfPayments[0].payer}');

      print(listOfPayments);
      notifyListeners();
    });}


    Future<void> addPayment(context,PaymentModel payment) async {
      // await  tenantService.addTenants(context, tenant);
      await amplifyService.savePayment(payment);
      refetch = true;
      print('paymeeeeeeeeeeeeeeeeeeeeeeeee ${payment.payer}');
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
}