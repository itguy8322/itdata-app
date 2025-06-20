import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/theme/theme_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_state.dart';
import 'package:itdata/features/wallet-funding/fund_wallet.dart';

class TransferFunding extends StatefulWidget {
  const TransferFunding({super.key});

  @override
  State<TransferFunding> createState() => _TransferFundingState();
}

class _TransferFundingState extends State<TransferFunding> {
  TextEditingController amount = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    // Implement some initialization operations here.
  }

  void status(var title, var status) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(title: Text(title), content: Text(status)),
    );
  }

  void process() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder:
          (context) => AlertDialog(
            title: SizedBox(
              height: 60,
              child: Image.asset("assets/images/loading.gif", scale: 1.0),
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Getting virtual accounts, please wait...")],
            ),
          ),
    );
  }

  void get_virtual_accounts() async {
    // final url = Uri.parse("$_url/user/create-virtual-account");
    // final headers = {"Content-Type": "application/x-www-form-urlencoded"};
    // final body = {
    //   "account_type": "dynamic",
    //   "username": user_data["username"],
    //   "amount": amount.text,
    // };

    // try {
    //   final response = await http.post(url, headers: headers, body: body);
    //   if (response.statusCode == 200) {
    //     //print("It's Working...");
    //     var data = jsonDecode(response.body);
    //     ////print(data);
    //     if (data["status"] == "ok") {
    //       virtual_accounts = data["virtual-accounts"];
    //       transfer_amount = (int.tryParse(amount.text.toString()))!;
    //       setState(() {});
    //       Navigator.pop(context);
    //     } else {
    //       Navigator.pop(context);
    //       status("Alert", data["status"]);
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
  final virtual_accounts = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, theme) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FundWallet()));
              },
              icon: Icon(Icons.arrow_back, color: theme.secondaryColor,),
            ),
            backgroundColor: theme.primaryColor,
            title: Text("Transfer Funding", style: TextStyle(color: theme.secondaryColor),),
          ),
          body: RefreshIndicator(
            child: ListView(
              children: [
                'bvn' == "" || virtual_accounts.isEmpty
                    ? Padding(
                      padding: EdgeInsets.all(10),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(height: 5),
                            Center(
                              child: Text(
                                textAlign: TextAlign.center,
                                "Get tired of enter transfer amount\n each time you want to get dynamic account? Provide your BVN in the account settings to get your static account number.",
                              ),
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              controller: amount,
                              keyboardType: TextInputType.phone,
                              maxLength: 11,
                              decoration: InputDecoration(
                                labelText: 'Transfer Amount',
                                labelStyle: TextStyle(color: Colors.grey),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: theme.primaryColor,
                                  ),
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
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                              horizontal: 50,
                              vertical: 15,
                            ),
                                backgroundColor: theme.primaryColor,
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  process();
                                  get_virtual_accounts();
                                }
                              },
                              child: Text(
                                "Get Virtual Accounts",
                                style: TextStyle(fontSize: 18, color: theme.secondaryColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    : SizedBox(),
                for (var account in virtual_accounts)
                  (Card(
                    color: theme.primaryColor,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${account['bank_name']}",
                            style: TextStyle(
                              color: theme.textColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "${account['account_name']}",
                            style: TextStyle(
                              color: theme.textColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          "transfer_amount" == "0"
                              ? SizedBox()
                              : Text(
                                "Transfer Amount: 0000",
                                style: TextStyle(
                                  color: theme.textColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${account['account_number']}",
                                style: TextStyle(
                                  color: theme.textColor,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Clipboard.setData(
                                    ClipboardData(
                                      text: "${account['account_number']}",
                                    ),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Text Copied")),
                                  );
                                },
                                icon: Icon(
                                  Icons.copy,
                                  color: theme.textColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
              ],
            ),
            onRefresh: () async {
              // final url = Uri.parse("$_url/user/refresh/vaccounts");
              // final headers = {
              //   "Content-Type": "application/x-www-form-urlencoded",
              // };
              // final body = {"username": user_data["username"]};
              // try {
              //   final response = await http.post(
              //     url,
              //     headers: headers,
              //     body: body,
              //   );
              //   if (response.statusCode == 200) {
              //     //print("It's Working...");
              //     var data = jsonDecode(response.body);
              //     //print(data);
              //     if (data["status"] == "ok") {
              //       var _data = data["data"];
              //       user_data = _data["user_data"];
              //       if (user_data["bvn"] != "") {
              //         virtual_accounts = _data["vaccounts"];
              //       }
              //       //Navigator.pop(context);
              //       //Navigator.popAndPushNamed(context, "/dashboard");
              //       setState(() {});
              //     } else {
              //       //Navigator.pop(context);
              //       status("Alert", data["status"]);
              //     }
              //   } else {
              //     //Navigator.pop(context);
              //     status(
              //       "Connection Error",
              //       "check your internet connection and try again!",
              //     );
              //   }
              // } catch (e) {
              //   //Navigator.pop(context);
              //   status(
              //     "Unexpected Error",
              //     "Could ne not connect, check your internet connection and try again! ${e.toString()}",
              //   );
              // }
            },
          ),
        );
      },
    );
  }
}
