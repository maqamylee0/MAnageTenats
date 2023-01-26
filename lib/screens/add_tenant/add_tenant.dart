import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/TenantModel.dart';
import '../../providers/tenant_provider.dart';
import '../home/model/tenant_model.dart';


class AddTenant extends StatefulWidget {
  const AddTenant({Key? key}) : super(key: key);

  @override
  State<AddTenant> createState() => _AddTenantState();
}

class _AddTenantState extends State<AddTenant> {
  int _currentStep = 0;
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController phoneControlller = TextEditingController();
  TextEditingController telControlller = TextEditingController();
  TextEditingController kinControlller = TextEditingController();
  TextEditingController kinTelControlller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final tenants = Provider.of<TenantsProvider>(context);


    tapped(int step){
    setState(() => _currentStep = step);
    }

    continued(){
      _currentStep < 4 ?
      setState(() => _currentStep += 1): null;
    }
    cancel(){
      _currentStep > 0 ?
      setState(() => _currentStep -= 1) : null;
    }


    return  Scaffold(
      appBar: PreferredSize(

        preferredSize: Size.fromHeight(80),
        child: AppBar(
          title: Column(
            children: [
              SizedBox(height: 30,),
              Text("Add Tenants",style: TextStyle(fontSize: 25),),
            ],
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: tenants.showCircle ? CircularProgressIndicator():



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
                          title: new Text('Personal Information',style: TextStyle(fontSize: 20),),
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
                          title: new Text('Contact',style: TextStyle(fontSize: 20)),
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
                          title: new Text('Amount Per Month',style: TextStyle(fontSize: 20)),
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

                        Step(
                          title: new Text('NextOfKin',style: TextStyle(fontSize: 20)),
                          content: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: kinControlller,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(labelText: 'Enter amount per month'),

                              ),

                            ],
                          ),
                          isActive:_currentStep >= 0,
                          state: _currentStep >= 3 ?
                          StepState.complete : StepState.disabled,
                        ),
                        Step(
                          title: new Text('Next Of Kin Telephone',style: TextStyle(fontSize: 20)),
                          content: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: kinTelControlller,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(labelText: 'Enter amount per month'),

                              ),

                            ],
                          ),
                          isActive:_currentStep >= 0,
                          state: _currentStep >= 4 ?
                          StepState.complete : StepState.disabled,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(

                    child: Text("Save",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20),),
                    onPressed: () async  {
                      tenants.setshowCircle = true;
                       await saveDetails(context,tenants);

                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50),


                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
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
    TenantModel tenant = TenantModel(
      name: nameController.text,
      amount: amountController.text,
      cell: phoneControlller.text,
      remaining: '0',
      balance: amountController.text
    );

    if (kDebugMode) {
      print(tenant.name);
      print(nameController.value.text);

    }

    await tenants.addTenants(context,tenant);



  }
}
