import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:itdata/data/cubits/theme/theme_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_state.dart';
import 'package:local_auth/local_auth.dart';

TextEditingController pin1 = TextEditingController();
TextEditingController pin2 = TextEditingController();
TextEditingController pin3 = TextEditingController();
TextEditingController pin4 = TextEditingController();

final LocalAuthentication _localAuth = LocalAuthentication();
bool _isAuthenticated = false;

Future<void> biametric_authentication(BuildContext context) async {
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
      // process();
      // make_transaction();
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
    // setState(() {});
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
      // process();
      // make_transaction();
    } else {
      Vibrate.vibrate();
      // Navigator.pop(context);
      // showDialog(
      //   context: context,
      //   builder:
      //       (context) =>
      //           AlertDialog(content: Text("Incorrect pin, try again.")),
      // );
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

void showPinButtons(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
    ),
    builder: (context) {
      return BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, theme) {
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
                        style: TextStyle(
                          fontSize: 40,
                          color: theme.primaryColor,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        enterPin(2);
                      },
                      child: Text(
                        "2",
                        style: TextStyle(
                          fontSize: 40,
                          color: theme.primaryColor,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        enterPin(3);
                      },
                      child: Text(
                        "3",
                        style: TextStyle(
                          fontSize: 40,
                          color: theme.primaryColor,
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
                        enterPin(4);
                      },
                      child: Text(
                        "4",
                        style: TextStyle(
                          fontSize: 40,
                          color: theme.primaryColor,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        enterPin(5);
                      },
                      child: Text(
                        "5",
                        style: TextStyle(
                          fontSize: 40,
                          color: theme.primaryColor,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        enterPin(6);
                      },
                      child: Text(
                        "6",
                        style: TextStyle(
                          fontSize: 40,
                          color: theme.primaryColor,
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
                        enterPin(7);
                      },
                      child: Text(
                        "7",
                        style: TextStyle(
                          fontSize: 40,
                          color: theme.primaryColor,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        enterPin(8);
                      },
                      child: Text(
                        "8",
                        style: TextStyle(
                          fontSize: 40,
                          color: theme.primaryColor,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        enterPin(9);
                      },
                      child: Text(
                        "9",
                        style: TextStyle(
                          fontSize: 40,
                          color: theme.primaryColor,
                        ),
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
                          biametric_authentication(context);
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
                        style: TextStyle(
                          fontSize: 40,
                          color: theme.primaryColor,
                        ),
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
    },
  );
}
