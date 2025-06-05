import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/auth/auth_cubit.dart';
import 'package:itdata/data/cubits/storage/storage_cubit.dart';
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
      print(e.toString());
    }
  }

  void status(var _title, var status) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(title: Text(_title), content: Text(status)),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MultiBlocListener(
          listeners: [
            BlocListener<StorageCubit, Map<String, dynamic>>(
              listener: (context, state) {
                print(state);
                if (state["remember_me"] == true) {
                  loginCubit.login(state["username"], state["password"]);
                } else {
                  Navigator.popAndPushNamed(context, "/login");
                }
              },
            ),
            BlocListener<AuthCubit, Map<String, dynamic>>(
              listener: (context, state) {
                if (state["status"] == "ok") {
                  //print("LOGIN SUCCESS: ${state}");
                  Navigator.popAndPushNamed(context, "/dashboard");
                } else {
                  Navigator.popAndPushNamed(context, "/login");
                  status("Alert", state["status"]);
                }
              },
            ),
          ],

          child: Center(
            child: Column(
              children: [Image.asset("assets/images/loading.gif", scale: 10.0)],
            ),
          ),
        ),
      ],
    );
  }
}
