import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/app-settings/app_settings_cubit.dart';
import 'package:itdata/data/cubits/app-settings/app_settings_state.dart';
import 'package:itdata/data/cubits/theme/theme_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_state.dart';
import 'package:itdata/features/settings/bvn_verification.dart';
import 'package:itdata/features/settings/change_password.dart';
import 'package:itdata/features/settings/change_pin.dart';
import 'package:itdata/features/settings/settings.dart';

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
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, theme) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Settings()));
              },
              icon: Icon(Icons.arrow_back, color: theme.secondaryColor),
            ),
            title: Text("Security", style: TextStyle(color: theme.secondaryColor)),
            backgroundColor: theme.primaryColor,
          ),
          body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: [
                ListTile(
                  onTap:
                      (() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ChangePassword()))),
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
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ChangePin()))),
                  title: Text(
                    "Change Transaction Pin",
                    style: TextStyle(fontSize: 25),
                  ),
                  leading: Icon(Icons.lock, size: 25),
                ),
                Divider(thickness: 1),
                BlocBuilder<AppSettingsCubit, AppSettingsState>(
                  builder: (context, settings) {
                    return ListTile(
                      title: Text("Biometric", style: TextStyle(fontSize: 25)),
                      leading: Icon(Icons.fingerprint, size: 25),
                      trailing: Switch(
                        value: settings.isBiometricAuthEnabled,
                        activeColor: theme.primaryColor,
                        onChanged: (value) async {
                          context.read<AppSettingsCubit>().setBiometricAuthEnabled(value);
                          // setState(() {
                          //   biometric = value;
                          // });
                          // await storage.write(
                          //   key: 'biometric',
                          //   value: "${biometric.toString()}",
                          // );
                        },
                      ),
                    );
                  }
                ),
                Divider(thickness: 1),
                ListTile(
                  onTap:
                      (() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BVNVerifiaction()))),
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
    );
  }
}
