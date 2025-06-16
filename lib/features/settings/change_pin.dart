// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/core/dialogs/process_dialog.dart';
// import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:itdata/core/setpin-buttons/setpin_buttons.dart';
import 'package:itdata/data/cubits/theme/theme_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_state.dart';
import 'package:itdata/data/cubits/user-data/user_data_cubit.dart';
import 'package:itdata/data/cubits/user-data/user_state.dart';
import 'package:itdata/features/dashboard/dashboard.dart';
import 'package:itdata/features/settings/security.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

class ChangePin extends StatefulWidget {
  const ChangePin({super.key});

  @override
  State<ChangePin> createState() => _ChangePinState();
}

class _ChangePinState extends State<ChangePin> {

  void setPin() async {
    // final url = Uri.parse("$_url/user/set-pin");
    // final headers = {"Content-Type": "application/x-www-form-urlencoded"};
    // final body = {"username": user_data["username"], "t_pin": new_pin};
    // try {
    //   final response = await http.post(url, headers: headers, body: body);
    //   if (response.statusCode == 200) {
    //     print("It's Working...");
    //     var data = jsonDecode(response.body);
    //     print(data);
    //     if (data["status"] == "ok") {
    //       user_data["t_pin"] = new_pin;
    //       setState(() {
    //         new_pin = "";
    //         conf_pin = "";
    //       });
    //       Navigator.pop(context);
    //       Navigator.popAndPushNamed(context, "/dashboard");
    //     }
    //   } else {
    //     Navigator.pop(context);
    //     status(
    //       "Connection Error",
    //       "check your internet connection and try again!",
    //     );
    //   }
    // } catch (e) {
    //   Navigator.pop(context);
    //   status(
    //     "Unexpected Error",
    //     "Could ne not connect, check your internet connection and try again! ${e.toString()}",
    //   );
    // }
  }

  changePin(bool isNewUser, String oldPin) async {
    Future.delayed(Duration(seconds: 0),(){
      if (isNewUser){
        PinButtonWidget(context: context,title: 'Enter new pin', onEnteredPins: (pin1){
          print("Entered Old PIN: $pin1");
          Navigator.pop(context);
          PinButtonWidget(context: context, title: 'Confirm pin', onEnteredPins: (pin2){
            print("Entered New PIN: $pin2");
            if (pin1 == pin2) {
              // setPin();
              print("PINs match, setting new PIN...");
              // Here you would typically call a function to update the PIN in your database
              // For example: setPin(pin1);
              final userData = context.read<UserDataCubit>().state.userData;
              userData?.pin = pin1;
              Navigator.pop(context);
              context.read<UserDataCubit>().update_data("users", userData?.id ?? "", userData!);
            } else {
              print("PINs do not match, please try again.");
              // You might want to show an error message here
              showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.error(
                  message: "Password don not match, please try again!",
                ),
              );
              Navigator.pop(context);
              changePin(isNewUser, oldPin);
            }
            
          
          });

        });
      }else{
        PinButtonWidget(context: context,title: 'Enter old pin', onEnteredPins: (pin0){
          if (kDebugMode) {
            print("Entered Old PIN: $pin0");
          }
          if (pin0 != oldPin) {
            
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.error(
                message: "Password don not match, please try again!",
              ),
            );
            print("Old PIN does not match, please try again.");
            // You might want to show an error message here
            Navigator.pop(context);
            changePin(isNewUser, oldPin);
            return;
          }
          Navigator.pop(context);
          PinButtonWidget(context: context, title: 'Enter new pin', onEnteredPins: (pin1){
            print("Entered New PIN: $pin1");
            Navigator.pop(context);
            PinButtonWidget(context: context, title: 'Confirm pin', onEnteredPins: (pin2){
              print("Entered New PIN: $pin2");
              if (pin1 == pin2) {
                // setPin();
                print("PINs match, setting new PIN...");
                // Here you would typically call a function to update the PIN in your database
                // For example: setPin(pin1);
                final userData = context.read<UserDataCubit>().state.userData;
                userData?.pin = pin1;
                Navigator.pop(context);
                context.read<UserDataCubit>().update_data("users", userData?.id ?? "", userData!);
              } else {
                print("PINs do not match, please try again.");
                // You might want to show an error message here
                showTopSnackBar(
                  Overlay.of(context),
                  CustomSnackBar.error(
                    message: "Password don not match, please try again!",
                  ),
                );
                Navigator.pop(context);
                changePin(isNewUser, oldPin);
              }
            
            });
          
          });

        });
      }
      
    });
    
  }

  @override
  void initState() {
    super.initState();
    final user = context.read<UserDataCubit>().state;
    changePin(user.isNewUser, user.userData?.pin ?? "");
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, theme) {
        return BlocBuilder<UserDataCubit, UserState>(
          builder: (context, user) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    setState(() {
                    });
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Security()));
                  },
                  icon: Icon(Icons.arrow_back, color: theme.secondaryColor),
                ),
                title: Text(
                  user.isNewUser ? "Set Transaction Pin" : "Change Transaction PIN",
                  style: TextStyle(color: theme.secondaryColor)
                ),
                backgroundColor: theme.primaryColor,
              ),
              body: MultiBlocListener(listeners: [
                BlocListener<UserDataCubit, UserState>(
                listener: (context, _user) {
                  if (_user.userDataSuccess) {
                    print("[PIN IS CHANGED SUCCESSFULLY]");
                    Navigator.pop(context);
                    showTopSnackBar(
                      Overlay.of(context),
                      snackBarPosition: SnackBarPosition.bottom,
                      CustomSnackBar.success(
                        message: "PIN changed successfully!",
                      ),
                    );
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Dashboard()));
                  }else if (_user.userDataFailure) {
                    Navigator.pop(context);
                    showTopSnackBar(
                      Overlay.of(context),
                      snackBarPosition: SnackBarPosition.bottom,
                      CustomSnackBar.error(
                        message: "Failed to change PIN. Please try again.",
                      ),
                    );
                  }else if (_user.uesrDataInProgress) {
                    if (_user.isNewUser){
                      showProcessDialog(context, label: "Setting new PIN...");
                    }
                    else{
                      showProcessDialog(context, label: "Changing PIN...");}
                  }
                },
              )
              ], child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(child: TextButton(child: Text("Tap to change PIN", style: TextStyle(color: theme.primaryColor),),onPressed: (){
                      changePin(user.isNewUser, user.userData?.pin ?? "");
                    },))
                  )),
            );
          }
        );
      },
    );
  }
}
