import 'package:flutter/material.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
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
          title: Text("Choose Theme"),
          backgroundColor: mainColor,
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              ListTile(
                onTap: () async {
                  await storage.write(key: 'theme', value: 'default');
                  setState(() {
                    theme = "default";
                    mainColor = Color.fromRGBO(82, 101, 140, 1);
                  });
                },
                title: Text("Default", style: TextStyle(fontSize: 25)),
                leading: Icon(
                  Icons.square,
                  size: 25,
                  color: Color.fromRGBO(82, 101, 140, 1),
                ),
                trailing:
                    theme == "default"
                        ? Icon(Icons.check_circle, color: mainColor)
                        : SizedBox(),
              ),
              Divider(thickness: 1),
              ListTile(
                onTap: () async {
                  await storage.write(key: 'theme', value: 'orange');
                  setState(() {
                    theme = "orange";
                    mainColor = Colors.orange[800];
                  });
                },
                title: Text("Orange", style: TextStyle(fontSize: 25)),
                leading: Icon(
                  Icons.square,
                  size: 25,
                  color: Colors.orange[800],
                ),
                trailing:
                    theme == "orange"
                        ? Icon(Icons.check_circle, color: mainColor)
                        : SizedBox(),
              ),
              Divider(thickness: 1),
              ListTile(
                onTap: () async {
                  await storage.write(key: 'theme', value: 'blue');
                  setState(() {
                    theme = "blue";
                    mainColor = Colors.blue[800];
                  });
                },
                title: Text("Blue", style: TextStyle(fontSize: 25)),
                leading: Icon(Icons.square, size: 25, color: Colors.blue[800]),
                trailing:
                    theme == "blue"
                        ? Icon(Icons.check_circle, color: mainColor)
                        : SizedBox(),
              ),
              Divider(thickness: 1),
              ListTile(
                onTap: () async {
                  await storage.write(key: 'theme', value: 'brown');
                  setState(() {
                    theme = "brown";
                    mainColor = Color.fromARGB(255, 98, 12, 0);
                  });
                },
                title: Text("Brown", style: TextStyle(fontSize: 25)),
                leading: Icon(
                  Icons.square,
                  size: 25,
                  color: Color.fromARGB(255, 98, 12, 0),
                ),
                trailing:
                    theme == "brown"
                        ? Icon(Icons.check_circle, color: mainColor)
                        : SizedBox(),
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
