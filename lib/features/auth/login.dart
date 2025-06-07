// ignore_for_file: sort_child_properties_last, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/auth/auth_cubit.dart';
import 'package:itdata/data/cubits/auth/auth_state.dart';
import 'package:itdata/data/cubits/storage/storage_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_state.dart';
import 'package:itdata/data/cubits/user-data/user_data_cubit.dart';

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
    final login = BlocProvider.of<AuthCubit>(context);
    return PopScope(
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, theme) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      BlocListener<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state is LoginLoading) {
                            process();
                          }
                          if (state is LoginSucess) {
                            print("AM LOGGED IN");
                            Navigator.pop(context);
                            print("<============ USER DATA ===============>");
                            print(state.userInfo);
                            print("<============ USER DATA ===============>");
                            print(state.userInfo!.email);
                            context.read<UserDataCubit>().setUser(
                              state.userInfo!,
                            );
                            print("<============ PASSED ===============>");
                            Navigator.popAndPushNamed(context, "/dashboard");
                          } else if (state is LoginFailure) {
                            print("AM NOT LOGGED IN");
                            Navigator.pop(context);
                            status("Alert", state.message);
                          }
                        },
                        child: SizedBox(height: 30),
                      ),

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
                      SizedBox(height: MediaQuery.sizeOf(context).height * 0.2),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).height,
                        child: Column(
                          children: [
                            Text(
                              "Sign in to your account",
                              style: TextStyle(
                                fontSize: 20,
                                color: theme.textColor,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ), // Space between title and fields
                            TextFormField(
                              controller: username,
                              decoration: InputDecoration(
                                labelText: 'Username',
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
                            ),
                            SizedBox(height: 16.0), // Spacing between fields
                            TextFormField(
                              controller: password,
                              decoration: InputDecoration(
                                labelText: 'Password',
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
                                    style: TextStyle(color: theme.primaryColor),
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: 10,
                                      child: Checkbox(
                                        checkColor: Colors.white,
                                        activeColor: theme.primaryColor,
                                        value: true,
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
                                          color: theme.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 24.0,
                            ), // Spacing before the login button
                            ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  login.login(username.text, password.text);
                                }
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(color: theme.secondaryColor),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.primaryColor,
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
                                    context.read<AuthCubit>().setInitial();
                                    Navigator.popAndPushNamed(
                                      context,
                                      "/signup",
                                    );
                                  },
                                  child: Text(
                                    'Create Account',
                                    style: TextStyle(color: theme.primaryColor),
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
                                style: TextStyle(
                                  color: Color.fromRGBO(82, 101, 140, 1),
                                ),
                              ),
                            ),
                          ],
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
          );
        },
      ),
      onPopInvokedWithResult: (b, t) async {},
    );
  }
}
