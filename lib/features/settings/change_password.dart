import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/theme/theme_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_state.dart';
import 'package:itdata/features/settings/security.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController oldPassword = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, theme) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Security()));
              },
              icon: Icon(Icons.arrow_back, color: theme.secondaryColor),
            ),
            title: Text("Change Password", style: TextStyle(color: theme.secondaryColor)),
            backgroundColor: theme.primaryColor,
          ),
          body: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30), // Space between title and fields
                  TextFormField(
                    controller: oldPassword,
                    decoration: InputDecoration(
                      labelText: 'Old Password',
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
                  ),
    
                  SizedBox(height: 20.0), // Spacing between fields
                  TextFormField(
                    controller: password,
                    decoration: InputDecoration(
                      labelText: 'Password',
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
                  SizedBox(height: 20.0), // Spacing between fields
                  TextFormField(
                    controller: confirmPassword,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
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
                  SizedBox(height: 10.0),
                  // Sign Up Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Show error message for mismatched passwords
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Passwords do not match")),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                        padding: EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 15,
                        ),
                        textStyle: TextStyle(fontSize: 18, color: theme.secondaryColor),
                      ),
                      child: Text('Change Password'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
