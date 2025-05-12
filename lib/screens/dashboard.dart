// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/cubits/user_data_cubit.dart';
import 'package:itdata/main.dart';
import 'package:itdata/screens/appdrawer.dart';
import 'package:itdata/services/auth.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  void noti_actions() async {
    try {
      AwesomeNotifications().setListeners(
        onActionReceivedMethod: (receivedAction) async {
          // Check if the app context is available
          Navigator.popAndPushNamed(context, "/notification");
        },
      );
    } catch (e) {
      status("Error", e.toString());
    }
  }

  User? user = Auth().currentUser;
  @override
  void initState() {
    super.initState();
    // Implement some initialization operations here.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user_d = BlocProvider.of<UserDataCubit>(context);

      user_d.load_user_data(user?.email);
    });
  }

  void status(var _title, var status) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(title: Text(_title), content: Text(status)),
    );
  }

  List<Widget> recent_tranc(List transactions) {
    List<Widget> wdgt = [];
    for (var item in transactions) {
      wdgt.add(
        Card(
          child: ListTile(
            leading: Icon(
              item["status"] == "success"
                  ? Icons.check_circle
                  : item["status"] == "pending"
                  ? Icons.pending
                  : Icons.warning,
              color:
                  item["status"] == "success"
                      ? Colors.green
                      : item["status"] == "pending"
                      ? Colors.orange
                      : Colors.red,
            ),
            trailing: Text(
              "${item['status']}",
              style: TextStyle(
                color:
                    item["status"] == "success"
                        ? Colors.green
                        : item["status"] == "pending"
                        ? Colors.orange
                        : Colors.red,
              ),
            ),
            title: Text("${item['service']}".toUpperCase()),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                Text("${item['date']}"),
                SizedBox(height: 5),
                Text("To: ${item['tel']}"),
              ],
            ),
          ),
        ),
      );
    }
    return wdgt;
  }

  @override
  Widget build(BuildContext context) {
    final user_data_cubit = BlocProvider.of<UserDataCubit>(context);
    int _calculateCrossAxisCount(BuildContext context) {
      double screenWidth = MediaQuery.of(context).size.width;
      if (screenWidth > 1200) {
        return 4; // Large screens
      } else if (screenWidth > 500) {
        return 3; // Medium screens
      } else {
        return 2; // Small screens
      }
    }

    Widget _buildFeature(IconData icon, String title, String description) {
      return GestureDetector(
        onTap: () {
          print(title);
          if (title == "Data Purchase") {
            Navigator.popAndPushNamed(context, "/data");
          } else if (title == "Airtime") {
            Navigator.popAndPushNamed(context, "/airtime");
          } else if (title == "TV Subscriptions") {
            Navigator.popAndPushNamed(context, "/cable");
          } else if (title == "Education") {
            Navigator.popAndPushNamed(context, "/edupin");
          } else if (title == "Bill Payments") {
            Navigator.popAndPushNamed(context, "/electricity");
          } else {
            status(
              "More",
              "There valued customer, more services will be added soon.",
            );
          }
        },
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 5,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: mainColor),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 5),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
        ),
      );
    }

    return PopScope(
      child: Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: BlocBuilder<UserDataCubit, Map<String, dynamic>>(
            builder:
                (context, user_data) =>
                    Text("IT Data (${user_data['username']})"),
          ),
          backgroundColor: mainColor,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, "/notification");
              },
              icon: Icon(Icons.notifications),
            ),
          ],
          elevation: 0.0,
        ),
        body: RefreshIndicator(
          color: mainColor,
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          height: 120,
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Wallet balance",
                                      style: TextStyle(color: subColor),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    BlocBuilder<
                                      UserDataCubit,
                                      Map<String, dynamic>
                                    >(
                                      builder:
                                          (context, user_data) => Text(
                                            show_balance == true
                                                ? "₦${user_data['wallet_bal']}"
                                                : "****",
                                            style: TextStyle(
                                              color: subColor,
                                              fontSize: 26,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        show_balance =
                                            show_balance == false
                                                ? true
                                                : false;
                                        setState(() {});
                                      },
                                      icon: Icon(
                                        Icons.remove_red_eye,
                                        color: subColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 90,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  padding: EdgeInsets.all(10),
                                  side: BorderSide(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                  backgroundColor: mainColor,
                                ),
                                onPressed: () {
                                  Navigator.popAndPushNamed(
                                    context,
                                    "/fundWallet",
                                  );
                                },
                                icon: Icon(Icons.add),
                                label: Text("Fund Wallet  "),
                              ),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  padding: EdgeInsets.all(10),
                                  side: BorderSide(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                  backgroundColor: mainColor,
                                ),
                                onPressed: () {
                                  Navigator.popAndPushNamed(
                                    context,
                                    "/transactions",
                                  );
                                },
                                icon: Icon(Icons.history),
                                label: Text("Transactions"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Services", style: TextStyle(fontSize: 18)),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: _calculateCrossAxisCount(
                                  context,
                                ),
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20,
                              ),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            final features = [
                              [
                                Icons.wifi,
                                'Data Purchase',
                                'Affordable plans for all networks',
                              ],
                              [
                                Icons.phone_android,
                                'Airtime',
                                'Instant recharge anytime',
                              ],
                              [
                                Icons.tv,
                                'TV Subscriptions',
                                'Support for major TV providers',
                              ],
                              [
                                Icons.receipt,
                                'Bill Payments',
                                'Pay utility bills effortlessly',
                              ],
                              [
                                Icons.school,
                                'Education',
                                'Buy result PIN checker',
                              ],
                              [
                                Icons.more_horiz,
                                'More',
                                'Explore more services',
                              ],
                            ];
                            return _buildFeature(
                              features[index][0] as IconData,
                              features[index][1] as String,
                              features[index][2] as String,
                            );
                          },
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Recent Transactions",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: BlocBuilder<UserDataCubit, Map<String, dynamic>>(
                      builder: (context, user_data) {
                        return user_data.containsKey("transactions")
                            ? Column(
                              children: recent_tranc(user_data["transactions"]),
                            )
                            : Center(child: Text("No recent transactions"));
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          onRefresh: () async {
            user_data_cubit.load_user_data(user?.email);
          },
        ),
      ),

      onPopInvokedWithResult: (b, t) async {},
    );
  }
}
