// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, use_key_in_widget_constructors, avoid_print, non_constant_identifier_names, use_build_context_synchronously, unused_local_variable, no_leading_underscores_for_local_identifiers, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, prefer_typing_uninitialized_variables, library_prefixes, unnecessary_null_comparison, unused_field, prefer_final_fields, avoid_unnecessary_containers, unused_element, library_private_types_in_public_api

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/auth/auth_cubit.dart';
import 'package:itdata/data/cubits/storage/storage_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_cubit.dart';
import 'package:itdata/data/cubits/transaction/transaction_cubit.dart';
import 'package:itdata/data/cubits/user-data/user_data_cubit.dart';
import 'package:itdata/features/about/about.dart';
import 'package:itdata/features/dashboard/dashboard.dart';
import 'package:itdata/features/auth/login.dart';
import 'package:itdata/features/auth/signup.dart';
import 'package:itdata/init-screens/splashscreen.dart';
import 'package:itdata/features/about/termspolicies.dart';
import 'package:itdata/features/transactions/transactions.dart';
import 'package:itdata/features/transactions/view_transaction.dart';
import 'package:itdata/services/auth.dart';
import 'package:itdata/services/database.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'features/settings/profile.dart';

void main() async {
  print("Hello world");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.debug,
  );

  AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: 'basic_channel',
      channelName: 'Basic notifications',
      channelDescription: 'Notification channel for basic tests',
    ),
  ], debug: true);

  // if (theme == "default") {
  //   mainColor = Color.fromRGBO(82, 101, 140, 1);
  // } else if (theme == "blue") {
  //   mainColor = Colors.blue[800];
  // } else if (theme == "orange") {
  //   mainColor = Colors.orange[800];
  // } else if (theme == "brown") {
  //   mainColor = Color.fromARGB(255, 98, 12, 0);
  // }

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => StorageCubit()),
        BlocProvider(create: (_) => AuthCubit(Auth(), DatabaseService())),
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => UserDataCubit()),
        BlocProvider(create: (_) => TransactionCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Color.fromRGBO(82, 101, 140, 1)),
      initialRoute: "/",
      routes: {
        "/": (context) => SplashScreen(),

        "/login": (context) => LoginPage(),
        "/signup": (context) => SignupPage(),
        "/dashboard": (context) => Dashboard(),
        "/transactions": (context) => TransactionsPage(),
        "/transaction": (context) => ViewTransactionPage(index: 0),
        "/profile": (context) => ProfilePage(),
        "/termspolicy": (context) => TermsAndPolicyPage(),
        "/about_us": (context) => AboutUsPage(),

        // "/landing": (context) => LandingPage(),
        // "/forgot_password": (context) => ForgotPasswordPage(),
        // "/change_password": (context) => ChangeNewPasswordPage(),
        // "/fundWallet": (context) => FundWalletPage(),
        // "/bank_fund": (context) => TransferFunding(),
        // "/card_fund": (context) => CardFundingPage(),
        // "/data": (context) => BuyDataPage(),
        // "/airtime": (context) => BuyAirtimePage(),
        // "/edupin": (context) => BuyEduPinPage(),
        // "/electricity": (context) => BuyElectricityPage(),
        // "/cable": (context) => BuyCablePage(),
        // "/notification": (context) => NotificationsPage(),
        // "/settings": (context) => Settings(),
        // "/security": (context) => SecurityPage(),
        // "/notisetting": (context) => NotificationPage(),
        // "/theme": (context) => ThemePage(),
        // "/changepin": (context) => ChangePinPage(),
        // "/changepassword": (context) => ChangePasswordPage(),
        // "/bvn_verification": (context) => BVNVerificationPage(),
      },
    );
  }
}
