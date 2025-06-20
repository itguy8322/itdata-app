// ignore_for_file: sort_child_properties_last, no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/core/dialogs/process_dialog.dart';
import 'package:itdata/data/cubits/theme/theme_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_state.dart';
import 'package:itdata/data/cubits/user-data/user_data_cubit.dart';
import 'package:itdata/data/cubits/user-data/user_state.dart';
import 'package:itdata/features/dashboard/dashboard.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

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
                    //print("SUCCESSSSSSS");
                    //print(state.userData);
                    fullname.text = state.userData!.name!;
                    username.text = state.userData!.id!;
                    phone.text = state.userData!.phone!;
                    address.text = state.userData!.address!;
                    // password.text = "password";
                    return Column(
                      children: [
                        
                        Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 100,
                                child: Image.asset(
                                  "assets/images/profile.png",
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: CircleAvatar(
                                  backgroundColor: theme.primaryColor,
                                  child: IconButton(
                                    icon: Icon(Icons.camera_alt_rounded, color: theme.secondaryColor, size: 25,),
                                    onPressed: () {
                                      // Handle profile picture change
                                      showTopSnackBar(
                                        Overlay.of(context),
                                        snackBarPosition: SnackBarPosition.bottom,
                                        CustomSnackBar.info(
                                          message: "Profile picture change feature coming soon!",
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                                    
                        MultiBlocListener(listeners: [
                          BlocListener<UserDataCubit, UserState>(
                            listener: (context, state) {
                              if (state.uesrDataInProgress) {
                                showProcessDialog(context, label: "Updating profile...");
                              }
                              else if (state.userDataSuccess) {
                                Navigator.pop(context);
                                showTopSnackBar(
                                  Overlay.of(context),
                                  snackBarPosition: SnackBarPosition.bottom,
                                  CustomSnackBar.success(
                                    message: "Profile updated successfully",
                                  ),
                                );
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Dashboard()));
                              } else if (state.userDataFailure) {
                                Navigator.pop(context);
                                showTopSnackBar(
                                  Overlay.of(context),
                                  snackBarPosition: SnackBarPosition.bottom,
                                  CustomSnackBar.error(
                                    message: "Failed to update profile",
                                  ),
                                );
                              }
                            },
                          ),
                        ], child: SizedBox(height: 30))
                        , // Space between title and fields
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
                                final user = state.userData;
                                user?.name = fullname.text;
                                user?.phone = phone.text;
                                user?.address = address.text;
                                if (user?.password == password.text) {
                                  context.read<UserDataCubit>().update_data(
                                  "users",
                                  user!.id!,
                                  user,
                                );
                                } else {
                                 showTopSnackBar(
                                  Overlay.of(context),
                                  snackBarPosition: SnackBarPosition.bottom,
                                  CustomSnackBar.error(
                                    message: "Password does not match",
                                  ),
                                );
                                }
                                
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
