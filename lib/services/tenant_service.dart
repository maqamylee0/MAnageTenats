import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:kitubs/screens/dashboard.dart';
import 'package:kitubs/screens/home/home.dart';

import 'package:kitubs/screens/home/model/tenant_model.dart';

class TenantService {
  final _baseUrl = "https://sheetdb.io/api/v1/";


  Future<List<Tenant>> getAllTenants() async {
    var listToBeReturned = <Tenant>[];

    try {
      var endpoint = "0gozoxhv6c9yi";
      var fullUrl = _baseUrl + endpoint;

      //create empty list to be returned

      //make network request
      http.Response response = await http.get(Uri.parse(fullUrl));

      //jsonDecode Converts the response body which comes as a string into a map object
      List<dynamic> responseBody = jsonDecode(response.body);
      print('length ${responseBody[0]}');

      //filter through the map and get articles list
      var listOfTenants = response.body;
      //
      // //loop through the list and convert the map to Article object
      for (Map<String, dynamic> tenantItem in responseBody) {
        //Creates an article object
        // print('item ${tenantItem['ID']}');
        var tenant = Tenant.fromJson(tenantItem);
        listToBeReturned.add(tenant);
      }

      return listToBeReturned;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    print(listToBeReturned);
    return listToBeReturned;
  }

  Future addTenants(context, data) async {
    showDialog(context: context, barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    var headers = {
      'Content-Type': 'application/json'
    };
    try {
      var request = http.Request(
          'POST', Uri.parse('https://sheetdb.io/api/v1/0gozoxhv6c9yi'));
      request.body = json.encode(data);
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      Fluttertoast.showToast(
          toastLength: Toast.LENGTH_LONG,
          msg: 'Added Successfully');
      Navigator.pop(context);

      if (response.statusCode == 200) {


        print(await response.stream.bytesToString());
      }
      else {
        print(response.reasonPhrase);
      }
    }
    catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
  Future changeBalance( tenant,data) async {

    // showDialog(context: context, barrierDismissible: false,
    //     builder: (context) => const Center(child: CircularProgressIndicator()));
    // var remain = int.parse(tenant.balance) - int.parse(paid);
    // var data = {'balance': remain};
    print('hi $data');
    var headers = {
      'Content-Type': 'application/json'
    };
    try {
      var request = http.Request(
          'PATCH', Uri.parse('https://sheetdb.io/api/v1/0gozoxhv6c9yi/id/${tenant.id}'));
      request.body = json.encode(data);
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      Fluttertoast.showToast(
          toastLength: Toast.LENGTH_LONG,
          msg: 'Added Successfully');
      // Navigator.pop(context);
      if (response.statusCode == 200) {


        print(await response.stream.bytesToString());
      }
      else {
        print(response.reasonPhrase);
      }
    }
    catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
