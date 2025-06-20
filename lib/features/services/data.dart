// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/core/dialogs/process_dialog.dart';
import 'package:itdata/core/dialogs/status_dialog.dart';
import 'package:itdata/core/setpin-buttons/setpin_buttons.dart';
import 'package:itdata/data/cubits/services/data/data_cubit.dart';
import 'package:itdata/data/cubits/services/data/data_state.dart';
import 'package:itdata/data/cubits/setpin-buttons/setpin_buttons_cubit.dart';
import 'package:itdata/data/cubits/setpin-buttons/setpin_buttons_state.dart';
import 'package:itdata/data/cubits/theme/theme_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_state.dart';
import 'package:itdata/data/cubits/user-data/user_data_cubit.dart';
import 'package:itdata/data/cubits/user-data/user_state.dart';
import 'package:itdata/features/dashboard/dashboard.dart';
import 'package:local_auth/local_auth.dart';

class Data extends StatefulWidget {
  const Data({super.key});

  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
  TextEditingController number = TextEditingController();
  TextEditingController pin1 = TextEditingController();
  TextEditingController pin2 = TextEditingController();
  TextEditingController pin3 = TextEditingController();
  TextEditingController pin4 = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FocusNode pin_1 = FocusNode();
  final FocusNode pin_2 = FocusNode();
  final FocusNode pin_3 = FocusNode();
  final FocusNode pin_4 = FocusNode();

  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _isAuthenticated = false;
  var pin_title = "Enter your pin";
  var network = "";
  var datatype = "";
  var dataplan = {};

  Future<void> biametric_authentication() async {
    try {
      bool isBiometricSupported = await _localAuth.isDeviceSupported();
      if (!isBiometricSupported) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Warning!"),
              content: Text(
                "Biometric authentication is not supported on this device!",
              ),
            );
          },
        );
        //print("Error 1");
        return;
      }
      bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
      if (!canCheckBiometrics) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Warning!"),
              content: Text("No biometric features are available!"),
            );
          },
        );
        //print("Error 2");
        return;
      }

      _isAuthenticated = await _localAuth.authenticate(
        localizedReason: 'Authenticate with your fingerprint',
        options: const AuthenticationOptions(
          useErrorDialogs: false,
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
      if (_isAuthenticated) {
        showProcessDialog(context);
      } else {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Warning!"),
              content: Text("Fingerprint not recognized!"),
            );
          },
        );
      }
      setState(() {});
    } catch (e) {
      //print(e.toString());
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Warning!"),
            content: Text("An unexpected error occured! ${e.toString()}"),
          );
        },
      );
    }
  }

  List data_plans = [];
  final networks = {};
  final dataplans = {};
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, theme) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                // data_plans = [];
                context.read<DataCubit>().reInitialize();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Dashboard()));
              },
              icon: Icon(Icons.arrow_back, color: theme.secondaryColor,),
            ),
            backgroundColor: theme.primaryColor,
            title: Text("Data", style: TextStyle(color: theme.secondaryColor),),
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
                          )
                        ], 
                        child: SizedBox()
                      ),
                      BlocBuilder<DataCubit, DataState>(
                        builder: (context, data) {
                          return DropdownButtonFormField(
                            value: data.provider.isNotEmpty ? data.provider : null,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: theme.primaryColor),
                              ),
                              border: OutlineInputBorder(),
                            ),
                            hint: Text(
                              network == ""
                                  ? "Choose Network"
                                  : networks[network].toString(),
                              style: TextStyle(color: theme.primaryColor),
                            ),
                            items: [
                              for (var network in data.dataplans.keys)
                                (DropdownMenuItem(
                                  value: network,
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
                              context.read<DataCubit>().onProviderSelected(value!);
                              context.read<DataCubit>().onTypeSelected('');
                              context.read<DataCubit>().onPlanIdSelected('');
                            },
                          );
                        }
                      ),
                      SizedBox(height: 10),
                      BlocBuilder<DataCubit, DataState>(
                        builder: (context, data) {
                          if (data.provider.isNotEmpty){
                            //print(data.dataplans[data.provider]);
                            final planTypes = data.dataplans[data.provider][0]['plans'];
                            return DropdownButtonFormField(
                              value: data.type.isNotEmpty ? data.type : null,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: theme.primaryColor),
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                                hint: Text(
                                  "Choose Data Type",
                                  style: TextStyle(color: theme.primaryColor),
                                ),
                                items: [
                                  for (String _datatype in planTypes.keys)
                                    (DropdownMenuItem(
                                      value: _datatype,
                                      child: Text(_datatype),
                                    )),
                                ],
                                validator: (value) {
                                  if (value == null) {
                                    return 'All field required';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  context.read<DataCubit>().onTypeSelected(value!);
                                  context.read<DataCubit>().onPlanIdSelected('');
                                  
                                },
                              );
                          }else{
                            return SizedBox();
                          }
                          
                        }
                      )
                          ,
                      SizedBox(height: 10),
                      BlocBuilder<DataCubit, DataState>(
                        builder: (context, data) {
                          
                          if (data.type.isNotEmpty){
                            final plans = data.dataplans[data.provider][0]['plans'][data.type];
                            return DropdownButtonFormField(
                              value: data.planId.isNotEmpty ? data.planId : null,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: theme.primaryColor),
                              ),
                              border: OutlineInputBorder(),
                            ),
                            hint: Text(
                              "Choose Plan",
                              style: TextStyle(color: theme.primaryColor),
                            ),
                            items:
                              [for (var plan in plans)(
                                DropdownMenuItem(
                                  value: plan['plan_id'].toString(),
                                  child: Text(
                                    "${plan['validate']} ${plan['price']}",
                                  )
                              ))
                            ],
                            validator: (value) {
                              if (value == null) {
                                return 'All field required';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              context.read<DataCubit>().onPlanIdSelected(value!);
                            },
                          );
                          }else{
                            return SizedBox();
                          }
                          
                        }
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
                          context.read<DataCubit>().onNumberEntered(value);
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
                            PinButtonWidget(context: context, title: 'Enter pin', onEnteredPins: (pin){
                              //print("Entered PIN: $pin");
                              if (user.userData?.pin == pin){
                                showProcessDialog(context);
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
