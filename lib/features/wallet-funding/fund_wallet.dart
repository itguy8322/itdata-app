import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/theme/theme_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_state.dart';
import 'package:itdata/features/dashboard/dashboard.dart';
import 'package:itdata/features/wallet-funding/card_funding.dart';
import 'package:itdata/features/wallet-funding/transfer_funding.dart';

class FundWallet extends StatefulWidget {
  const FundWallet({super.key});

  @override
  State<FundWallet> createState() => _FundWalletState();
}

class _FundWalletState extends State<FundWallet> {
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
            title: Text("Fund Wallet", style: TextStyle(color: theme.secondaryColor),),
            backgroundColor: theme.primaryColor,
          ),
          body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: [
                ListTile(
                  onTap:
                      (() =>
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>TransferFunding()))),
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
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>CardFunding()))),
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
    );
  }
}
