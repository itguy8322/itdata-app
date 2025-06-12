import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/theme/theme_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_state.dart';

class ChangeNewPassword extends StatefulWidget {
  const ChangeNewPassword({super.key});

  @override
  State<ChangeNewPassword> createState() => _ChangeNewPasswordState();
}

class _ChangeNewPasswordState extends State<ChangeNewPassword> {
  final TextEditingController password = TextEditingController();
  final TextEditingController cpassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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

  // void change_password() async {
  //   final url = Uri.parse("$_url/user/change-password");
  //   final headers = {"Content-Type": "application/x-www-form-urlencoded"};
  //   final body = {"username": user_data['username'], "password": password.text};
  //   try {
  //     final response = await http.post(url, headers: headers, body: body);
  //     if (response.statusCode == 200) {
  //       print("It's Working...");
  //       var data = jsonDecode(response.body);
  //       //print(data);
  //       if (data["status"] == "ok") {
  //         Navigator.pop(context);
  //         Navigator.popAndPushNamed(context, "/login");
  //         status("Alert", "Password changed successfully!");
  //       } else {
  //         Navigator.pop(context);
  //         status("Alert", data["status"]);
  //       }
  //     } else {
  //       Navigator.pop(context);
  //       status(
  //         "Connection Error",
  //         "check your internet connection and try again!",
  //       );
  //     }
  //   } catch (e) {
  //     Navigator.pop(context);
  //     status(
  //       "Unexpected Error",
  //       "Could ne not connect, check your internet connection and try again! ${e.toString()}",
  //     );
  //   }
  // }

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
                    Text("Change Passowrd", style: TextStyle(fontSize: 20)),
                    SizedBox(height: 30), // Space between title and fields
                    TextFormField(
                      controller: password,
                      decoration: InputDecoration(
                        labelText: 'Enter new password',
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: theme.primaryColor),
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
                    ),
                    SizedBox(height: 16.0), // Spacing between fields
                    TextFormField(
                      controller: cpassword,
                      decoration: InputDecoration(
                        labelText: 'Confirm password',
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
                      obscureText: true, // Hide password
                    ),
    
                    SizedBox(height: 24.0), // Spacing before the login button
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          process();
                          //change_password();
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
                      child: Text('Change Password'),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            // Navigate to login page
                            Navigator.popAndPushNamed(context, "/login");
                          },
                          child: Text(
                            'Back to login Page',
                            style: TextStyle(color: theme.primaryColor),
                          ),
                        ),
                      ],
                    ),
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
