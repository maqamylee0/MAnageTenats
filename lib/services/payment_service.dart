import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../screens/home/model/payment_model.dart';

class PaymentService{
  final _baseUrl = "https://sheetdb.io/api/v1/";


  Future<List<Payment>> getAllPayments() async {
    var listToBeReturned = <Payment>[];

    try {
      var endpoint = "0gozoxhv6c9yi?sheet=payments";
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
      for (Map<String, dynamic> paymentItem in responseBody) {
        //Creates an article object
        print('item ${ paymentItem['id']}');
        var tenant = Payment.fromJson(paymentItem );
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

  Future addPayment(context, data) async {
    showDialog(context: context, barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    var headers = {
      'Content-Type': 'application/json'
    };
    print(data);
    try {
      var request = http.Request(
          'POST', Uri.parse('https://sheetdb.io/api/v1/0gozoxhv6c9yi?sheet=payments'));
      request.body = json.encode(data);
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      Fluttertoast.showToast(
          toastLength: Toast.LENGTH_LONG,
          msg: 'Payment Successfully');
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
}