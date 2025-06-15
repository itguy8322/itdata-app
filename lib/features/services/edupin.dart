import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/core/dialogs/process_dialog.dart';
import 'package:itdata/core/dialogs/status_dialog.dart';
import 'package:itdata/core/setpin-buttons/setpin_buttons.dart';
import 'package:itdata/data/cubits/services/edu/edu_cubit.dart';
import 'package:itdata/data/cubits/services/edu/edu_state.dart';
import 'package:itdata/data/cubits/setpin-buttons/setpin_buttons_cubit.dart';
import 'package:itdata/data/cubits/setpin-buttons/setpin_buttons_state.dart';
import 'package:itdata/data/cubits/theme/theme_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_state.dart';
import 'package:itdata/data/cubits/user-data/user_data_cubit.dart';
import 'package:itdata/data/cubits/user-data/user_state.dart';
import 'package:itdata/features/dashboard/dashboard.dart';
// import 'package:local_auth/local_auth.dart';

class EduPin extends StatefulWidget {
  const EduPin({super.key});

  @override
  State<EduPin> createState() => _EduPinState();
}

class _EduPinState extends State<EduPin> {
  TextEditingController number = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController pin1 = TextEditingController();
  TextEditingController pin2 = TextEditingController();
  TextEditingController pin3 = TextEditingController();
  TextEditingController pin4 = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // final LocalAuthentication _localAuth = LocalAuthentication();
  // bool _isAuthenticated = false;

  final FocusNode pin_1 = FocusNode();
  final FocusNode pin_2 = FocusNode();
  final FocusNode pin_3 = FocusNode();
  final FocusNode pin_4 = FocusNode();

  var exam = "none";
  var quatity = "none";

  var quantities = {
    "none": "Choose Quantity",
    "1": "1 Quantity",
    "2": "2 Quantities",
    "3": "4 Quantities",
    "4": "5 Quantities",
    "5": "9 Quantities",
  };

  Future<void> biametric_authentication() async {
    // try {
    //   bool isBiometricSupported = await _localAuth.isDeviceSupported();
    //   if (!isBiometricSupported) {
    //     showDialog(
    //       context: context,
    //       builder: (context) {
    //         return AlertDialog(
    //           title: Text("Warning!"),
    //           content: Text(
    //             "Biometric authentication is not supported on this device!",
    //           ),
    //         );
    //       },
    //     );
    //     print("Error 1");
    //     return;
    //   }
    //   bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
    //   if (!canCheckBiometrics) {
    //     showDialog(
    //       context: context,
    //       builder: (context) {
    //         return AlertDialog(
    //           title: Text("Warning!"),
    //           content: Text("No biometric features are available!"),
    //         );
    //       },
    //     );
    //     print("Error 2");
    //     return;
    //   }

    //   _isAuthenticated = await _localAuth.authenticate(
    //     localizedReason: 'Authenticate with your fingerprint',
    //     options: const AuthenticationOptions(
    //       useErrorDialogs: false,
    //       biometricOnly: true,
    //       stickyAuth: true,
    //     ),
    //   );
    //   if (_isAuthenticated) {
    //     status("success");
    //   } else {
    //     Navigator.pop(context);
    //     showDialog(
    //       context: context,
    //       builder: (context) {
    //         return AlertDialog(
    //           title: Text("Warning!"),
    //           content: Text("Fingerprint not recognized!"),
    //         );
    //       },
    //     );
    //   }
    //   setState(() {});
    // } catch (e) {
    //   print(e.toString());
    //   showDialog(
    //     context: context,
    //     builder: (context) {
    //       return AlertDialog(
    //         title: Text("Warning!"),
    //         content: Text("An unexpected error occured!"),
    //       );
    //     },
    //   );
    // }
  }

  final exams = {};
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, theme) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));
              },
              icon: Icon(Icons.arrow_back, color: theme.secondaryColor,),
            ),
            backgroundColor: theme.primaryColor,
            title: Text("Edu Pin", style: TextStyle(color: theme.secondaryColor),),
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
                              print(" ====== object ===== ");
                              if (state.pin1.isNotEmpty && state.pin2.isNotEmpty &&
                                  state.pin3.isNotEmpty && state.pin4.isNotEmpty){
                                    print("===== NOT EMPTY YEEEEEH");
                                    var pin = "${state.pin1}${state.pin2}${state.pin3}${state.pin4}";
                                    Navigator.pop(context);
                                    if (user.userData?.pin == pin){
                                      showProcessDialog(context);
                                    }
                                    else{
                                      showStatusDialog(context, "Incorrect pin, try again.");
                                    }
                                    context.read<SetpinButtonsCubit>().clearPin();
                                  }
                            }
                          )
                        ], 
                        child: SizedBox()
                      ),
                      BlocBuilder<EduCubit, EduState>(
                        builder: (context, edu) {
                          return DropdownButtonFormField(
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: theme.primaryColor),
                              ),
                              border: OutlineInputBorder(),
                            ),
                            hint: Text(
                              exam == "none"
                                  ? "Choose Exam Type"
                                  : exams[exam].toString(),
                              style: TextStyle(color: theme.primaryColor),
                            ),
                            items: [
                              for (var exam in edu.examsTypes.keys)
                                (DropdownMenuItem(
                                  value: exam,
                                  child: Text(exam.toString()),
                                )),
                            ],
                            validator: (value) {
                              if (value == null) {
                                return 'All field required';
                              }
                              return null;
                            },
                            onChanged: (value) {
                                exam = value.toString();
                                context.read<EduCubit>().onTypeSelected(exam);
                                if (edu.quantity.isNotEmpty) {
                                  var a = edu.examsTypes[exam]['price'].toString();
                                  var total =
                                      (int.tryParse(a)! * int.tryParse(quatity)!);
                          
                                  amount.text = total.toString();
                                  
                                }
                              
                            },
                          );
                        }
                      ),
                      SizedBox(height: 10),
                      BlocBuilder<EduCubit, EduState>(
                        builder: (context, edu) {
                          return DropdownButtonFormField(
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: theme.primaryColor),
                              ),
                              border: OutlineInputBorder(),
                            ),
                            hint: Text(
                              quantities[quatity].toString(),
                              style: TextStyle(color: theme.primaryColor),
                            ),
                            items: [
                              for (var i in quantities.keys)
                                (DropdownMenuItem(
                                  value: i,
                                  child: Text(quantities[i].toString()),
                                )),
                            ],
                            validator: (value) {
                              if (value == null) {
                                return 'All field required';
                              }
                              return null;
                            },
                            onChanged: (value) {
                                quatity = value.toString();
                                if (edu.exam.isNotEmpty){
                                  var a = edu.examsTypes[edu.exam]['price'].toString();
                                var total =
                                    (int.tryParse(a)! * int.tryParse(quatity)!);
                          
                                amount.text = total.toString();
                                }
                                
                              context.read<EduCubit>().onQuantitySelected(amount.text);
                            },
                          );
                        }
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        readOnly: true,
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
                          context.read<EduCubit>().onNumberEntered(value);
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
                              print("Entered PIN: $pin");
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
