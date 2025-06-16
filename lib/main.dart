// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, use_key_in_widget_constructors, avoid_print, non_constant_identifier_names, use_build_context_synchronously, unused_local_variable, no_leading_underscores_for_local_identifiers, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, prefer_typing_uninitialized_variables, library_prefixes, unnecessary_null_comparison, unused_field, prefer_final_fields, avoid_unnecessary_containers, unused_element, library_private_types_in_public_api

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/auth/auth_cubit.dart';
import 'package:itdata/data/cubits/input-validations/input_validation_cubit.dart';
import 'package:itdata/data/cubits/network-providers/network_providers_cubit.dart';
import 'package:itdata/data/cubits/notification/notification_list_cubit.dart';
import 'package:itdata/data/cubits/services/airtime/airtime_cubit.dart';
import 'package:itdata/data/cubits/services/cable/cable_cubit.dart';
import 'package:itdata/data/cubits/services/data/data_cubit.dart';
import 'package:itdata/data/cubits/services/edu/edu_cubit.dart';
import 'package:itdata/data/cubits/services/electricity/electricity_cubit.dart';
import 'package:itdata/data/cubits/setpin-buttons/setpin_buttons_cubit.dart';
import 'package:itdata/data/cubits/storage/storage_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_cubit.dart';
import 'package:itdata/data/cubits/transaction/transaction_cubit.dart';
import 'package:itdata/data/cubits/user-data/user_data_cubit.dart';
import 'package:itdata/init-screens/splashscreen.dart';
import 'package:itdata/services/auth.dart';
import 'package:itdata/services/database.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

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
        BlocProvider(create: (_) => InputValidationCubit()),
        BlocProvider(create: (_) => NotificationListCubit()),
        BlocProvider(create: (_) => NetworkProvidersCubit()),
        BlocProvider(create: (_) => SetpinButtonsCubit()),
        BlocProvider(create: (_) => AirtimeCubit()),
        BlocProvider(create: (_) => DataCubit()),
        BlocProvider(create: (_) => CableCubit()),
        BlocProvider(create: (_) => EduCubit()),
        BlocProvider(create: (_) => ElectricityCubit()),
        
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
      home: SplashScreen(),
    );
  }
}
