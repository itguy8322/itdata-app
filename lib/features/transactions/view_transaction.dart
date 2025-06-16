// ignore_for_file: deprecated_member_use, no_logic_in_create_state

import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/theme/theme_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_state.dart';
import 'package:itdata/data/cubits/transaction/transaction_cubit.dart';
import 'package:itdata/data/cubits/transaction/transaction_state.dart';
import 'package:itdata/data/models/transaction/transaction.dart';
import 'package:itdata/features/transactions/transactions.dart';
import 'package:share_plus/share_plus.dart';

class ViewTransactionPage extends StatefulWidget {
  final Transaction? transaction;
  const ViewTransactionPage({super.key, required this.transaction});

  @override
  State<ViewTransactionPage> createState() => _ViewTransactionPageState();
}

class _ViewTransactionPageState extends State<ViewTransactionPage> {
  final screen = GlobalKey();
  share_receipt() async {
    final boundary =
        screen.currentContext?.findRenderObject() as RenderRepaintBoundary;
    var image = await boundary.toImage(pixelRatio: ui.window.devicePixelRatio);
    var byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    var pngBytes = byteData!.buffer.asUint8List();
    var filePath = "/storage/emulated/0/Download/DataApp_Receipt.png";
    File(filePath).writeAsBytesSync(pngBytes);
    Share.shareXFiles([XFile(filePath)]);
  }

  downloadReceipt() async {
    try {
      final boundary =
          screen.currentContext?.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(
        pixelRatio: ui.window.devicePixelRatio,
      );
      var byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData!.buffer.asUint8List();
      File(
        "/storage/emulated/0/Download/DataApp_Receipt.png",
      ).writeAsBytesSync(pngBytes);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(content: Text("Receipt Downloaded!"));
        },
      );
    } catch (e) {
      print(e.toString());
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(content: Text("Error downloading Receipt!"));
        },
      );
    }
  }

  Widget data(Transaction transaction) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Provider"),
            Text(transaction.provider!.toUpperCase()),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Data Plan"), Text(transaction.plan!)],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Type"), Text(transaction.type!.toUpperCase())],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Amount"),
            Text("₦${transaction.amount!.toString()}"),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Recepiant"), Text(transaction.tel!)],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Balance"), Text("₦${transaction.tel.toString()}")],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Transaction Reference"), Text(transaction.id!)],
        ),
      ],
    );
  }

  Widget airtime(Transaction transaction) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("provider"),
            Text(transaction.provider!.toUpperCase()),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Amount"), Text("₦${transaction.amount.toString()}")],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Recepiant"), Text(transaction.tel!)],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Balance"), Text("₦balance.toString()}")],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Transaction Reference"), Text(transaction.id!)],
        ),
      ],
    );
  }

  Widget wallet_funding(Transaction transaction) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Amount"), Text("₦${transaction.amount.toString()}")],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Balance"), Text("₦Balance.toString()}")],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Transaction Reference"), Text(transaction.id!)],
        ),
      ],
    );
  }

  Widget electric(Transaction transaction) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Disco Provider"),
            Text(transaction.provider!.toUpperCase()),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Amount"), Text("₦${transaction.amount.toString()}")],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Recepiant"), Text(transaction.tel!)],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Units"), Text(transaction.units.toString())],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("PIN"), Text(transaction.pin!)],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Balance"), Text("₦balance")],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Transaction Reference"), Text(transaction.id!)],
        ),
      ],
    );
  }

  Widget edupin(Transaction transaction) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Exam Type"), Text("transaction")],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Amount"), Text("₦${transaction.amount.toString()}")],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("PIN"), Text(transaction.pin!)],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Recepiant"), Text(transaction.tel!)],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Balance"), Text("₦balance")],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Transaction Reference"), Text(transaction.id!)],
        ),
      ],
    );
  }

  Widget cable(Transaction transaction) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Provider"),
            Text(transaction.provider!.toUpperCase()),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Plan"), Text(transaction.plan!)],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Amount"), Text("₦${transaction.amount.toString()}")],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Recepiant"), Text(transaction.tel!)],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Balance"), Text("₦balance")],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Transaction Reference"), Text(transaction.id!)],
        ),
      ],
    );
  }

  Widget _content(Transaction transaction) {
    var service = transaction.service!.toUpperCase();
    if (service == "DATA PURCHASE") {
      return data(transaction);
    } else if (service == "AIRTIME PURCHASE") {
      return airtime(transaction);
    } else if (service == "EDU PIN PURCHASE") {
      return edupin(transaction);
    } else if (service == "ELECTRIC PURCHASE") {
      return electric(transaction);
    } else if (service == "WALLET FUNDING") {
      return wallet_funding(transaction);
    } else {
      return cable(transaction);
    }
  }

  @override
  Widget build(BuildContext context) {
    final transaction = widget.transaction!;
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, theme) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TransactionsPage()));
              },
              icon: Icon(Icons.arrow_back, color: theme.secondaryColor),
            ),
            title: Text("Transation", style: TextStyle(color: theme.secondaryColor),),
            backgroundColor: theme.primaryColor,
          ),
          body: Padding(
            padding: EdgeInsets.all(10),
            child: BlocBuilder<TransactionCubit, TransactionStates>(
              builder: (context, state) {
                return ListView(
                  children: [
                    RepaintBoundary(
                      key: screen,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        color: theme.secondaryColor,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  "assets/images/data_app_logo.png",
                                  scale: 40.0,
                                ),
                                Text("Transaction Receipt"),
                              ],
                            ),
                            SizedBox(height: 5),
                            Column(
                              children: [
                                Text(
                                  transaction.service.toString().toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: theme.primaryColor,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  transaction.status!.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 15,
                                    color:
                                        transaction.status == "success"
                                            ? Colors.green
                                            : transaction.status == "pending"
                                            ? Colors.orange
                                            : Colors.red,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(transaction.date!),
                                Divider(
                                  thickness: 1.0,
                                  color: theme.primaryColor,
                                ),
                              ],
                            ),
                            _content(transaction),
                            Divider(
                              thickness: 1.0,
                              color: theme.primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.primaryColor,
                          ),
                          onPressed: () {
                            share_receipt();
                          },
                          icon: Icon(Icons.share, color: theme.secondaryColor,),
                          label: Text("Share Receipt", style: TextStyle(color: theme.secondaryColor)),
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.primaryColor,
                          ),
                          onPressed: () {
                            downloadReceipt();
                          },
                          icon: Icon(Icons.download, color: theme.secondaryColor,),
                          label: Text("Download Receipt", style: TextStyle(color: theme.secondaryColor)),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        );
      }
    );
  }
}
