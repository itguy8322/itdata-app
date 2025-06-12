import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/theme/theme_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_state.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController username = TextEditingController();
  final TextEditingController verification_code = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool code_sent = false;
  final _status = "";
  @override
  void initState() {
    super.initState();
  }

  void status(var title, var status) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(title: Text(title), content: Text(status)),
    );
  }

  void process() {
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
    //status("pending");
  }

  void send_verification_code() async {
    // final url = Uri.parse("$_url/user/forgot-password");
    // final headers = {"Content-Type": "application/x-www-form-urlencoded"};
    // final body = {"username": username.text};
    // try {
    //   final response = await http.post(url, headers: headers, body: body);
    //   if (response.statusCode == 200) {
    //     print("It's Working...");
    //     var data = jsonDecode(response.body);
    //     //print(data);
    //     if (data["status"] == "ok") {
    //       var _data = data["data"];
    //       user_data = _data["user_data"];
    //       setState(() {
    //         code_sent = true;
    //         _status =
    //             "Verification code was sent to this email address: ${user_data['email']}";
    //       });
    //       Navigator.pop(context);
    //     } else {
    //       Navigator.pop(context);
    //       status("Alert", data["status"]);
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

  void verify_code() async {
    // final url = Uri.parse("$_url/user/code-verification");
    // final headers = {"Content-Type": "application/x-www-form-urlencoded"};
    // final body = {
    //   "username": user_data["username"],
    //   "code": verification_code.text,
    // };
    // try {
    //   final response = await http.post(url, headers: headers, body: body);
    //   if (response.statusCode == 200) {
    //     print("It's Working...");
    //     var data = jsonDecode(response.body);
    //     //print(data);
    //     if (data["status"] == "ok") {
    //       setState(() {
    //         code_sent = false;
    //       });
    //       Navigator.pop(context);
    //       Navigator.popAndPushNamed(context, "/change_password");
    //     } else {
    //       Navigator.pop(context);
    //       status("Alert", data["status"]);
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, theme) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/data_app_logo.png",
                          scale: 40,
                        ),
                        Text(
                          'IT Data',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: theme.primaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(height: 70),
                    Text("Forgot Password", style: TextStyle(fontSize: 20)),
                    SizedBox(height: 5),
                    code_sent
                        ? Text(_status)
                        : Text("Enter your username/email"),
                    SizedBox(height: 30),
                    code_sent != true
                        ? // Space between title and fields
                        TextFormField(
                          controller: username,
                          decoration: InputDecoration(
                            labelText: 'Username/email',
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: theme.primaryColor,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'All field required';
                            }
                            return null;
                          },
                        )
                        :
                        // Spacing between fields
                        TextFormField(
                          controller: verification_code,
                          decoration: InputDecoration(
                            labelText: 'Code',
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: theme.primaryColor,
                              ),
                            ),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'All field required';
                            }
                            return null;
                          },
                          obscureText: true, // Hide password
                        ),
                    SizedBox(height: 24.0), // Spacing before the login button
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          process();
                          if (code_sent == false) {
                            send_verification_code();
                          } else {
                            verify_code();
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                        padding: EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 15,
                        ),
                        textStyle: TextStyle(fontSize: 18),
                      ),
                      child: Text(code_sent ? 'Verify' : 'Send Code'),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
