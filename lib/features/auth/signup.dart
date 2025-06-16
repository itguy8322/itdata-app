// ignore_for_file: sort_child_properties_last, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/core/dialogs/alert_dialog.dart';
import 'package:itdata/core/dialogs/process_dialog.dart';
import 'package:itdata/data/cubits/auth/auth_cubit.dart';
import 'package:itdata/data/cubits/auth/auth_state.dart';
import 'package:itdata/data/cubits/input-validations/input-validatiions/email-input.dart';
import 'package:itdata/data/cubits/input-validations/input-validatiions/name_input.dart';
import 'package:itdata/data/cubits/input-validations/input-validatiions/number_input.dart';
import 'package:itdata/data/cubits/input-validations/input-validatiions/password_input.dart';
import 'package:itdata/data/cubits/input-validations/input-validatiions/text_input.dart';
import 'package:itdata/data/cubits/input-validations/input_validation_cubit.dart';
import 'package:itdata/data/cubits/input-validations/input_validation_state.dart';
import 'package:itdata/data/cubits/network-providers/network_providers_cubit.dart';
import 'package:itdata/data/cubits/notification/notification_list_cubit.dart';
import 'package:itdata/data/cubits/services/airtime/airtime_cubit.dart';
import 'package:itdata/data/cubits/services/cable/cable_cubit.dart';
import 'package:itdata/data/cubits/services/data/data_cubit.dart';
import 'package:itdata/data/cubits/services/edu/edu_cubit.dart';
import 'package:itdata/data/cubits/services/electricity/electricity_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_state.dart';
import 'package:itdata/data/cubits/transaction/transaction_cubit.dart';
import 'package:itdata/data/cubits/user-data/user_data_cubit.dart';
import 'package:itdata/features/settings/change_pin.dart';
import 'package:itdata/services/network_providers_service.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController fullname = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController number = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, theme) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    BlocListener<AuthCubit, AuthState>(
                      listener: (context, state) async {
                        if (state is SignupLoading) {
                          showProcessDialog(context);
                        } else if (state is SignupSuccess) {
                          final id = state.userInfo?.id;
                          print("AM LOGGED IN");
                          context.read<UserDataCubit>().setUser(
                            state.userInfo!,
                            isNewUser: true
                          );
                          context.read<NotificationListCubit>().setUserId(id!);
                          context.read<TransactionCubit>().setUserId(id);
                          final networkProviders = await NetworkProvidersService().loadNetworkProviders();
                          context.read<NetworkProvidersCubit>().setNetworkProviders(networkProviders);
                          context.read<AirtimeCubit>().loadAirtimeTypes();
                          context.read<DataCubit>().loadDataPlans();
                          context.read<CableCubit>().loadCablePlans();
                          context.read<EduCubit>().loadExamTypes();
                          context.read<ElectricityCubit>().loadDiscos();
                          print("<============ PASSED ===============>");
                          Navigator.pop(context);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ChangePin()));
                        } else if (state is SignupFailure) {
                          Navigator.pop(context);
                          showAlertDialog(context, "Alert", state.message!);
                        }
                      },
                      child: SizedBox(height: 50),
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
                      height: MediaQuery.sizeOf(context).height * 0.05,
                    ),
    
                    // Already have an account?
                    SizedBox(
                      width: MediaQuery.sizeOf(context).height,
                      child: Column(
                        children: [
                          Text(
                            "Sign Up.",
                            style: TextStyle(
                              color: theme.primaryColor,
                              fontSize: 44,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Create an account",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Already have an account? "),
                              TextButton(
                                onPressed: () {
                                  // Navigate to login page
                                  context.read<AuthCubit>().setInitial();
                                  context
                                      .read<InputValidationCubit>()
                                      .reInitialize();
                                  Navigator.popAndPushNamed(
                                    context,
                                    "/login",
                                  );
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: theme.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ), // Space between title and fields
                          BlocBuilder<
                            InputValidationCubit,
                            InputValidationState
                          >(
                            builder: (context, state) {
                              return TextFormField(
                                controller: fullname,
                                decoration: InputDecoration(
                                  error:
                                      state.nameInput.error ==
                                              NameInputError.empty
                                          ? Text(
                                            "Full name required",
                                            style: TextStyle(
                                              color: Colors.redAccent,
                                            ),
                                          )
                                          : state.nameInput.error ==
                                              NameInputError.invalid
                                          ? Text(
                                            "Invalid name",
                                            style: TextStyle(
                                              color: Colors.redAccent,
                                            ),
                                          )
                                          : null,
                                  labelText: 'Full Name',
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
                                      .onNameInputChanged(value);
                                },
                              );
                            },
                          ),
                          SizedBox(height: 10.0),
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
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value) {
                                  context
                                      .read<InputValidationCubit>()
                                      .onEamilInputChanged(value);
                                },
                              );
                            },
                          ),
                          SizedBox(height: 10.0),
                          BlocBuilder<
                            InputValidationCubit,
                            InputValidationState
                          >(
                            builder: (context, state) {
                              return TextFormField(
                                controller: address,
                                decoration: InputDecoration(
                                  error:
                                      state.textInput.error ==
                                              TextInputError.empty
                                          ? Text(
                                            "Address required",
                                            style: TextStyle(
                                              color: Colors.redAccent,
                                            ),
                                          )
                                          : null,
                                  labelText: 'Address',
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
                              );
                            },
                          ),
                          SizedBox(height: 10.0),
                          BlocBuilder<
                            InputValidationCubit,
                            InputValidationState
                          >(
                            builder: (context, state) {
                              return TextFormField(
                                controller: number,
                                keyboardType: TextInputType.phone,
                                maxLength: 11,
                                decoration: InputDecoration(
                                  error:
                                      state.numberInput.error ==
                                              NumberInputError.empty
                                          ? Text(
                                            "Phone required",
                                            style: TextStyle(
                                              color: Colors.redAccent,
                                            ),
                                          )
                                          : state.numberInput.error ==
                                              NumberInputError.invalid
                                          ? Text(
                                            "Invalid phone number",
                                            style: TextStyle(
                                              color: Colors.redAccent,
                                            ),
                                          )
                                          : null,
                                  labelText: 'Phone Number',
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
                                      .onNumberInputChanged(value);
                                },
                              );
                            },
                          ),
                          SizedBox(height: 10.0), // Spacing between fields
                          BlocBuilder<
                            InputValidationCubit,
                            InputValidationState
                          >(
                            builder: (context, state) {
                              return TextFormField(
                                controller: password,
                                decoration: InputDecoration(
                                  error:
                                      state.passwordInput.error ==
                                              PasswordInputError.empty
                                          ? Text(
                                            "Password required",
                                            style: TextStyle(
                                              color: Colors.redAccent,
                                            ),
                                          )
                                          : state.passwordInput.error ==
                                              PasswordInputError.invalid
                                          ? Text(
                                            "Password must be at least 8 characters long and contain at least one uppercase, one lowercase letter, one number, and one special character. ",
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
                                      .onPasswordInputChanged(value);
                                },
                                obscureText: true, // Hide password
                              );
                            },
                          ),
                          SizedBox(height: 10.0),
                          // Sign Up Button
                          Center(
                            child: BlocBuilder<
                              InputValidationCubit,
                              InputValidationState
                            >(
                              builder: (context, state) {
                                return ElevatedButton(
                                  onPressed: () {
                                    // Handle sign-up logic (e.g., validation, API call)
    
                                    if (state.nameInput.isValid! &&
                                        state.emailInput.isValid! &&
                                        state.textInput.isValid! &&
                                        state.numberInput.isValid! &&
                                        state.passwordInput.isValid!) {
                                      
                                      context
                                          .read<AuthCubit>()
                                          .signup(email.text, password.text, {
                                            "id": email.text.split("@")[0],
                                            "name": fullname.text,
                                            "email": email.text,
                                            "phone": number.text,
                                            "address": address.text,
                                            "pin": "",
                                            "bvn": "",
                                            "password": password.text,
                                            "wallet_bal": "1550.00",
                                          });
                                    } else {
                                      context
                                          .read<InputValidationCubit>()
                                          .onNameInputChanged(fullname.text);
    
                                      context
                                          .read<InputValidationCubit>()
                                          .onEamilInputChanged(email.text);
    
                                      context
                                          .read<InputValidationCubit>()
                                          .onTextInputChanged(address.text);
    
                                      context
                                          .read<InputValidationCubit>()
                                          .onNumberInputChanged(number.text);
    
                                      context
                                          .read<InputValidationCubit>()
                                          .onPasswordInputChanged(
                                            password.text,
                                          );
                                    }
    
                                    // Optionally, navigate to the login page or dashboard
                                  },
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: theme.secondaryColor,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: theme.primaryColor,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 50,
                                      vertical: 15,
                                    ),
                                    textStyle: TextStyle(
                                      fontSize: 18,
                                      color: theme.secondaryColor,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
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
