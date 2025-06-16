import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/theme/theme_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_state.dart';
import 'package:itdata/features/dashboard/dashboard.dart';
import 'package:itdata/features/settings/notification.dart';
import 'package:itdata/features/settings/security.dart';
import 'package:itdata/features/settings/theme.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

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
              icon: Icon(Icons.arrow_back, color: theme.secondaryColor),
            ),
            title: Text("Settings", style: TextStyle(color: theme.secondaryColor)),
            backgroundColor: theme.primaryColor,
          ),
          body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: [
                ListTile(
                  onTap:
                      (() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Security()))),
                  title: Text(
                    "Account Security",
                    style: TextStyle(fontSize: 25,),
                  ),
                  leading: Icon(Icons.admin_panel_settings, size: 25),
                ),
                Divider(thickness: 1),
                ListTile(
                  onTap:
                      (() =>
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NotificationSetting()))),
                  title: Text("Notification", style: TextStyle(fontSize: 25)),
                  leading: Icon(Icons.notifications, size: 25),
                ),
                Divider(thickness: 1),
                ListTile(
                  onTap: (() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ThemePage()))),
                  title: Text("Theme", style: TextStyle(fontSize: 25)),
                  leading: Icon(Icons.format_paint, size: 25),
                ),
                Divider(thickness: 1),
                ListTile(
                  title: Text(
                    "Delete Account",
                    style: TextStyle(fontSize: 25),
                  ),
                  leading: Icon(Icons.delete, size: 25),
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
