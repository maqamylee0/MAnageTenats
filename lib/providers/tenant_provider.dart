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
  num totalAmount = 0;
  num advance = 0;
  String path = '';
  String key = '';

  late StreamSubscription<QuerySnapshot<TenantModel>> _subscription;

  var tenantService = TenantService();
  var amplifyService = AmplifyService();

  TenantsProvider(){
    getAllTenants();
    calculateTotal();
    getUrlForFile();
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
         totalAmount = 0;
         advance=0;
         calculateTotal();
        notifyListeners();
    });

    // listOfTenants = await tenantService.getAllTenants();
    notifyListeners();
  }
  void calculateTotal(){
    listOfTenants.forEach((element) {
      int total = int.parse(element.balance!);
      if(total! < 0){
        advance = advance + total;
      }else {
        totalAmount = totalAmount + total ;

      }
      notifyListeners();
    });
  }

  Future<void> addTenants(context,var tenant) async {
    // await  tenantService.addTenants(context, tenant);
    await amplifyService.saveTenant(tenant);
    refetch = true;
    print(tenant);
    getAllTenants();
    notifyListeners();
  }
  void setkey(key){
    key = key;
    notifyListeners();
  }
  Future<String> getUrlForFile() async {
    try {
      final result = await Amplify.Storage.getUrl(key: key);
      key = result.url;
      print('paaaaaaaaaaaaaaaaaaaa ${result.url}');
       notifyListeners();

      return result.url;

    } catch (e) {

      safePrint('An error occurred while saving Todo: $e');
      throw(e);
    }
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

  Future<void> renewBalance( ) async {
    showCircle = true;

    listOfTenants.forEach((element) async {
      int monthly = int.parse(element.amount!);
      var newBalance = int.parse(element.balance!) + monthly;
      await  amplifyService.updateAmount(element,newBalance.toString());

      notifyListeners();
    });
    refetchBalance = true;
    getAllTenants();
    notifyListeners();

  }
  Future<void> deleteTenant(id ) async {
    showCircle = true;
      await  amplifyService.deleteTenantWithId(id);
      notifyListeners();
    refetchBalance = true;
    getAllTenants();
    notifyListeners();

  }

  Future<void> updateBalance(context,var tenant,paid) async {
    showCircle = true;

    var remain = int.parse(tenant.balance) - int.parse(paid);
    await  amplifyService.updateAmount(tenant,remain.toString());
    refetchBalance = true;
    // print(tenant);
    getAllTenants();
    notifyListeners();
  }

  // void getImageUrl() {}

  // Future<void> getImageUrl() async {
  //   path = await amplifyService.getUrlForFile(key);
  //   notifyListeners();
  // }


}