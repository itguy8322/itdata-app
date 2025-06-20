// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:itdata/core/dialogs/process_dialog.dart';
import 'package:itdata/core/dialogs/status_dialog.dart';
import 'package:itdata/core/setpin-buttons/setpin_buttons.dart';
import 'package:itdata/data/cubits/network-providers/network_providers_cubit.dart';
import 'package:itdata/data/cubits/network-providers/network_providers_state.dart';
import 'package:itdata/data/cubits/services/airtime/airtime_cubit.dart';
import 'package:itdata/data/cubits/services/airtime/airtime_state.dart';
import 'package:itdata/data/cubits/setpin-buttons/setpin_buttons_cubit.dart';
import 'package:itdata/data/cubits/setpin-buttons/setpin_buttons_state.dart';
import 'package:itdata/data/cubits/theme/theme_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_state.dart';
import 'package:itdata/data/cubits/user-data/user_data_cubit.dart';
import 'package:itdata/data/cubits/user-data/user_state.dart';
import 'package:itdata/features/dashboard/dashboard.dart';
import 'package:local_auth/local_auth.dart';

class Airtime extends StatefulWidget {
  const Airtime({super.key});

  @override
  State<Airtime> createState() => _AirtimeState();
}

class _AirtimeState extends State<Airtime> {
  TextEditingController number = TextEditingController();
  TextEditingController amount = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  var provider = "none";
  var airtimetype = "none";
  var network = "";

  var airtimetypes = {
    "none": "Choose Airtime Type",
    "vtu": "VTU",
    "sns": "SHARE AND SELL",
  };

  void make_transaction() async {
    // final url = Uri.parse("$_url/user/make-purchase");
    // final headers = {"Content-Type": "application/x-www-form-urlencoded"};
    // final body = {
    //   "service": "airtime",
    //   "network": network,
    //   "username": user_data["username"].toString(),
    //   "airtime_type": airtimetype.toString(),
    //   "number": number.text.toString(),
    //   "amount": amount.text.toString(),
    // };
    // try {
    //   final response = await http.post(url, headers: headers, body: body);
    //   if (response.statusCode == 200) {
    //     //print("It's Working...");
    //     var data = jsonDecode(response.body);
    //     ////print(data);
    //     if (data["status"] == "success") {
    //       user_data["wallet_bal"] = data["wallet_bal"];
    //       transactions = data["transactions"];
    //       setState(() {});
    //       //Navigator.pop(context);
    //       //Navigator.popAndPushNamed(context, "/dashboard");
    //       status(data["status"]);
    //     } else {
    //       if (data["wallet_bal"] != null) {
    //         user_data["wallet_bal"] = data["wallet_bal"];
    //       } else {
    //         user_data["wallet_bal"] = "0.0";
    //       }
    //       if (data["transactions"] != null) {
    //         transactions = data["transactions"];
    //       } else {
    //         transactions = transactions;
    //       }
    //       setState(() {});
    //       status(data["status"]);
    //     }
    //   } else {
    //     Navigator.pop(context);
    //     status("Check your internet connection and try again!");
    //   }
    // } catch (e) {
    //   Navigator.pop(context);
    //   status(
    //     "Could not connect, check your internet connection and try again! ${e.toString()}",
    //   );
    // }
  }

  final networks = {};
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
            title: Text("Airtime",style: TextStyle(color: theme.secondaryColor),),
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
                          BlocListener<AirtimeCubit, AirtimeState>(
                            listener: (context,state){
                              if(state.trnxInProcess){
                                Navigator.pop(context);
                                showProcessDialog(context);
                              }
                              else if (state.trnxSuccess){
                                Navigator.pop(context);
                                showStatusDialog(context, 'success');
                                context.read<AirtimeCubit>().reset();
                              }
                              else if (state.trnxFailure){
                                Navigator.pop(context);
                                showStatusDialog(context, 'fail');
                                context.read<AirtimeCubit>().reset();
                              }
                            }
                          )
                        ], 
                        child: SizedBox()
                      ),
                      BlocBuilder<NetworkProvidersCubit, NetworkProvidersState>(
                        builder: (context, networks) {
                          final providers = networks.networkProviders;
                          return DropdownButtonFormField(
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: theme.primaryColor),
                              ),
                              border: OutlineInputBorder(),
                            ),
                            hint: Text( "Choose Network",
                              style: TextStyle(color: theme.primaryColor),
                            ),
                            items: [
                              for (var network in providers!.keys)
                                (DropdownMenuItem(
                                  value: providers[network] as int,
                                  child: Text(network),
                                )),
                            ],
                            validator: (value) {
                              if (value == null) {
                                return 'All field required';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              context.read<AirtimeCubit>().onProviderSelected(value!);
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
                          airtimetypes[airtimetype].toString(),
                          style: TextStyle(color: theme.primaryColor),
                        ),
                        items: [
                          DropdownMenuItem(value: "vtu", child: Text("VTU")),
                          DropdownMenuItem(
                            value: "sns",
                            child: Text("SHARE N SELL"),
                          ),
                        ],
                        validator: (value) {
                          if (value == null) {
                            return 'All field required';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          
                          final airtimeType = (airtimetypes[value.toString()])!;
                          context.read<AirtimeCubit>().onTypeSelected(airtimeType);
                          
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: number,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly, // Allows only digits
                        ],
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
                        onChanged: (value){
                          context.read<AirtimeCubit>().onNumberEntered(value);
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: amount,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly, // Allows only digits
                        ],
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
                          context.read<AirtimeCubit>().onAmountChanged(value);
                        },
                      ),
                      SizedBox(height: 10),
                      SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(10),
                          backgroundColor: theme.primaryColor,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            //showPinButtons(context);
                            PinButtonWidget(context: context,title: 'Enter pin', onEnteredPins: (pin){
                              //print("Entered PIN: $pin");
                              if (user.userData?.pin == pin){
                                context.read<AirtimeCubit>().purchaseAirtime();
                              }
                              else{
                                showStatusDialog(context, "Incorrect pin, try again.");
                              }
                            });
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
