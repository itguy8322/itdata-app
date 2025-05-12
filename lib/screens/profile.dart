// ignore_for_file: sort_child_properties_last, no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/cubits/user_data_cubit.dart';

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
            child: BlocBuilder<UserDataCubit, Map<String, dynamic>>(
              builder: (context, user_data) {
                fullname.text = user_data["fullname"];
                username.text = user_data["username"];
                phone.text = user_data["tel"].toString();
                address.text = user_data["address"];
                password.text = user_data["password"];
                return Column(
                  children: [
                    SizedBox(height: 30), // Space between title and fields
                    TextFormField(
                      controller: fullname,
                      //initialValue: user_data['fullname'].toString(),
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
                      //initialValue: user_data['username'],
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
                      //initialValue: user_data['tel'],
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
                      //initialValue: user_data['address'],
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
                      // initialValue: user_data['password'],
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
                          if (password.text == user_data['password']) {
                            if (_formKey.currentState!.validate()) {
                              user_data["fullname"] = fullname.text;
                              user_data["username"] = fullname.text;
                              user_data["tel"] = fullname.text;
                              user_data["address"] = fullname.text;
                              user_data["password"] = fullname.text;
                              process();
                              context.read<UserDataCubit>().update_data(
                                "users",
                                username.text,
                                user_data,
                              );
                            }
                            // Proceed with registration
                            //signup();
                            // Optionally, navigate to the login page or dashboard
                          } else {
                            // Show error message for mismatched passwords
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Passwords do not match")),
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
