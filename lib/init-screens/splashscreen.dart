import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/auth/auth_cubit.dart';
import 'package:itdata/data/cubits/auth/auth_state.dart';
import 'package:itdata/data/cubits/storage/storage_cubit.dart';
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
      print(e.toString());
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                }
              },
            ),
            BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is LoginSucess) {
                  //print("LOGIN SUCCESS: ${state}");
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
              children: [Image.asset("assets/images/loading.gif", scale: 10.0)],
            ),
          ),
        ),
      ],
    );
  }
}
