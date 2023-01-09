import 'package:flutter/cupertino.dart';
import 'package:kitubs/providers/tenant_provider.dart';

import '../screens/home/model/payment_model.dart';
import '../services/payment_service.dart';

class PaymentProvider extends ChangeNotifier{
  List<Payment> listOfPayments = [];
  bool refetch = false;
  bool refetchBalance = false;

  var paymentService = PaymentService();
  var tenant = TenantsProvider();
  PaymentProvider(){
    getAllPayments();
  }

  Future<void> addPayment(context,var payment) async {
    await  paymentService.addPayment(context, payment);
    getAllPayments();
    tenant.getAllTenants();
    notifyListeners();
  }
  Future<void> getAllPayments() async {
    listOfPayments = await paymentService.getAllPayments();
    notifyListeners();
  }
}