// ignore_for_file: sort_child_properties_last, no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/user-data/user_data_cubit.dart';
import 'package:itdata/states/user_states.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController fullname = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController password = TextEditingController();
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
  }

  void updateProfile() async {}

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, "/dashboard");
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Text("Profile"),
          backgroundColor: Color.fromRGBO(82, 101, 140, 1),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: BlocBuilder<UserDataCubit, UserStates>(
              builder: (context, state) {
                if (state is UserLoaded) {
                  print("SUCCESSSSSSS");
                  print(state.user);
                  fullname.text = state.user["fullname"];
                  username.text = state.user["username"];
                  phone.text = state.user["tel"];
                  address.text = state.user["address"];
                  password.text = state.user["password"];
                  return Column(
                    children: [
                      SizedBox(height: 30), // Space between title and fields
                      TextFormField(
                        controller: fullname,
                        //initialValue: state.user['fullname'].toString(),
                        decoration: InputDecoration(
                          labelText: 'Full Name',
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
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        controller: username,
                        readOnly: true,
                        //initialValue: state.user['username'],
                        decoration: InputDecoration(
                          labelText: 'Username',
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
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        controller: phone,
                        maxLength: 11,
                        //initialValue: state.user['tel'],
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
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
                      ),

                      SizedBox(height: 10.0),
                      TextFormField(
                        controller: address,
                        //initialValue: state.user['address'],
                        decoration: InputDecoration(
                          labelText: 'Address',
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
                      ),
                      SizedBox(height: 10.0), // Spacing between fields
                      TextFormField(
                        controller: password,
                        // initialValue: state.user['password'],
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
                      ), // Spacing between fields

                      SizedBox(height: 10.0),
                      // Sign Up Button
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle sign-up logic (e.g., validation, API call)
                            if (password.text == state.user['password']) {
                              if (_formKey.currentState!.validate()) {
                                state.user["fullname"] = fullname.text;
                                state.user["username"] = fullname.text;
                                state.user["tel"] = fullname.text;
                                state.user["address"] = fullname.text;
                                state.user["password"] = fullname.text;
                                process();
                                context.read<UserDataCubit>().update_data(
                                  "users",
                                  username.text,
                                  state.user,
                                );
                              }
                              // Proceed with registration
                              //signup();
                              // Optionally, navigate to the login page or dashboard
                            } else {
                              // Show error message for mismatched passwords
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Passwords do not match"),
                                ),
                              );
                            }
                          },
                          child: Text('Update Profile'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(82, 101, 140, 1),
                            padding: EdgeInsets.symmetric(
                              horizontal: 50,
                              vertical: 15,
                            ),
                            textStyle: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: Text("User information cannot be loaded"),
                  );
                }
              },
            ),
          ),
        ),
      ),
      onPopInvokedWithResult: (b, t) async {
        Navigator.popAndPushNamed(context, "/dashboard");
      },
    );
  }
}
