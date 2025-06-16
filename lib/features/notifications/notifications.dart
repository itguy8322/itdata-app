// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/notification/notification_list_cubit.dart';
import 'package:itdata/data/cubits/notification/notification_list_state.dart';
import 'package:itdata/data/cubits/theme/theme_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_state.dart';
import 'package:itdata/features/dashboard/dashboard.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  void status(var title, var status) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(title: Text(title), content: Text(status)),
    );
  }
  @override
  void initState(){
    super.initState();
    context.read<NotificationListCubit>().loadNotifications();
  }

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
            title: Text('Notification', style: TextStyle(color: theme.secondaryColor),),
            backgroundColor: theme.primaryColor,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<NotificationListCubit, NotificationsListState>(
              builder: (context, state) {
                final notifications = state.notifications!;
                if (state.loadingInProgress){
                  return Center(child: CircularProgressIndicator(color: theme.primaryColor,),);
                }
                else if (state.loadingSuccess){
                  return notifications.isEmpty
                    ? Center(child: Text("No Notifications yet!", style: TextStyle(color: theme.textColor),))
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
                                  Text("${notification.title}"),
                                  Text("${notification.date.toString()}"),
                                ],
                              ),
                              subtitle: Text("${notification.content}"),
                            ),
                          );
                        },
                      ),
                      onRefresh: () async {
                        context.read<NotificationListCubit>().loadNotifications();
                      },
                    );
                }
                else{
                  return Center(child: Text("Error laoding notifications!", style: TextStyle(color: theme.textColor),));
                }
                
              },
            ),
          ),
        );
      },
    );
  }
}
