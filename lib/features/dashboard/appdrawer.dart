// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/theme/theme_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_state.dart';
import 'package:itdata/data/cubits/user-data/user_data_cubit.dart';
import 'package:itdata/data/cubits/user-data/user_state.dart';
import 'package:itdata/features/about/about.dart';
import 'package:itdata/features/about/termspolicies.dart';
import 'package:itdata/features/auth/login.dart';
import 'package:itdata/features/notifications/notifications.dart';
import 'package:itdata/features/settings/profile.dart';
import 'package:itdata/features/settings/settings.dart';
import 'package:itdata/features/transactions/transactions.dart';
import 'package:itdata/features/wallet-funding/fund_wallet.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder:
          (context, theme) => Drawer(
            child: Column(
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(color: theme.backgroundColor),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BlocBuilder<UserDataCubit, UserState>(
                            builder:
                                (context, state) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 80,
                                      child: Image.asset(
                                        "assets/images/profile.png",
                                      ),
                                    ),
                                    Text(
                                      "${state.userData != null ? state.userData!.name : ''}".toUpperCase(),
                                      style: TextStyle(
                                        color: theme.secondaryColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "${state.userData != null ? state.userData!.email : ''}",
                                      style: TextStyle(color: theme.secondaryColor),
                                    ),
                                  ],
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: ListView(
                    children: [
                      ListTile(
                        leading: Icon(Icons.wallet, size: 35),
                        title: Text(
                          'Fund Wallet',
                          style: TextStyle(fontSize: 20),
                        ),
                        onTap: () {
                          // Navigate to Dashboard
                          Navigator.pop(context);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FundWallet()));
                          // Close drawer
                        },
                      ),
                      Divider(thickness: 1),
                      SizedBox(height: 5),
                      ListTile(
                        leading: Icon(Icons.history, size: 35),
                        title: Text(
                          'Transactions',
                          style: TextStyle(fontSize: 20),
                        ),
                        onTap: () {
                          // Navigate to Pay Bills
                          Navigator.pop(context); // Close drawer
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TransactionsPage()));
                        },
                      ),
                      Divider(thickness: 1),
                      SizedBox(height: 5),
                      ListTile(
                        leading: Icon(Icons.notifications, size: 35),
                        title: Text(
                          'Notifications',
                          style: TextStyle(fontSize: 20),
                        ),
                        onTap: () {
                          // Navigate to Pay Bills
                          Navigator.pop(context); // Close drawer
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Notifications()));
                        },
                      ),
                      Divider(thickness: 1),
                      SizedBox(height: 5),
                      ListTile(
                        leading: Icon(Icons.person, size: 35),
                        title: Text('Profile', style: TextStyle(fontSize: 20)),
                        onTap: () {
                          // Navigate to Usage History
                          Navigator.pop(context);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ProfilePage())); // Close drawer
                        },
                      ),
                      Divider(thickness: 1),
                      SizedBox(height: 5),
                      ListTile(
                        leading: Icon(Icons.settings, size: 35),
                        title: Text('Settings', style: TextStyle(fontSize: 20)),
                        onTap: () {
                          // Navigate to Account Settings
                          Navigator.pop(context); // Close drawer
                          if (2 == 2) {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Settings()));
                          } else {
                            showDialog(
                              context: context,
                              builder:
                                  (context) => AlertDialog(
                                    content: Text("An unknown error occured!"),
                                  ),
                            );
                          }
                        },
                      ),
                      Divider(thickness: 1),
                      SizedBox(height: 5),
                      ListTile(
                        leading: Icon(Icons.receipt, size: 35),
                        title: Text(
                          'Terms & Policy',
                          style: TextStyle(fontSize: 20),
                        ),
                        onTap: () {
                          // Navigate to View Bills
                          Navigator.pop(context);

                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TermsAndPolicyPage()));
                        },
                      ),
                      Divider(thickness: 1),
                      SizedBox(height: 5),
                      ListTile(
                        leading: Icon(Icons.info, size: 35),
                        title: Text('About Us', style: TextStyle(fontSize: 20)),
                        onTap: () {
                          // Navigate to Usage History
                          Navigator.pop(context); // Close drawer
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AboutUsPage()));
                        },
                      ),
                      Divider(thickness: 1),
                      SizedBox(height: 5),
                      ListTile(
                        leading: Icon(Icons.logout, size: 35),
                        title: Text('Logout', style: TextStyle(fontSize: 20)),
                        onTap: () {
                          // Add logout functionality
                          Navigator.pop(context); // Close drawer
                          showDialog(
                            context: context,
                            builder:
                                (context) => AlertDialog(
                                  title: Text("Confirm"),
                                  content: Text(
                                    "Are you sure you want to logout?",
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        // context.read<AuthCubit>().logout();
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            theme.elevatedBackgroundColor,
                                      ),
                                      child: Text("Yes", style: TextStyle(color: theme.secondaryColor)),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      
                                      child: Text("No", style: TextStyle(color: theme.primaryColor)),
                                    ),
                                  ],
                                ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
