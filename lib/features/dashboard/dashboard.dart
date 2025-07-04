// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names, use_build_context_synchronously

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/core/dialogs/alert_dialog.dart';
import 'package:itdata/data/cubits/network-providers/network_providers_cubit.dart';
import 'package:itdata/data/cubits/services/airtime/airtime_cubit.dart';
import 'package:itdata/data/cubits/services/cable/cable_cubit.dart';
import 'package:itdata/data/cubits/services/data/data_cubit.dart';
import 'package:itdata/data/cubits/services/edu/edu_cubit.dart';
import 'package:itdata/data/cubits/services/electricity/electricity_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_state.dart';
import 'package:itdata/data/cubits/transaction/transaction_cubit.dart';
import 'package:itdata/data/cubits/user-data/user_data_cubit.dart';
// import 'package:itdata/debug/upload_to_firebase.dart';
import 'package:itdata/features/dashboard/recent-transaction.dart';
import 'package:itdata/features/dashboard/services-widgets.dart';
import 'package:itdata/features/dashboard/appdrawer.dart';
import 'package:itdata/features/notifications/notifications.dart';
import 'package:itdata/features/transactions/transactions.dart';
import 'package:itdata/features/wallet-funding/fund_wallet.dart';
import 'package:itdata/services/auth.dart';
import 'package:itdata/data/cubits/transaction/transaction_state.dart';
import 'package:itdata/data/cubits/user-data/user_state.dart';
import 'package:itdata/services/network_providers_service.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void noti_actions() async {
    try {
      AwesomeNotifications().setListeners(
        onActionReceivedMethod: (receivedAction) async {
          // Check if the app context is available
          Navigator.popAndPushNamed(context, "/notification");
        },
      );
    } catch (e) {
      showAlertDialog(context, "Error", e.toString());
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, theme) {
        return Scaffold(
          key: _scaffoldKey,
          drawer: AppDrawer(),
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
              icon: Icon(Icons.menu, color: theme.secondaryColor),
            ),
            title: BlocBuilder<UserDataCubit, UserState>(
              builder: (context, state) {
                if (state.userData!.id != null) {
                  return Text("IT Data (${state.userData!.id})", style: TextStyle(color: theme.secondaryColor),);
                } else {
                  return Text("IT Data ()", style: TextStyle(color: theme.secondaryColor),);
                }
              },
            ),
            backgroundColor: theme.backgroundColor,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Notifications()));
                },
                icon: Icon(Icons.notifications,color: theme.secondaryColor,),
              ),
            ],
            elevation: 0.0,
          ),
          body: BlocBuilder<UserDataCubit, UserState>(
            builder: (context, user) {
              return RefreshIndicator(
                color: theme.primaryColor,
                child: ListView(
                  children: [
                    // MultiBlocListener(listeners: [
                    //   BlocListener<UserDataCubit, UserState>(
                    //   listener: (context, state) {
                    //     print("LOADING DATA");
                    //     context.read<UserDataCubit>().load_user_data(
                    //       state.userData!.id,
                    //     );
                    //   },
                    // )
                    // ], child: SizedBox()),
                    Column(
                      children: [
                        Stack(
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
                                            color: theme.secondaryColor,
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
                                            String wallet_bal = "";
                                            if (state.userData != null){
                                              if (state.userData!.wallet_bal != null){
                                                wallet_bal = state.userData!.wallet_bal!.toString();
                                              }
                                            }
                                            
                                            return Text(
                                              show_balance == true
                                                  ? state.userDataSuccess
                                                      ? "₦$wallet_bal"
                                                      : "0.00"
                                                  : "****",
                                              style: TextStyle(
                                                color: theme.secondaryColor,
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
                                            color: theme.secondaryColor,
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
                                      padding: EdgeInsets.all(17),
                                      side: BorderSide(
                                        color: theme.secondaryColor,
                                        width: 3,
                                      ),
                                      backgroundColor: theme.primaryColor,
                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FundWallet()));
                                    },
                                    icon: Icon(Icons.add, color: theme.secondaryColor,),
                                    label: Text("Fund Wallet", style: TextStyle(color: theme.secondaryColor),),
                                  ),
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      padding: EdgeInsets.all(17),
                                      side: BorderSide(
                                        color: theme.secondaryColor,
                                        width: 3,
                                      ),
                                      backgroundColor: theme.primaryColor,
                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TransactionsPage()));
                                    },
                                    icon: Icon(Icons.history, color: theme.secondaryColor,),
                                    label: Text("Transactions", style: TextStyle(color: theme.secondaryColor),),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
                          child: BlocBuilder<TransactionCubit, TransactionStates>(
                            builder: (context, state) {
                              final transactions = state.transactions!;
                              return transactions.isEmpty
                                  ? RecentTransactions(transactions: [])
                                  : Center(child: Text("No recent transactions"));
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                onRefresh: () async {
                  // uploadToFirebase();
                  context.read<TransactionCubit>().loadTransactions();
                  final networkProviders = await NetworkProvidersService().loadNetworkProviders();
                  context.read<NetworkProvidersCubit>().setNetworkProviders(networkProviders);
                  context.read<AirtimeCubit>().loadAirtimeTypes();
                  context.read<DataCubit>().loadDataPlans();
                  context.read<CableCubit>().loadCablePlans();
                  context.read<EduCubit>().loadExamTypes();
                  context.read<ElectricityCubit>().loadDiscos();
                  context.read<UserDataCubit>().load_user_data(user.userData?.id);
                },
              );
            }
          ),
        );
      },
    );
  }
}
