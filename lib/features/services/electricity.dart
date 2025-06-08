import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:itdata/core/dialogs/process_dialog.dart';
import 'package:itdata/data/cubits/theme/theme_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_state.dart';
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

  var disco_name = "none";
  int disco_id = 0;
  var metertype = "";
  var check_meter = false;
  var meter_data = "";

  var providers = {
    "none": "Select Disco Provider",
    "1": "Kano Electric",
    "2": "Aba Electric",
    "3": "Benin Electric",
    "4": "Eko Electric",
    "5": "Enugu Electric",
    "6": "Ibandan Electric",
    "7": "Ikeja Electric",
    "8": "Jos Electric",
    "9": "Kaduna Electric",
    "10": "Kano Electric",
    "11": "Port Harcourt Electric",
    "12": "Yola Electric",
  };
  var metertypes = {
    "none": "Choose Meter Type",
    "1": "prepaid",
    "2": "postpaid",
  };
  void _status(var _title, var status) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(title: Text(_title), content: Text(status)),
    );
  }

  void validateMeterNumber() async {
    // print("am here");
    // int m = (int.tryParse(meter.text))!;
    // final url = Uri.parse(
    //   "https://postranet.com/api/validatemeter?meternumber=$m&disconame=$disco_name&mtype=$metertype",
    // );
    // final headers = {"Content-Type": "application/json"};
    // try {
    //   print("am here1");
    //   final response = await http.get(url, headers: headers);
    //   print("am here2");
    //   if (response.statusCode == 200) {
    //     print("It's Working...");
    //     var data = jsonDecode(response.body);

    //     print("am here3");
    //     check_meter = false;
    //     meter_data = data["name"].toString();
    //     setState(() {});
    //   } else {
    //     print("am here5");
    //     check_meter = false;
    //     meter_data = "Could not fetch data, try again.";
    //     setState(() {});
    //   }
    // } catch (e) {
    //   print("am here6");
    //   check_meter = false;
    //   meter_data = "Could not fetch data, try again.";
    //   setState(() {});
    // }
  }

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

  void enterPin(var pin) {
    if (pin1.text.isEmpty) {
      pin1.text = pin.toString();
    } else if (pin2.text.isEmpty) {
      pin2.text = pin.toString();
    } else if (pin3.text.isEmpty) {
      pin3.text = pin.toString();
    } else {
      pin4.text = pin.toString();
      var _pin = "${pin1.text}${pin2.text}${pin3.text}${pin4.text}";
      pin1.text = "";
      pin2.text = "";
      pin3.text = "";
      pin4.text = "";
      if (_pin == "t_pin") {
        showProcessDialog(context);
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
              Text("Enter Pin"),
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

  final electricity = {};
  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, theme) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, "/dashboard");
                },
                icon: Icon(Icons.arrow_back),
              ),
              backgroundColor: theme.primaryColor,
              title: Text("Electricity"),
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
                        disco_name == "none"
                            ? "Choose Disco Name"
                            : disco_name.toString(),
                        style: TextStyle(color: theme.primaryColor),
                      ),
                      items: [
                        for (var i in electricity.keys)
                          (DropdownMenuItem(
                            value: i,
                            child: Text(electricity[i].toString()),
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
                          disco_name = electricity[value.toString()];
                          disco_id = (int.tryParse(value.toString()))!;
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
                        setState(() {
                          metertype = (metertypes[value.toString()])!;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    check_meter
                        ? Row(
                          children: [
                            Image.asset(
                              "assets/images/loading.gif",
                              scale: 25.0,
                            ),
                            Text(
                              "Validating...",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                        : meter_data == "Could not fetch data, try again."
                        ? Text(
                          "$meter_data",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                        : meter_data != ""
                        ? Text(
                          "$meter_data".toUpperCase(),
                          style: TextStyle(
                            color:
                                meter_data == "INVALID METER NUMBER"
                                    ? Colors.red
                                    : Colors.green,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
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
                        if (value.length == 11) {
                          setState(() {
                            check_meter = true;
                          });
                          validateMeterNumber();
                        } else {
                          setState(() {
                            meter_data = "";
                          });
                        }
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
                    ),
                    SizedBox(height: 10),
                    SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(25),
                        backgroundColor: theme.primaryColor,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            int.tryParse(amount.text.toString())! >= 500) {
                          showBottomDrawer(context, theme);
                        } else {
                          _status(
                            "Amount Error",
                            "The amount must not be less than N500",
                          );
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
