// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/theme/theme_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_state.dart';
import 'package:itdata/data/cubits/transaction/transaction_cubit.dart';
import 'package:itdata/data/cubits/user-data/user_data_cubit.dart';
import 'package:itdata/features/dashboard/recent-transaction.dart';
import 'package:itdata/features/dashboard/services-widgets.dart';
import 'package:itdata/features/dashboard/appdrawer.dart';
import 'package:itdata/services/auth.dart';
import 'package:itdata/data/cubits/transaction/transac_states.dart';
import 'package:itdata/data/cubits/user-data/user_state.dart';

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
  bool show_balance = false;

  @override
  void initState() {
    super.initState();
    // Implement some initialization operations here.
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   //final user_d = BlocProvider.of<UserDataCubit>(context);
    //   //final transac = BlocProvider.of<TransactionCubit>(context);

    //   //user_d.load_user_data(user?.email);
    //   //transac.load_transactions(user?.email, "transactions");
    // });
  }

  void status(var _title, var status) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(title: Text(_title), content: Text(status)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user_data_cubit = BlocProvider.of<UserDataCubit>(context);
    return PopScope(
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, theme) {
          return Scaffold(
            drawer: AppDrawer(),
            appBar: AppBar(
              title: BlocBuilder<UserDataCubit, UserState>(
                builder: (context, state) {
                  if (state.userDataSuccess) {
                    return Text("IT Data (${state.userData!.id})");
                  } else {
                    return Text("IT Data ()");
                  }
                },
              ),
              backgroundColor: theme.backgroundColor,
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
              color: theme.primaryColor,
              child: ListView(
                children: [
                  BlocListener<UserDataCubit, UserState>(
                    listener: (context, state) {
                      print("LOADING DATA");
                      context.read<UserDataCubit>().load_user_data(
                        state.userData!.id,
                      );
                    },
                  ),
                  Column(
                    children: [
                      Container(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: theme.primaryColor,
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
                                          style: TextStyle(
                                            color: theme.textColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        BlocBuilder<UserDataCubit, UserState>(
                                          builder: (context, state) {
                                            return Text(
                                              show_balance == true
                                                  ? state.userDataSuccess
                                                      ? "₦${state.userData!.wallet_bal}"
                                                      : "0.00"
                                                  : "****",
                                              style: TextStyle(
                                                color: theme.textColor,
                                                fontSize: 26,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            );
                                          },
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
                                            color: theme.textColor,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      padding: EdgeInsets.all(10),
                                      side: BorderSide(
                                        color: Colors.white,
                                        width: 3,
                                      ),
                                      backgroundColor: theme.primaryColor,
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
                                      backgroundColor: theme.primaryColor,
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
                      ServicesWidgets(),
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
                        child: BlocBuilder<TransactionCubit, TransacStates>(
                          builder: (context, state) {
                            return state is TransacLoaded
                                ? state.transactions.isEmpty
                                    ? RecentTransactions(transactions: [])
                                    : Center(
                                      child: Text("No recent transactions"),
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
                final transac = BlocProvider.of<TransactionCubit>(context);
                transac.load_transactions(user?.email, "transactions");
              },
            ),
          );
        },
      ),

      onPopInvokedWithResult: (b, t) async {},
    );
  }
}
