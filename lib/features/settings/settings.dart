import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

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
          title: Text("Settings"),
          backgroundColor: mainColor,
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              ListTile(
                onTap: (() => Navigator.popAndPushNamed(context, "/security")),
                title: Text("Account Security", style: TextStyle(fontSize: 25)),
                leading: Icon(Icons.admin_panel_settings, size: 25),
              ),
              Divider(thickness: 1),
              ListTile(
                onTap:
                    (() => Navigator.popAndPushNamed(context, "/notisetting")),
                title: Text("Notification", style: TextStyle(fontSize: 25)),
                leading: Icon(Icons.notifications, size: 25),
              ),
              Divider(thickness: 1),
              ListTile(
                onTap: (() => Navigator.popAndPushNamed(context, "/theme")),
                title: Text("Theme", style: TextStyle(fontSize: 25)),
                leading: Icon(Icons.format_paint, size: 25),
              ),
              Divider(thickness: 1),
              ListTile(
                title: Text("Delete Account", style: TextStyle(fontSize: 25)),
                leading: Icon(Icons.delete, size: 25),
              ),
              Divider(thickness: 1),
            ],
          ),
        ),
      ),
      onPopInvokedWithResult: (b, t) async {
        Navigator.popAndPushNamed(context, "/dashboard");
      },
    );
  }
}
