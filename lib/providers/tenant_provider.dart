import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../screens/home/model/tenant_model.dart';
import '../services/tenant_service.dart';

class TenantsProvider extends ChangeNotifier{

  List<Tenant> listOfTenants = [];

  var tenantService = TenantService();

  TenantsProvider(){
    getAllTenants();
  }

  Future<void> getAllTenants() async {
    listOfTenants = await tenantService.getAllTenants();
    notifyListeners();
  }
}