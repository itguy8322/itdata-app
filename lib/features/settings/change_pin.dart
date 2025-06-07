import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

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

  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _isAuthenticated = false;

  void status(var _title, var status) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(title: Text(_title), content: Text(status)),
    );
  }

  void setPin() async {
    final url = Uri.parse("$_url/user/set-pin");
    final headers = {"Content-Type": "application/x-www-form-urlencoded"};
    final body = {"username": user_data["username"], "t_pin": new_pin};
    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        print("It's Working...");
        var data = jsonDecode(response.body);
        print(data);
        if (data["status"] == "ok") {
          user_data["t_pin"] = new_pin;
          setState(() {
            new_pin = "";
            conf_pin = "";
          });
          Navigator.pop(context);
          Navigator.popAndPushNamed(context, "/dashboard");
        }
      } else {
        Navigator.pop(context);
        status(
          "Connection Error",
          "check your internet connection and try again!",
        );
      }
    } catch (e) {
      Navigator.pop(context);
      status(
        "Unexpected Error",
        "Could ne not connect, check your internet connection and try again! ${e.toString()}",
      );
    }
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
      var old_pin = "${pin1.text}${pin2.text}${pin3.text}${pin4.text}";
      if (user_data["t_pin"] == old_pin) {
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
    if (user_data["t_pin"] == "0000" && pin_alert == true) {
      alert();
      setState(() {
        pin_alert = false;
      });
    }
    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              setState(() {
                new_pin = "";
                conf_pin = "";
                pin_status = "";
                set_pin = false;
              });
              Navigator.popAndPushNamed(context, "/security");
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Text(
            set_pin ? "Set Transaction Pin" : "Change Transaction PIN",
          ),
          backgroundColor: mainColor,
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
                        color: mainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: pin1,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor),
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
                        color: mainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: pin2,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor),
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
                        color: mainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: pin3,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor),
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
                        color: mainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: pin4,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor),
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
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(2);
                    },
                    child: Text(
                      "2",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(3);
                    },
                    child: Text(
                      "3",
                      style: TextStyle(fontSize: 40, color: mainColor),
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
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(5);
                    },
                    child: Text(
                      "5",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(6);
                    },
                    child: Text(
                      "6",
                      style: TextStyle(fontSize: 40, color: mainColor),
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
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(8);
                    },
                    child: Text(
                      "8",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(9);
                    },
                    child: Text(
                      "9",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.fingerprint, size: 28, color: mainColor),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(0);
                    },
                    child: Text(
                      "0",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      deletePin();
                    },
                    icon: Icon(Icons.backspace, color: mainColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      onPopInvokedWithResult: (b, t) async {
        Navigator.popAndPushNamed(context, "/security");
      },
    );
  }
}
