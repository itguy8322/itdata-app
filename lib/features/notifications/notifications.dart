import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/theme/theme_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_state.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  void status(var _title, var status) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(title: Text(_title), content: Text(status)),
    );
  }

  final notifications = [];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, theme) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, "/dashboard");
                },
                icon: Icon(Icons.arrow_back),
              ),
              title: Text('Notification'),
              backgroundColor: theme.primaryColor,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child:
                  notifications.isEmpty
                      ? Center(child: Text("No Notifications yet!"))
                      : RefreshIndicator(
                        color: theme.primaryColor,
                        child: ListView.builder(
                          itemCount: notifications.length,
                          itemBuilder: (context, index) {
                            final notification = notifications[index];
                            return Card(
                              elevation: 3,
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text("${notification['title']}"),
                                    Text("${notification['date'].toString()}"),
                                  ],
                                ),
                                subtitle: Text("${notification['content']}"),
                              ),
                            );
                          },
                        ),
                        onRefresh: () async {
                          // final url = Uri.parse(
                          //   "$_url/user/refresh/notifications",
                          // );
                          // final headers = {
                          //   "Content-Type": "application/x-www-form-urlencoded",
                          // };
                          // final body = {"username": user_data["username"]};
                          // try {
                          //   final response = await http.post(
                          //     url,
                          //     headers: headers,
                          //     body: body,
                          //   );
                          //   if (response.statusCode == 200) {
                          //     print("It's Working...");
                          //     var data = jsonDecode(response.body);
                          //     print(data);
                          //     if (data["status"] == "ok") {
                          //       var _data = data["data"];

                          //       if (_data["notifications"].isNotEmpty) {
                          //         notifications = _data["notifications"];
                          //         setState(() {});
                          //       }

                          //       //Navigator.pop(context);
                          //       //Navigator.popAndPushNamed(context, "/dashboard");
                          //     } else {
                          //       //Navigator.pop(context);
                          //       status("Alert", data["status"]);
                          //     }
                          //   } else {
                          //     //Navigator.pop(context);
                          //     status(
                          //       "Connection Error",
                          //       "check your internet connection and try again!",
                          //     );
                          //   }
                          // } catch (e) {
                          //   //Navigator.pop(context);
                          //   status(
                          //     "Unexpected Error",
                          //     "Could ne not connect, check your internet connection and try again! ${e.toString()}",
                          //   );
                          // }
                        },
                      ),
            ),
          );
        },
      ),
      onPopInvokedWithResult: (b, t) async {
        Navigator.popAndPushNamed(context, "/dashboard");
      },
    );
  }
}
