// ignore_for_file: sort_child_properties_last, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/cubits/login_cubit.dart';
import 'package:itdata/cubits/storage_cubit.dart';
import 'package:itdata/cubits/user_data_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  void status(var _title, var status) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(title: Text(_title), content: Text(status)),
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

  @override
  Widget build(BuildContext context) {
    final storage = BlocProvider.of<StorageCubit>(context);
    final login = BlocProvider.of<LoginCubit>(context);
    final user_d = BlocProvider.of<UserDataCubit>(context);
    return PopScope(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  BlocListener<LoginCubit, Map<String, dynamic>>(
                    listener: (context, stat) {
                      if (!stat["isloading"]) {
                        if (stat["status"] == "logged") {
                          print("AM LOGGED IN");
                          Navigator.pop(context);
                          Navigator.popAndPushNamed(context, "/dashboard");
                        } else {
                          print("AM NOT LOGGED IN");
                          Navigator.pop(context);
                          status("Alert", stat["status"]);
                        }
                      }
                    },
                    child: SizedBox(height: 30),
                  ),

                  Row(
                    children: [
                      Image.asset("assets/images/data_app_logo.png", scale: 40),
                      Text(
                        'IT Data',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(82, 101, 140, 1),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(height: 70),
                  Text(
                    "Sign in to your account",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 30), // Space between title and fields
                  TextFormField(
                    controller: username,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: TextStyle(color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(82, 101, 140, 1),
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
                  ),
                  SizedBox(height: 16.0), // Spacing between fields
                  TextFormField(
                    controller: password,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(82, 101, 140, 1),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          // Navigate to login page
                          Navigator.popAndPushNamed(
                            context,
                            "/forgot_password",
                          );
                        },
                        child: Text(
                          'Forget Password?',
                          style: TextStyle(
                            color: Color.fromRGBO(82, 101, 140, 1),
                          ),
                        ),
                      ),
                      MultiBlocListener(
                        listeners: [
                          BlocListener<LoginCubit, Map<String, dynamic>>(
                            listener: (context, state) {
                              if (state["status"] == "ok") {
                                user_d.set_user_id(username.text);
                                Navigator.popAndPushNamed(
                                  context,
                                  "/dashboard",
                                );
                              }
                            },
                          ),
                        ],
                        child: BlocBuilder<StorageCubit, Map<String, dynamic>>(
                          builder: (context, state) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: 10,
                                  child: Checkbox(
                                    checkColor: Colors.white,
                                    activeColor: Color.fromRGBO(
                                      82,
                                      101,
                                      140,
                                      1,
                                    ),
                                    value: state["remember_me"],
                                    onChanged: (value) {
                                      storage.set_remember_me(
                                        username.text,
                                        password.text,
                                      );
                                    },
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Navigate to login page
                                    storage.set_remember_me(
                                      username.text,
                                      password.text,
                                    );
                                  },
                                  child: Text(
                                    'Remember me',
                                    style: TextStyle(
                                      color: Color.fromRGBO(82, 101, 140, 1),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.0), // Spacing before the login button
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        process();
                        login.login(username.text, password.text);
                      }
                    },
                    child: Text('Login'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(82, 101, 140, 1),
                      padding: EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 15,
                      ),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Don't have an account? "),
                      TextButton(
                        onPressed: () {
                          // Navigate to login page
                          Navigator.popAndPushNamed(context, "/signup");
                        },
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                            color: Color.fromRGBO(82, 101, 140, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to login page
                      Navigator.popAndPushNamed(context, "/landing");
                    },
                    child: Text(
                      'Go to main page',
                      style: TextStyle(color: Color.fromRGBO(82, 101, 140, 1)),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Test Mode',
                        style: TextStyle(
                          color: Color.fromRGBO(82, 101, 140, 1),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      onPopInvokedWithResult: (b, t) async {},
    );
  }
}
