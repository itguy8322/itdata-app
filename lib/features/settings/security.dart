import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/theme/theme_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_state.dart';

class Security extends StatefulWidget {
  const Security({super.key});

  @override
  State<Security> createState() => _SecurityState();
}

class _SecurityState extends State<Security> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, theme) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, "/settings");
                },
                icon: Icon(Icons.arrow_back),
              ),
              title: Text("Security"),
              backgroundColor: theme.primaryColor,
            ),
            body: Padding(
              padding: EdgeInsets.all(10),
              child: ListView(
                children: [
                  ListTile(
                    onTap:
                        (() => Navigator.popAndPushNamed(
                          context,
                          "/changepassword",
                        )),
                    title: Text(
                      "Change Password",
                      style: TextStyle(fontSize: 25),
                    ),
                    leading: Icon(Icons.security, size: 25),
                  ),
                  Divider(thickness: 1),
                  ListTile(
                    onTap:
                        (() =>
                            Navigator.popAndPushNamed(context, "/changepin")),
                    title: Text(
                      "Change Transaction Pin",
                      style: TextStyle(fontSize: 25),
                    ),
                    leading: Icon(Icons.lock, size: 25),
                  ),
                  Divider(thickness: 1),
                  ListTile(
                    title: Text("Biometric", style: TextStyle(fontSize: 25)),
                    leading: Icon(Icons.fingerprint, size: 25),
                    trailing: Switch(
                      value: true,
                      activeColor: theme.primaryColor,
                      onChanged: (value) async {
                        // setState(() {
                        //   biometric = value;
                        // });
                        // await storage.write(
                        //   key: 'biometric',
                        //   value: "${biometric.toString()}",
                        // );
                      },
                    ),
                  ),
                  Divider(thickness: 1),
                  ListTile(
                    onTap:
                        (() => Navigator.popAndPushNamed(
                          context,
                          "/bvn_verification",
                        )),
                    title: Text(
                      "BVN Verification",
                      style: TextStyle(fontSize: 25),
                    ),
                    leading: Icon(Icons.security, size: 25),
                  ),
                  Divider(thickness: 1),
                ],
              ),
            ),
          );
        },
      ),
      onPopInvokedWithResult: (b, t) async {
        Navigator.popAndPushNamed(context, "/settings");
      },
    );
  }
}
