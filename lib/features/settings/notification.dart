import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/app-settings/app_settings_cubit.dart';
import 'package:itdata/data/cubits/app-settings/app_settings_state.dart';
import 'package:itdata/data/cubits/theme/theme_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_state.dart';
import 'package:itdata/features/settings/settings.dart';

class NotificationSetting extends StatefulWidget {
  const NotificationSetting({super.key});

  @override
  State<NotificationSetting> createState() => _NotificationState();
}

class _NotificationState extends State<NotificationSetting> {
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
            title: Text("Notification Settings", style: TextStyle(color: theme.secondaryColor),),
            backgroundColor: theme.primaryColor,
          ),
          body: BlocBuilder<AppSettingsCubit, AppSettingsState>(
            builder: (context, settings) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: ListView(
                  children: [
                    ListTile(
                      title: Text(
                        "Push Notification",
                        style: TextStyle(fontSize: 25),
                      ),
                      trailing: Switch(
                        value: settings.isPushNotificationsEnabled,
                        activeColor: theme.primaryColor,
                        onChanged: (value) async {
                          context.read<AppSettingsCubit>().setPushNotificationsEnabled(value);
                          //print("hello");
                          setState(() {
                            // pushnotify = value;
                          });
                          // await storage.write(
                          //   key: 'pushnotify',
                          //   value: "${pushnotify.toString()}",
                          // );
                        },
                      ),
                    ),
                    Divider(thickness: 1),
                    ListTile(
                      title: Text(
                        "Email Notification",
                        style: TextStyle(fontSize: 25),
                      ),
                      trailing: Switch(
                        value: settings.isEmailNotificationsEnabled,
                        activeColor: theme.primaryColor,
                        onChanged: (value) async {
                          context.read<AppSettingsCubit>().setEmailNotificationsEnabled(value);
                          if (value == true) {}
                          // setState(() {
                          //   emailnotify = value;
                          // });
                          // await storage.write(
                          //   key: 'emailnotify',
                          //   value: "${emailnotify.toString()}",
                          // );
                        },
                      ),
                    ),
                    Divider(thickness: 1),
                  ],
                ),
              );
            }
          ),
        );
      },
    );
  }
}
