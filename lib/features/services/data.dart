// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:itdata/core/dialogs/process_dialog.dart';
import 'package:itdata/data/cubits/theme/theme_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_state.dart';
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
        print("Error 1");
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
        print("Error 2");
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
        make_transaction();
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
      print(e.toString());
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

  void make_transaction() async {
    // final url = Uri.parse("$_url/user/make-purchase");
    // final headers = {"Content-Type": "application/x-www-form-urlencoded"};
    // final body = {
    //   "service": "data",
    //   "username": user_data["username"].toString(),
    //   "data_id": dataplan['id'].toString(),
    //   "number": number.text.toString(),
    // };
    // try {
    //   final response = await http.post(url, headers: headers, body: body);
    //   if (response.statusCode == 200) {
    //     print("It's Working...");
    //     var data = jsonDecode(response.body);
    //     //print(data);
    //     if (data["status"] == "success") {
    //       user_data["wallet_bal"] = data["wallet_bal"];
    //       transactions = data["transactions"];

    //       setState(() {});
    //       //Navigator.pop(context);
    //       //Navigator.popAndPushNamed(context, "/dashboard");
    //       status(data["status"]);
    //     } else {
    //       print("It's Working...2");
    //       data["wallet_bal"] ?? "0.0";
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

  void enterPin(var pin) {
    if (pin1.text.isEmpty) {
      pin1.text = pin.toString();
    } else if (pin2.text.isEmpty) {
      pin2.text = pin.toString();
    } else if (pin3.text.isEmpty) {
      pin3.text = pin.toString();
    } else {
      pin4.text = pin.toString();
      var pin0 = "${pin1.text}${pin2.text}${pin3.text}${pin4.text}";
      pin1.text = "";
      pin2.text = "";
      pin3.text = "";
      pin4.text = "";
      if (pin0 == "t_pin") {
        showProcessDialog(context);
        make_transaction();
      } else {
        Vibrate.vibrate();
        Navigator.pop(context);
        showDialog(
          context: context,
          builder:
              (context) =>
                  AlertDialog(content: Text("Incorrect pin, try again.")),
        );
      }
    }
  }

  void deletePin() {
    if (pin4.text.isNotEmpty) {
      pin4.text = "";
    } else if (pin3.text.isNotEmpty) {
      pin3.text = "";
    } else if (pin2.text.isNotEmpty) {
      pin2.text = "";
    } else {
      pin1.text = "";
    }
  }

  void showBottomDrawer(BuildContext context, ThemeState theme) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Enter confrimation pin"),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      readOnly: true,
                      obscureText: true,
                      obscuringCharacter: "⓿",
                      style: TextStyle(
                        color: theme.primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: pin1,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: theme.primaryColor),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      readOnly: true,
                      obscureText: true,
                      obscuringCharacter: "⓿",
                      style: TextStyle(
                        color: theme.primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: pin2,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: theme.primaryColor),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      readOnly: true,
                      obscureText: true,
                      obscuringCharacter: "⓿",
                      style: TextStyle(
                        color: theme.primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: pin3,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: theme.primaryColor),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      readOnly: true,
                      obscureText: true,
                      obscuringCharacter: "⓿",
                      style: TextStyle(
                        color: theme.primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: pin4,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: theme.primaryColor),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      enterPin(1);
                    },
                    child: Text(
                      "1",
                      style: TextStyle(fontSize: 40, color: theme.primaryColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(2);
                    },
                    child: Text(
                      "2",
                      style: TextStyle(fontSize: 40, color: theme.primaryColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(3);
                    },
                    child: Text(
                      "3",
                      style: TextStyle(fontSize: 40, color: theme.primaryColor),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      enterPin(4);
                    },
                    child: Text(
                      "4",
                      style: TextStyle(fontSize: 40, color: theme.primaryColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(5);
                    },
                    child: Text(
                      "5",
                      style: TextStyle(fontSize: 40, color: theme.primaryColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(6);
                    },
                    child: Text(
                      "6",
                      style: TextStyle(fontSize: 40, color: theme.primaryColor),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      enterPin(7);
                    },
                    child: Text(
                      "7",
                      style: TextStyle(fontSize: 40, color: theme.primaryColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(8);
                    },
                    child: Text(
                      "8",
                      style: TextStyle(fontSize: 40, color: theme.primaryColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(9);
                    },
                    child: Text(
                      "9",
                      style: TextStyle(fontSize: 40, color: theme.primaryColor),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      if (true == true) {
                        biametric_authentication();
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Warning"),
                              content: Text(
                                "Enable biometric in the app settings to use biometric for authentication.",
                              ),
                            );
                          },
                        );
                      }
                    },
                    icon: Icon(
                      Icons.fingerprint,
                      size: 28,
                      color: theme.primaryColor,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(0);
                    },
                    child: Text(
                      "0",
                      style: TextStyle(fontSize: 40, color: theme.primaryColor),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      deletePin();
                    },
                    icon: Icon(Icons.backspace, color: theme.primaryColor),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  List data_plans = [];
  final networks = {};
  final dataplans = {};
  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, theme) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  // data_plans = [];
                  Navigator.popAndPushNamed(context, "/dashboard");
                },
                icon: Icon(Icons.arrow_back),
              ),
              backgroundColor: theme.primaryColor,
              title: Text("Data"),
            ),
            body: Padding(
              padding: EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    DropdownButtonFormField(
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
                        for (var network in networks.keys)
                          (DropdownMenuItem(
                            value: network,
                            child: Text("${networks[network]}"),
                          )),
                      ],
                      validator: (value) {
                        if (value == null) {
                          return 'All field required';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          data_plans = [];
                          network = value.toString();
                          if (datatype != "") {
                            print(network);
                            print(datatype);
                            if (dataplans[network].containsKey(
                              value.toString(),
                            )) {
                              setState(() {
                                datatype = value.toString();
                                data_plans = dataplans[network][datatype];
                              });
                            } else {
                              setState(() {
                                data_plans = [];
                              });
                              showDialog(
                                context: context,
                                builder:
                                    (context) => AlertDialog(
                                      content: Text(
                                        "No Data type: $datatype on this network!",
                                      ),
                                    ),
                              );
                            }
                          }
                        });
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
                    ),
                    SizedBox(height: 10),
                    network != ""
                        ? DropdownButtonFormField(
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
                            for (var _datatype in [])
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
                            if (dataplans[network].containsKey(value)) {
                              setState(() {
                                datatype = value.toString();
                                data_plans = dataplans[network][datatype];
                              });
                            } else {
                              setState(() {
                                data_plans = [];
                                network = "";
                              });
                              showDialog(
                                context: context,
                                builder:
                                    (context) => AlertDialog(
                                      content: Text(
                                        "No Data type: $value on this network!",
                                      ),
                                    ),
                              );
                            }
                          },
                        )
                        : SizedBox(),
                    SizedBox(height: 10),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: theme.primaryColor),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      hint: Text(
                        dataplan.isEmpty
                            ? "Choose Plan"
                            : "${dataplan['plan']} ${dataplan['validate']} ${dataplan['sale_price']}",
                        style: TextStyle(color: theme.primaryColor),
                      ),
                      items: [
                        for (int i in List.generate(
                          data_plans.length,
                          (index) => index,
                          growable: false,
                        ))
                          (DropdownMenuItem(
                            value: i,
                            child: Text(
                              "${data_plans[i]['plan']} ${data_plans[i]['validate']} ${data_plans[i]['sale_price']}",
                            ),
                          )),
                      ],
                      validator: (value) {
                        if (value == null) {
                          return 'All field required';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        var i = int.tryParse(value.toString());
                        setState(() {
                          dataplan = data_plans[i!];
                        });
                        print(dataplan);
                      },
                    ),
                    SizedBox(height: 10),
                    SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(25),
                        backgroundColor: theme.primaryColor,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          showBottomDrawer(context, theme);
                        }
                      },
                      child: Text("Pay", style: TextStyle(fontSize: 30)),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      onPopInvokedWithResult: (b, t) async {
        Navigator.popAndPushNamed(context, "/dashboard");
      },
    );
  }
}
