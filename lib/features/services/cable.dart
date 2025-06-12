import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/core/setpin-buttons/setpin_buttons.dart';
import 'package:itdata/data/cubits/theme/theme_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_state.dart';
import 'package:itdata/features/dashboard/dashboard.dart';

class Cable extends StatefulWidget {
  const Cable({super.key});

  @override
  State<Cable> createState() => _CableState();
}

class _CableState extends State<Cable> {
  TextEditingController number = TextEditingController();
  TextEditingController iuc_number = TextEditingController();
  TextEditingController amount = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  var cable = "none";
  var cable_plan = {};
  bool check_iuc = false;
  var iuc_data = "";

  void validateMeterNumber() async {
    // print("am here");
    // int iuc = (int.tryParse(iuc_number.text))!;
    // final url = Uri.parse(
    //   "https://postranet.com/api/validateiuc?smart_card_number=$iuc&cablename=${cable.toUpperCase()}",
    // );
    // final headers = {"Content-Type": "application/json"};
    // try {
    //   print("am here1");
    //   final response = await http.get(url, headers: headers);
    //   print("am here2");
    //   if (response.statusCode == 200) {
    //     print("It's Working...");
    //     var data = jsonDecode(response.body);

    //     print("am here3");
    //     check_iuc = false;
    //     iuc_data = data["name"].toString();
    //     setState(() {});
    //   } else {
    //     print("am here5");
    //     check_iuc = false;
    //     iuc_data = "Could not fetch data, try again.";
    //     setState(() {});
    //   }
    // } catch (e) {
    //   print("am here6");
    //   check_iuc = false;
    //   iuc_data = "Could not fetch data, try again.";
    //   setState(() {});
    // }
  }

  final cable_plans = {};
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, theme) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));
              },
              icon: Icon(Icons.arrow_back, color: theme.secondaryColor,),
            ),
            backgroundColor: theme.primaryColor,
            title: Text("Cable", style: TextStyle(color: theme.secondaryColor),),
          ),
          body: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: theme.primaryColor),
                      ),
                      border: OutlineInputBorder(),
                    ),
                    hint: Text(
                      cable == "none" ? "Choose Cable" : "",
                      style: TextStyle(color: theme.primaryColor),
                    ),
                    items: [
                      for (var cable in ["cable_types"])
                        (DropdownMenuItem(value: cable, child: Text(cable))),
                    ],
                    validator: (value) {
                      if (value == null) {
                        return 'All field required';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        cable = value.toString();
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: number,
                    keyboardType: TextInputType.phone,
                    maxLength: 11,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      labelStyle: TextStyle(color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: theme.primaryColor),
                      ),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'All field required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  check_iuc
                      ? Row(
                        children: [
                          Image.asset(
                            "assets/images/loading.gif",
                            scale: 25.0,
                          ),
                          Text(
                            "Validating...",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                      : iuc_data == "Could not fetch data, try again."
                      ? Text(
                        iuc_data,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                      : iuc_data != ""
                      ? Text(
                        iuc_data.toUpperCase(),
                        style: TextStyle(
                          color:
                              iuc_data == "INVALID IUC NUMBER"
                                  ? Colors.red
                                  : Colors.green,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                      : SizedBox(height: 0.01),
                  TextFormField(
                    controller: iuc_number,
                    keyboardType: TextInputType.phone,
                    maxLength: 11,
                    readOnly: check_iuc,
                    decoration: InputDecoration(
                      labelText: 'IUC Number',
                      labelStyle: TextStyle(color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: theme.primaryColor),
                      ),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'All field required';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      if (value.length == 11) {
                        setState(() {
                          check_iuc = true;
                        });
                        validateMeterNumber();
                      } else {
                        setState(() {
                          iuc_data = "";
                        });
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  cable != "none"
                      ? DropdownButtonFormField(
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: theme.primaryColor),
                          ),
                          border: OutlineInputBorder(),
                        ),
                        hint: Text(
                          "Choose Cable Plan",
                          style: TextStyle(color: theme.primaryColor),
                        ),
                        items: [
                          for (var sub in cable_plans[cable])
                            (DropdownMenuItem(
                              value: sub,
                              child: Text(
                                "${sub['plan'].toString()} ${sub['sale_price'].toString()}",
                              ),
                            )),
                        ],
                        validator: (value) {
                          if (value == null) {
                            return 'All field required';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            cable_plan = jsonDecode(value.toString());
                          });
                        },
                      )
                      : SizedBox(),
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(10),
                      backgroundColor: theme.primaryColor,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showPinButtons(context);
                      }
                    },
                    child: Text("Pay", style: TextStyle(fontSize: 20, color: theme.secondaryColor)),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
