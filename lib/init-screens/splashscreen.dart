// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/auth/auth_cubit.dart';
import 'package:itdata/data/cubits/auth/auth_state.dart';
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
import 'package:itdata/data/cubits/theme/theme_state.dart';
import 'package:itdata/data/cubits/transaction/transaction_cubit.dart';
import 'package:itdata/data/cubits/user-data/user_data_cubit.dart';
import 'package:itdata/features/auth/login.dart';
import 'package:itdata/features/dashboard/dashboard.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void requestPermissions() async {
    try {
      await Permission.storage.request();
    } catch (e) {
      //print(e.toString());
    }
  }

  void status(var title, var status) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(title: Text(title), content: Text(status)),
    );
  }

  @override
  void initState() {
    super.initState();
    requestPermissions();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final sCubit = BlocProvider.of<StorageCubit>(context);
      sCubit.load_storage();
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginCubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      body: BlocBuilder<ThemeCubit, ThemeState>(builder: (context, theme)=>Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MultiBlocListener(
          listeners: [
            BlocListener<StorageCubit, Map<String, dynamic>>(
              listener: (context, state) {
                //print(state);
                if (state["remember_me"] == true) {
                  loginCubit.login(state["username"], state["password"]);
                } else {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                }
              },
            ),
            BlocListener<AuthCubit, AuthState>(
              listener: (context, state)  {
                if (state is LoginSucess) {
                  ////print("LOGIN SUCCESS: ${state}");
                  
                  final id = state.userInfo?.id;
                  //print("AM LOGGED IN");
                  Navigator.pop(context);
                  //print("<============ USER DATA ===============>");
                  //print(state.userInfo);
                  //print("<============ USER DATA ===============>");
                  //print(state.userInfo!.email);
                  
                  context.read<UserDataCubit>().reset();
                  //context.read<ThemeCubit>().reset();
                  context.read<TransactionCubit>().reset();
                  context.read<NotificationListCubit>().reset();
                  context.read<SetpinButtonsCubit>().reset();
                  context.read<DataCubit>().reset();
                  context.read<AirtimeCubit>().reset();
                  context.read<EduCubit>().reset();
                  context.read<CableCubit>().reset();
                  context.read<ElectricityCubit>().reset();
                  context.read<NetworkProvidersCubit>().reset();
                  context.read<UserDataCubit>().setUser(
                    state.userInfo!,
                  );
                  context.read<NotificationListCubit>().setUserId(id!);
                  context.read<TransactionCubit>().setUserId(id);
                  context.read<NetworkProvidersCubit>().loadNetworkProviders();
                  context.read<AirtimeCubit>().loadAirtimeTypes();
                  context.read<DataCubit>().loadDataPlans();
                  context.read<CableCubit>().loadCablePlans();
                  context.read<EduCubit>().loadExamTypes();
                  context.read<ElectricityCubit>().loadDiscos();
                  context.read<TransactionCubit>().loadTransactions();
                  //print("<============ PASSED ===============>");
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));
                } else if (state is LoginFailure) {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                  status("Alert", state.message);
                }
              },
            ),
          ],

          child: Center(
            child: Column(
              children: [
                CircularProgressIndicator(
                  color: theme.primaryColor,
                  strokeWidth: 10.0,
                ),
                SizedBox(height: 10),
                Text("Initializing app...", style: TextStyle(fontSize: 20),)
              ],
            ),
          ),
        ),
      ],
    )),
    );
  }
}
