import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../screens/home/model/tenant_model.dart';
import '../services/tenant_service.dart';

class TenantsProvider extends ChangeNotifier{

  List<Tenant> listOfTenants = [];
  bool refetch = false;
  bool refetchBalance = false;
  bool showCircle = false;

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
    refetch = true;
    print(tenant);
    getAllTenants();
    notifyListeners();
  }

  Future<void> changeBalance(context,var tenant,paid) async {
    showCircle = true;

    var remain = int.parse(tenant.balance) - int.parse(paid);
    var data = {'balance': remain};
    await  tenantService.changeBalance(tenant,data);
    refetchBalance = true;
    print(tenant);
    getAllTenants();
    notifyListeners();
  }
}