import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:itdata/data/cubits/theme/theme_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_state.dart';
import 'package:itdata/features/settings/security.dart';

class ChangePin extends StatefulWidget {
  const ChangePin({super.key});

  @override
  State<ChangePin> createState() => _ChangePinState();
}

class _ChangePinState extends State<ChangePin> {
  TextEditingController pin1 = TextEditingController();
  TextEditingController pin2 = TextEditingController();
  TextEditingController pin3 = TextEditingController();
  TextEditingController pin4 = TextEditingController();

  void status(var title, var status) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(title: Text(title), content: Text(status)),
    );
  }

  void setPin() async {
    // final url = Uri.parse("$_url/user/set-pin");
    // final headers = {"Content-Type": "application/x-www-form-urlencoded"};
    // final body = {"username": user_data["username"], "t_pin": new_pin};
    // try {
    //   final response = await http.post(url, headers: headers, body: body);
    //   if (response.statusCode == 200) {
    //     print("It's Working...");
    //     var data = jsonDecode(response.body);
    //     print(data);
    //     if (data["status"] == "ok") {
    //       user_data["t_pin"] = new_pin;
    //       setState(() {
    //         new_pin = "";
    //         conf_pin = "";
    //       });
    //       Navigator.pop(context);
    //       Navigator.popAndPushNamed(context, "/dashboard");
    //     }
    //   } else {
    //     Navigator.pop(context);
    //     status(
    //       "Connection Error",
    //       "check your internet connection and try again!",
    //     );
    //   }
    // } catch (e) {
    //   Navigator.pop(context);
    //   status(
    //     "Unexpected Error",
    //     "Could ne not connect, check your internet connection and try again! ${e.toString()}",
    //   );
    // }
  }

  void process() {
    print("${pin1.text}${pin2.text}${pin3.text}${pin4.text}");
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

  bool set_pin = false;
  var new_pin = '';
  var pin_status = '';
  var conf_pin = '';
  bool pin_alert = false;
  void check_pin() {
    if (set_pin == true) {
      if (new_pin.isEmpty) {
        new_pin = "${pin1.text}${pin2.text}${pin3.text}${pin4.text}";
        pin_status = "";
        pin1.text = "";
        pin2.text = "";
        pin3.text = "";
        pin4.text = "";
        setState(() {});
      } else {
        conf_pin = "${pin1.text}${pin2.text}${pin3.text}${pin4.text}";
        if (conf_pin == new_pin) {
          pin_status = "";
          set_pin = false;
          process();
          setPin();
        } else {
          pin1.text = "";
          pin2.text = "";
          pin3.text = "";
          pin4.text = "";
          conf_pin = "";
          new_pin = "";
          pin_status = "Pin didn't match,";
          Vibrate.vibrate();
          setState(() {});
        }
      }
    } else {
      var oldPin = "${pin1.text}${pin2.text}${pin3.text}${pin4.text}";
      if ("t_pin" == oldPin) {
        set_pin = true;
        pin1.text = "";
        pin2.text = "";
        pin3.text = "";
        pin4.text = "";
        conf_pin = "";
        pin_status = "";
        setState(() {});
      } else {
        pin1.text = "";
        pin2.text = "";
        pin3.text = "";
        pin4.text = "";
        conf_pin = "";
        pin_status = "Pin didn't match,";
        Vibrate.vibrate();
        setState(() {});
      }
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
      check_pin();
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

  void alert() async {
    Timer(Duration(seconds: 1), () {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text("Warning"),
              content: Text(
                "Your default pin is: 0000, Change it now for security purpose or skip to change it later.",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    set_pin = false;
                    Navigator.popAndPushNamed(context, "/dashboard");
                  },
                  child: Text("Skip"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Change"),
                ),
              ],
            ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if ("t_pin" == "0000" && pin_alert == true) {
      alert();
      setState(() {
        pin_alert = false;
      });
    }
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, theme) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                setState(() {
                  new_pin = "";
                  conf_pin = "";
                  pin_status = "";
                  set_pin = false;
                });
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Security()));
              },
              icon: Icon(Icons.arrow_back, color: theme.secondaryColor),
            ),
            title: Text(
              set_pin ? "Set Transaction Pin" : "Change Transaction PIN", style: TextStyle(color: theme.secondaryColor)
            ),
            backgroundColor: theme.primaryColor,
          ),
          body: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  set_pin
                      ? new_pin.isEmpty
                          ? "$pin_status Enter new pin"
                          : "$pin_status Confirm pin"
                      : "$pin_status Enter old pin",
                ),
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
                      onPressed: () {},
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
          ),
        );
      },
    );
  }
}
