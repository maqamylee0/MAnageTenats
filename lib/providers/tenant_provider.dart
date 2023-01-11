import 'dart:async';

import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:kitubs/models/ModelProvider.dart';
import 'package:kitubs/services/amplify_service.dart';
import 'package:provider/provider.dart';

import '../screens/home/model/tenant_model.dart';
import '../services/tenant_service.dart';

class TenantsProvider extends ChangeNotifier{

  List<TenantModel> listOfTenants = [];
  bool refetch = false;
  bool refetchBalance = false;
  bool showCircle = false;

  late StreamSubscription<QuerySnapshot<TenantModel>> _subscription;

  var tenantService = TenantService();
  var amplifyService = AmplifyService();

  TenantsProvider(){
    getAllTenants();
  }

  set setshowCircle(bool value) {
    showCircle = value;
    notifyListeners();
  }

  Future<void> getAllTenants() async {
    _subscription = Amplify.DataStore.observeQuery(TenantModel.classType)
        .listen((QuerySnapshot<TenantModel> snapshot) {
         setshowCircle = false ;
        listOfTenants = snapshot.items;
        notifyListeners();
    });

    // listOfTenants = await tenantService.getAllTenants();
    notifyListeners();
  }
  Future<void> addTenants(context,var tenant) async {
    // await  tenantService.addTenants(context, tenant);
    await amplifyService.saveTenant(tenant);
    refetch = true;
    print(tenant);
    getAllTenants();
    notifyListeners();
  }

  // Future<void> changeBalance(context,var tenant,paid) async {
  //   showCircle = true;
  //
  //   var remain = int.parse(tenant.balance) - int.parse(paid);
  //   var data = {'balance': remain};
  //   await  tenantService.changeBalance(tenant,data);
  //   refetchBalance = true;
  //   print(tenant);
  //   getAllTenants();
  //   notifyListeners();
  // }
  Future<void> updateBalance(context,var tenant,paid) async {
    showCircle = true;

    var remain = int.parse(tenant.balance) - int.parse(paid);
    await  amplifyService.updateAmount(tenant,remain.toString());
    refetchBalance = true;
    print(tenant);
    getAllTenants();
    notifyListeners();
  }
}