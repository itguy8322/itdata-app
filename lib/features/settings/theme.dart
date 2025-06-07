import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/theme/theme_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_state.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
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
              title: Text("Choose Theme"),
              backgroundColor: theme.primaryColor,
            ),
            body: Padding(
              padding: EdgeInsets.all(10),
              child: ListView(
                children: [
                  ListTile(
                    onTap: () async {
                      // await storage.write(key: 'theme', value: 'default');
                      // setState(() {
                      //   theme = "default";
                      //   theme.primaryColor = Color.fromRGBO(82, 101, 140, 1);
                      // });
                    },
                    title: Text("Default", style: TextStyle(fontSize: 25)),
                    leading: Icon(
                      Icons.square,
                      size: 25,
                      color: Color.fromRGBO(82, 101, 140, 1),
                    ),
                    trailing:
                        theme == "default"
                            ? Icon(
                              Icons.check_circle,
                              color: theme.primaryColor,
                            )
                            : SizedBox(),
                  ),
                  Divider(thickness: 1),
                  ListTile(
                    onTap: () async {
                      // await storage.write(key: 'theme', value: 'orange');
                      // setState(() {
                      //   theme = "orange";
                      //   theme.primaryColor = Colors.orange[800];
                      // });
                    },
                    title: Text("Orange", style: TextStyle(fontSize: 25)),
                    leading: Icon(
                      Icons.square,
                      size: 25,
                      color: Colors.orange[800],
                    ),
                    trailing:
                        theme == "orange"
                            ? Icon(
                              Icons.check_circle,
                              color: theme.primaryColor,
                            )
                            : SizedBox(),
                  ),
                  Divider(thickness: 1),
                  ListTile(
                    onTap: () async {
                      // await storage.write(key: 'theme', value: 'blue');
                      // setState(() {
                      //   theme = "blue";
                      //   theme.primaryColor = Colors.blue[800];
                      // });
                    },
                    title: Text("Blue", style: TextStyle(fontSize: 25)),
                    leading: Icon(
                      Icons.square,
                      size: 25,
                      color: Colors.blue[800],
                    ),
                    trailing:
                        theme == "blue"
                            ? Icon(
                              Icons.check_circle,
                              color: theme.primaryColor,
                            )
                            : SizedBox(),
                  ),
                  Divider(thickness: 1),
                  ListTile(
                    onTap: () async {
                      // await storage.write(key: 'theme', value: 'brown');
                      // setState(() {
                      //   theme = "brown";
                      //   theme.primaryColor = Color.fromARGB(255, 98, 12, 0);
                      // });
                    },
                    title: Text("Brown", style: TextStyle(fontSize: 25)),
                    leading: Icon(
                      Icons.square,
                      size: 25,
                      color: Color.fromARGB(255, 98, 12, 0),
                    ),
                    trailing:
                        theme == "brown"
                            ? Icon(
                              Icons.check_circle,
                              color: theme.primaryColor,
                            )
                            : SizedBox(),
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
