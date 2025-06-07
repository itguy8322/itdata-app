import 'package:flutter/material.dart';

class Notification extends StatefulWidget {
  const Notification({super.key});

  @override
  State<Notification> createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, "/settings");
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Text("Notification Settings"),
          backgroundColor: mainColor,
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              ListTile(
                title: Text(
                  "Push Notification",
                  style: TextStyle(fontSize: 25),
                ),
                trailing: Switch(
                  value: pushnotify,
                  activeColor: mainColor,
                  onChanged: (value) async {
                    print("hello");
                    setState(() {
                      pushnotify = value;
                    });
                    await storage.write(
                      key: 'pushnotify',
                      value: "${pushnotify.toString()}",
                    );
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
                  value: emailnotify,
                  activeColor: mainColor,
                  onChanged: (value) async {
                    if (value == true) {}
                    setState(() {
                      emailnotify = value;
                    });
                    await storage.write(
                      key: 'emailnotify',
                      value: "${emailnotify.toString()}",
                    );
                  },
                ),
              ),
              Divider(thickness: 1),
            ],
          ),
        ),
      ),
      onPopInvokedWithResult: (b, t) async {
        Navigator.popAndPushNamed(context, "/settings");
      },
    );
  }
}
