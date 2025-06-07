import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/theme/theme_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_state.dart';

class FundWallet extends StatefulWidget {
  const FundWallet({super.key});

  @override
  State<FundWallet> createState() => _FundWalletState();
}

class _FundWalletState extends State<FundWallet> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, theme) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, "/dashboard");
                },
                icon: Icon(Icons.arrow_back),
              ),
              title: Text("Fund Wallet"),
              backgroundColor: theme.primaryColor,
            ),
            body: Padding(
              padding: EdgeInsets.all(10),
              child: ListView(
                children: [
                  ListTile(
                    onTap:
                        (() =>
                            Navigator.popAndPushNamed(context, "/bank_fund")),
                    title: Text(
                      "Fund with Bank Transfer",
                      style: TextStyle(fontSize: 25),
                    ),
                    leading: Image.asset("assets/images/bank.png", scale: 10.0),
                  ),
                  Divider(thickness: 1),
                  ListTile(
                    onTap:
                        (() =>
                            Navigator.popAndPushNamed(context, "/card_fund")),
                    title: Text(
                      "Fund with ATM Card",
                      style: TextStyle(fontSize: 25),
                    ),
                    leading: Image.asset("assets/images/card.png", scale: 10.0),
                  ),
                  Divider(thickness: 1),
                ],
              ),
            ),
          );
        },
      ),
      onPopInvokedWithResult: (b, t) async {
        Navigator.popAndPushNamed(context, "/dashboard");
      },
    );
  }
}
