// ignore_for_file: sort_child_properties_last, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/core/dialogs/alert_dialog.dart';
import 'package:itdata/core/dialogs/process_dialog.dart';
import 'package:itdata/data/cubits/auth/auth_cubit.dart';
import 'package:itdata/data/cubits/auth/auth_state.dart';
import 'package:itdata/data/cubits/input-validations/input-validatiions/email-input.dart';
import 'package:itdata/data/cubits/input-validations/input-validatiions/text_input.dart';
import 'package:itdata/data/cubits/input-validations/input_validation_cubit.dart';
import 'package:itdata/data/cubits/input-validations/input_validation_state.dart';
import 'package:itdata/data/cubits/storage/storage_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_state.dart';
import 'package:itdata/data/cubits/user-data/user_data_cubit.dart';
import 'package:itdata/features/auth/signup.dart';
import 'package:itdata/features/dashboard/dashboard.dart';
import 'package:itdata/init-screens/landing_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController email = TextEditingController(text: "");
  final TextEditingController password = TextEditingController(text: "");
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final storage = BlocProvider.of<StorageCubit>(context);
    final login = BlocProvider.of<AuthCubit>(context);
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, theme) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    BlocListener<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is LoginLoading) {
                          showProcessDialog(context);
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
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));
                        } else if (state is LoginFailure) {
                          print("AM NOT LOGGED IN");
                          Navigator.pop(context);
                          showAlertDialog(context, "Alert", state.message!);
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
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.15,
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).height,
                      child: Column(
                        children: [
                          Text(
                            "Sign In.",
                            style: TextStyle(
                              color: theme.primaryColor,
                              fontSize: 44,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                          BlocBuilder<
                            InputValidationCubit,
                            InputValidationState
                          >(
                            builder: (context, state) {
                              return TextFormField(
                                controller: email,
                                decoration: InputDecoration(
                                  error:
                                      state.emailInput.error ==
                                              EmailInputError.empty
                                          ? Text(
                                            "Email required",
                                            style: TextStyle(
                                              color: Colors.redAccent,
                                            ),
                                          )
                                          : state.emailInput.error ==
                                              EmailInputError.invalid
                                          ? Text(
                                            "Invalid email address",
                                            style: TextStyle(
                                              color: Colors.redAccent,
                                            ),
                                          )
                                          : null,
                                  labelText: 'Email',
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
                                onChanged: (value) {
                                  context
                                      .read<InputValidationCubit>()
                                      .onEamilInputChanged(value);
                                },
                              );
                            },
                          ),
                          SizedBox(height: 16.0), // Spacing between fields
                          BlocBuilder<
                            InputValidationCubit,
                            InputValidationState
                          >(
                            builder: (context, state) {
                              return TextFormField(
                                controller: password,
                                decoration: InputDecoration(
                                  error:
                                      state.textInput.error ==
                                              TextInputError.empty
                                          ? Text(
                                            "Password required",
                                            style: TextStyle(
                                              color: Colors.redAccent,
                                            ),
                                          )
                                          : null,
                                  labelText: 'Password',
                                  labelStyle: TextStyle(color: Colors.grey),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: theme.primaryColor,
                                    ),
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value) {
                                  context
                                      .read<InputValidationCubit>()
                                      .onTextInputChanged(value);
                                },
                                obscureText: true, // Hide password
                              );
                            },
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
                                          email.text,
                                          password.text,
                                        );
                                      },
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Navigate to login page
                                      storage.set_remember_me(
                                        email.text,
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
                          BlocBuilder<
                            InputValidationCubit,
                            InputValidationState
                          >(
                            builder: (context, state) {
                              return ElevatedButton(
                                onPressed: () async {
                                  if (state.emailInput.isValid! &&
                                      state.textInput.isValid!) {
                                    login.login(email.text, password.text);
                                  } else {
                                    context
                                        .read<InputValidationCubit>()
                                        .onEamilInputChanged(email.text);
                                    context
                                        .read<InputValidationCubit>()
                                        .onTextInputChanged(password.text);
                                  }
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: theme.secondaryColor,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.primaryColor,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 50,
                                    vertical: 15,
                                  ),
                                  textStyle: TextStyle(fontSize: 18),
                                ),
                              );
                            },
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
                                  context
                                      .read<InputValidationCubit>()
                                      .reInitialize();
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupPage()));
                                },
                                child: Text(
                                  'Create Account',
                                  style: TextStyle(
                                    color: theme.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              // Navigate to login page
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>LandingPage()));
                            },
                            child: Text(
                              'Go to main page',
                              style: TextStyle(
                                color: theme.primaryColor,
                                fontWeight: FontWeight.bold,
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
                          style: TextStyle(color: theme.primaryColor),
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
