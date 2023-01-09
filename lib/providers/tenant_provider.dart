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
  Future<void> addTenants(context,var tenant) async {
    await  tenantService.addTenants(context, tenant);
    print(tenant);
    notifyListeners();
  }
  Future<void> changeBalance(context,Tenant tenant,paid) async {
    await  tenantService.changeBalance(context, tenant,paid);
    print(tenant);
    notifyListeners();
  }
}