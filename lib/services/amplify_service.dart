
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:kitubs/models/ModelProvider.dart';

class AmplifyService{

  Future<void> saveTenant(TenantModel tenant) async {

    try {

      await Amplify.DataStore.save(tenant);

    } catch (e) {
      safePrint('An error occurred while saving Todo: $e');
    }
  }
  Future<void> savePayment(PaymentModel payment) async {

    try {
      await Amplify.DataStore.save(payment);

    } catch (e) {
      safePrint('An error occurred while saving Todo: $e');
    }
  }
  Future<void> updateAmount(TenantModel tenant,balance) async {

    final updatedAmount = tenant.copyWith(balance: balance);
    try {

      // to update data in DataStore, you again pass an instance of a model to
      // Amplify.DataStore.save()
      await Amplify.DataStore.save(updatedAmount);
    } catch (e) {
      safePrint('An error occurred while saving Todo: $e');
    }
  }

  void calculateTotal(){

  }
}