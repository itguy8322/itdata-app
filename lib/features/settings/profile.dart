// ignore_for_file: sort_child_properties_last, no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/theme/theme_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_state.dart';
import 'package:itdata/data/cubits/user-data/user_data_cubit.dart';
import 'package:itdata/data/cubits/user-data/user_state.dart';
import 'package:itdata/data/models/user/user.dart';
import 'package:itdata/features/dashboard/dashboard.dart';

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
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, theme) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Dashboard()));
              },
              icon: Icon(Icons.arrow_back, color: theme.secondaryColor,),
            ),
            title: Text("Profile", style: TextStyle(color: theme.secondaryColor)),
            backgroundColor: theme.primaryColor,
          ),
          body: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: BlocBuilder<UserDataCubit, UserState>(
                builder: (context, state) {
                  if (state.userData != null) {
                    print("SUCCESSSSSSS");
                    print(state.userData);
                    fullname.text = state.userData!.name!;
                    username.text = state.userData!.id!;
                    phone.text = state.userData!.phone!;
                    address.text = state.userData!.address!;
                    password.text = "password";
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
        
                              if (_formKey.currentState!.validate()) {
                                UserData user = UserData();
                                user.name = fullname.text;
                                user.phone = phone.text;
                                user.address = address.text;
                                process();
                                context.read<UserDataCubit>().update_data(
                                  "users",
                                  username.text,
                                  user,
                                );
                              }
                            },
                            child: Text('Update Profile', style: TextStyle(color: theme.secondaryColor),),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.primaryColor,
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
        );
      }
    );
  }
}
