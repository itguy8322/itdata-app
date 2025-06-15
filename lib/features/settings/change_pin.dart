import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:itdata/core/setpin-buttons/setpin_buttons.dart';
import 'package:itdata/data/cubits/theme/theme_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_state.dart';
import 'package:itdata/features/settings/security.dart';

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

  changePin() async {
    Future.delayed(Duration(seconds: 1),(){
      PinButtonWidget(context: context,title: 'Enter old pin', onEnteredPins: (pin){
      print("Entered Old PIN: $pin");
      Navigator.pop(context);
      PinButtonWidget(context: context, title: 'Enter new pin', onEnteredPins: (pin){
        print("Entered New PIN: $pin");
        Navigator.pop(context);
        PinButtonWidget(context: context, title: 'Confirm pin', onEnteredPins: (pin){
          print("Entered New PIN: $pin");
        
        });
      
      });

    });
    });
    
  }

  @override
  void initState() {
    super.initState();
    changePin();
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, theme) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                setState(() {
                });
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Security()));
              },
              icon: Icon(Icons.arrow_back, color: theme.secondaryColor),
            ),
            title: Text(
              "Change Transaction PIN"//set_pin ? "Set Transaction Pin" : "Change Transaction PIN",
              ,style: TextStyle(color: theme.secondaryColor)
            ),
            backgroundColor: theme.primaryColor,
          ),
          body: Padding(
            padding: EdgeInsets.all(10),
            child: Center(child: TextButton(child: Text("Tap to change PIN", style: TextStyle(color: theme.primaryColor),),onPressed: (){
              changePin();
            },))
          ),
        );
      },
    );
  }
}
