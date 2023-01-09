import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/tenant_provider.dart';
import '../home/model/tenant_model.dart';


class AddTenant extends StatefulWidget {
  const AddTenant({Key? key}) : super(key: key);

  @override
  State<AddTenant> createState() => _AddTenantState();
}

class _AddTenantState extends State<AddTenant> {
  int _currentStep = 0;
  Tenant tenant = Tenant();
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController phoneControlller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final tenants = Provider.of<TenantsProvider>(context);


    tapped(int step){
    setState(() => _currentStep = step);
    }

    continued(){
      _currentStep < 2 ?
      setState(() => _currentStep += 1): null;
    }
    cancel(){
      _currentStep > 0 ?
      setState(() => _currentStep -= 1) : null;
    }


    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Add Tenant"),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child:



          Container(
            padding: EdgeInsets.all(20),
            child: Column(

              children: [
                SizedBox(
                  height: 50,
                ),
                Form(
                  key: formKey,
                  child: Container(

                    child: Stepper(

                      physics: ScrollPhysics(),
                      currentStep: _currentStep,
                      onStepTapped: (step) => tapped(step),
                      onStepContinue: continued,
                      onStepCancel: cancel,
                      steps: <Step>[
                        Step(
                          title: new Text('Personal Information'),
                          content: Column(
                            children: <Widget>[
                              TextFormField(
                                keyboardType: TextInputType.text,
                                controller: nameController,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (value)=>
                                value == "" ? "Enter a name": null,
                                decoration: InputDecoration(labelText: 'Full Name'),

                              ),

                            ],
                          ),
                          isActive: _currentStep >= 0,
                          state: _currentStep >= 0 ?
                          StepState.complete : StepState.disabled,
                        ),
                        Step(
                          title: new Text('Contact'),
                          content: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: phoneControlller,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(labelText: 'Phone Number'),

                              ),

                            ],
                          ),
                          isActive: _currentStep >= 0,
                          state: _currentStep >= 1 ?
                          StepState.complete : StepState.disabled,
                        ),


                        Step(
                          title: new Text('Amount Per Month'),
                          content: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: amountController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(labelText: 'Enter amount per month'),

                              ),

                            ],
                          ),
                          isActive:_currentStep >= 0,
                          state: _currentStep >= 2 ?
                          StepState.complete : StepState.disabled,
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(

                  child: Text("Save",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20),),
                  onPressed: () async  {

                     await saveDetails(context,tenants);
                      await tenants.addTenants(context,tenant.toMap());

                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(60),


                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ],
            ),
          ),


        ),
      ),

    );

  }

  saveDetails(context,tenants) async {
    tenant.id = '';
    tenant.name = nameController.text;
    tenant.amount = amountController.text;
    tenant.cell= phoneControlller.text ;
    tenant.remaining = '0';
    tenant.balance = amountController.text;


    if (kDebugMode) {
      print(tenant.name);
      print(nameController.value.text);

    }




  }
}
