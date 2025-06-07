import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:itdata/data/cubits/theme/theme_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_state.dart';
import 'package:local_auth/local_auth.dart';

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
  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _isAuthenticated = false;

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
        status("success");
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
            content: Text("An unexpected error occured!"),
          );
        },
      );
    }
  }

  void status(var status) {
    Navigator.popAndPushNamed(context, "/dashboard");
    showDialog(
      context: context,
      builder: (context) {
        if (status == "success") {
          return AlertDialog(
            title: SizedBox(
              height: 80,
              child: Image.asset("assets/images/success.gif", scale: 1.0),
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Transaction Successful!",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        } else if (status == "pending") {
          return AlertDialog(
            title: Icon(Icons.pending, color: Colors.orange, size: 50),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Transaction Pending!",
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        } else {
          return AlertDialog(
            title: Icon(Icons.warning_rounded, color: Colors.red, size: 50),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Transaction Failed!",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  void process() {
    print("${pin1.text} ${pin2.text} ${pin3.text} ${pin4.text}");
    showDialog(
      barrierDismissible: false,
      context: context,
      builder:
          (context) => AlertDialog(
            title: SizedBox(
              height: 60,
              child: Image.asset("assets/images/loading.gif", scale: 1.0),
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Processing, please wait...")],
            ),
          ),
    );
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
        process();
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'All field required';
                        }
                        return null;
                      },
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

  final exams = {};
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
              title: Text("Edu Pin"),
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
                        exam == "none"
                            ? "Choose Exam Type"
                            : exams[exam].toString(),
                        style: TextStyle(color: theme.primaryColor),
                      ),
                      items: [
                        for (var exam in exams.keys)
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
                        setState(() {
                          exam = value.toString();
                          if (quatity != "") {
                            var a = exams[exam].toString();
                            var total =
                                (int.tryParse(a)! * int.tryParse(quatity)!);

                            amount.text = total.toString();
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
                    DropdownButtonFormField(
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
                        setState(() {
                          quatity = value.toString();
                          var a = exams[exam].toString();
                          var total =
                              (int.tryParse(a)! * int.tryParse(quatity)!);

                          amount.text = total.toString();
                        });
                      },
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
