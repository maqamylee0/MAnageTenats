import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:kitubs/screens/home/model/tenant_model.dart';

class TenantService{
  final _baseUrl = "https://sheetdb.io/api/v1/";


  Future<List<Tenant>> getAllTenants() async {
    var listToBeReturned = <Tenant>[];

    try{

        var endpoint = "0gozoxhv6c9yi";
        var fullUrl = _baseUrl+endpoint;

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
        for(Map<String, dynamic> tenantItem in responseBody){
          //Creates an article object
          print('item ${tenantItem['ID']}');
          var tenant = Tenant.fromJson(tenantItem);
          listToBeReturned.add(tenant);
        }

        return listToBeReturned;
      }catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
    print(listToBeReturned);
    return listToBeReturned;

    }
  }

