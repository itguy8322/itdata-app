// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:itdata/core/dialogs/alert_dialog.dart';
import 'package:itdata/core/dialogs/process_dialog.dart';
import 'package:itdata/core/dialogs/status_dialog.dart';
import 'package:itdata/core/setpin-buttons/setpin_buttons.dart';
import 'package:itdata/data/cubits/services/electricity/electricity_cubit.dart';
import 'package:itdata/data/cubits/services/electricity/electricity_state.dart';
import 'package:itdata/data/cubits/setpin-buttons/setpin_buttons_cubit.dart';
import 'package:itdata/data/cubits/setpin-buttons/setpin_buttons_state.dart';
import 'package:itdata/data/cubits/theme/theme_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_state.dart';
import 'package:itdata/data/cubits/user-data/user_data_cubit.dart';
import 'package:itdata/data/cubits/user-data/user_state.dart';
import 'package:itdata/features/dashboard/dashboard.dart';
// import 'package:local_auth/local_auth.dart';

class Electricity extends StatefulWidget {
  const Electricity({super.key});

  @override
  State<Electricity> createState() => _ElectricityState();
}

class _ElectricityState extends State<Electricity> {
  TextEditingController number = TextEditingController();
  TextEditingController meter = TextEditingController();
  TextEditingController amount = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // final LocalAuthentication _localAuth = LocalAuthentication();


  
  var metertype = "";
  var check_meter = false;
  var meter_data = "";
  bool invalid = false;

  var metertypes = {
    "none": "Choose Meter Type",
    "1": "prepaid",
    "2": "postpaid",
  };
  void validateMeterNumber(String meterNumber, String disco_name) async {
    //print("am here");
    int m = (int.tryParse(meterNumber))!;
    final url = Uri.parse(
      "https://postranet.com/api/validatemeter?meternumber=$m&disconame=$disco_name&mtype=$metertype",
    );
    final headers = {"Content-Type": "application/json"};
    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        check_meter = false;
        meter_data = data["name"].toString();
        invalid = data['invalid'];
        //print(data);
        setState(() {});
      } else {
        check_meter = false;
        meter_data = "Could not fetch data, try again.";
        setState(() {});
      }
    } catch (e) {
      check_meter = false;
      meter_data = "Could not fetch data, try again.";
      setState(() {});
    }
  }

  final electricity = {};
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, theme) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Dashboard()));
              },
              icon: Icon(Icons.arrow_back, color: theme.secondaryColor,),
            ),
            backgroundColor: theme.primaryColor,
            title: Text("Electricity", style: TextStyle(color: theme.secondaryColor),),
          ),
          body: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: BlocBuilder<UserDataCubit, UserState>(
                builder: (context, user) {
                  return ListView(
                    children: [
                      MultiBlocListener(
                        listeners: [
                          BlocListener<SetpinButtonsCubit, SetpinButtonsState>(
                            listener: (context,state){
                              
                            }
                          ),
                          BlocListener<ElectricityCubit, ElectricityState>(
                            listener: (context, state){
                              if (state.meterNumber.length == 11) {
                                setState(() {
                                  check_meter = true;
                                });
                                validateMeterNumber(state.meterNumber, state.discoName);
                              } else {
                                setState(() {
                                  meter_data = "";
                                  check_meter = false;
                                  invalid = true;
                                });
                              }
                          })
                        ], 
                        child: SizedBox()
                      ),
                      BlocBuilder<ElectricityCubit, ElectricityState>(
                        builder: (context, discos) {
                          //print(discos.elecPlans[0].toString());
                          return DropdownButtonFormField(
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: theme.primaryColor),
                              ),
                              border: OutlineInputBorder(),
                            ),
                            hint: Text("Choose Disco Name",
                              style: TextStyle(color: theme.primaryColor),
                            ),
                            items: [
                              for (var i in discos.elecPlans)
                                (DropdownMenuItem(
                                  value: i as String,
                                  child: Text(i.toString()),
                                )),
                            ],
                            validator: (value) {
                              if (value == null) {
                                return 'All field required';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              context.read<ElectricityCubit>().onDiscNameSelected(value!.toString());
                            },
                          );
                        }
                      ),
                      SizedBox(height: 10),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: theme.primaryColor),
                          ),
                          border: OutlineInputBorder(),
                        ),
                        hint: Text(
                          metertype == ""
                              ? "Choose Meter type"
                              : metertypes[metertype].toString(),
                          style: TextStyle(color: theme.primaryColor),
                        ),
                        items: [
                          DropdownMenuItem(value: "1", child: Text("PREPAID")),
                          DropdownMenuItem(value: "2", child: Text("POSTPAID")),
                        ],
                        validator: (value) {
                          if (value == null) {
                            return 'All field required';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          context.read<ElectricityCubit>().onTypeSelected(value!);
                        },
                      ),
                      SizedBox(height: 10),
                      check_meter
                          ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(strokeWidth: 6,color: theme.primaryColor,)),
                                SizedBox(width: 5,),
                                Text(
                                  "Validating...",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )
                          : meter_data == "Could not fetch data, try again."
                          ? Text(
                            meter_data,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                          : meter_data != ""
                          ? Row(
                            children: [
                              meter_data == "INVALID METER NUMBER"?
                              Icon(Icons.warning_rounded, color: Colors.red, size: 20,)
                              : Icon(Icons.check_circle, color: Colors.green, size: 20,),
                              Text(
                                meter_data.toUpperCase(),
                                style: TextStyle(
                                  color:
                                      meter_data == "INVALID METER NUMBER"
                                          ? Colors.red
                                          : Colors.blueGrey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                          : SizedBox(height: 0.01),
                      TextFormField(
                        controller: meter,
                        keyboardType: TextInputType.phone,
                        maxLength: 11,
                        readOnly: check_meter,
                        decoration: InputDecoration(
                          labelText: 'Meter Number',
                          labelStyle: TextStyle(color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: theme.primaryColor),
                          ),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'All field required';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          context.read<ElectricityCubit>().onMeterNumber(value);
                          
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: number,
                        keyboardType: TextInputType.phone,
                        maxLength: 11,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: theme.primaryColor),
                          ),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'All field required';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          context.read<ElectricityCubit>().onNumberEntered(value);
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: amount,
                        keyboardType: TextInputType.phone,
                        maxLength: 11,
                        decoration: InputDecoration(
                          labelText: 'Amount',
                          labelStyle: TextStyle(color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: theme.primaryColor),
                          ),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'All field required';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          context.read<ElectricityCubit>().onAmountChanged(value);
                        },
                      ),
                      SizedBox(height: 10),
                      SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(10),
                          backgroundColor: theme.primaryColor,
                        ),
                        onPressed: invalid?null: () {
                          if (_formKey.currentState!.validate() &&
                              int.tryParse(amount.text.toString())! >= 500) {
                            PinButtonWidget(context: context, title: 'Enter pin', onEnteredPins: (pin){
                              //print("Entered PIN: $pin");
                              if (user.userData?.pin == pin){
                                showProcessDialog(context);
                              }
                              else{
                                showStatusDialog(context, "Incorrect pin, try again.");
                              }
                            });
                          } else {
                            showAlertDialog(context,
                              "Amount Error",
                              "The amount must not be less than N500",
                            );
                          }
                        },
                        child: Text("Pay", style: TextStyle(fontSize: 20, color: theme.secondaryColor)),
                      ),
                    ],
                  );
                }
              ),
            ),
          ),
        );
      },
    );
  }
}
