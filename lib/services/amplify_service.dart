
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
}