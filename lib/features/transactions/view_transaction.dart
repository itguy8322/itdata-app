// ignore_for_file: deprecated_member_use, no_logic_in_create_state

import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/transaction/transaction_cubit.dart';
import 'package:itdata/data/cubits/transaction/transac_states.dart';
import 'package:share_plus/share_plus.dart';

class ViewTransactionPage extends StatefulWidget {
  final int index;
  const ViewTransactionPage({super.key, required this.index});

  @override
  State<ViewTransactionPage> createState() => _ViewTransactionPageState(index);
}

class _ViewTransactionPageState extends State<ViewTransactionPage> {
  final screen = GlobalKey();
  final int index;

  _ViewTransactionPageState(this.index);
  share_receipt() async {
    final boundary =
        screen.currentContext?.findRenderObject() as RenderRepaintBoundary;
    var image = await boundary.toImage(pixelRatio: ui.window.devicePixelRatio);
    var byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    var pngBytes = byteData!.buffer.asUint8List();
    var file_path = "/storage/emulated/0/Download/DataApp_Receipt.png";
    File(file_path).writeAsBytesSync(pngBytes);
    Share.shareXFiles([XFile(file_path)]);
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

  Widget data(List<dynamic> transactions) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Provider"),
            Text(transactions[index]["provider"].toUpperCase()),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Data Plan"), Text(transactions[index]["plan"])],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Type"),
            Text(transactions[index]["type"].toUpperCase()),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Amount"),
            Text("₦${transactions[index]["amount"].toString()}"),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Recepiant"), Text(transactions[index]["tel"])],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Balance"),
            Text("₦${transactions[index]['wallet_bal'].toString()}"),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Transaction Reference"),
            Text(transactions[index]["reference_id"]),
          ],
        ),
      ],
    );
  }

  Widget airtime(List<dynamic> transactions) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("provider"),
            Text(transactions[index]["provider"].toUpperCase()),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Amount"),
            Text("₦${transactions[index]["amount"].toString()}"),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Recepiant"), Text(transactions[index]["tel"])],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Balance"),
            Text("₦${transactions[index]['wallet_bal'].toString()}"),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Transaction Reference"),
            Text(transactions[index]["reference_id"]),
          ],
        ),
      ],
    );
  }

  Widget wallet_funding(List<dynamic> transactions) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Amount"),
            Text("₦${transactions[index]["amount"].toString()}"),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Balance"),
            Text("₦${transactions[index]['wallet_bal'].toString()}"),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Transaction Reference"),
            Text(transactions[index]["reference_id"]),
          ],
        ),
      ],
    );
  }

  Widget electric(List<dynamic> transactions) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Disco Provider"),
            Text(transactions[index]["provider"].toUpperCase()),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Amount"),
            Text("₦${transactions[index]["amount"].toString()}"),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Recepiant"), Text(transactions[index]["tel"])],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Units"),
            Text(transactions[index]["unit"].toString()),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("PIN"), Text(transactions[index]["pin"])],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Balance"),
            Text("₦${transactions[index]['wallet_bal'].toString()}"),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Transaction Reference"),
            Text(transactions[index]["reference_id"]),
          ],
        ),
      ],
    );
  }

  Widget edupin(List<dynamic> transactions) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Exam Type"), Text(transactions[index]["exam"])],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Amount"),
            Text("₦${transactions[index]["amount"].toString()}"),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("PIN"), Text(transactions[index]["pin"])],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Recepiant"), Text(transactions[index]["tel"])],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Balance"),
            Text("₦${transactions[index]['wallet_bal'].toString()}"),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Transaction Reference"),
            Text(transactions[index]["reference_id"]),
          ],
        ),
      ],
    );
  }

  Widget cable(List<dynamic> transactions) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Provider"),
            Text(transactions[index]["provider"].toUpperCase()),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Plan"), Text(transactions[index]["plan"])],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Amount"),
            Text("₦${transactions[index]["amount"].toString()}"),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Recepiant"), Text(transactions[index]["tel"])],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Balance"),
            Text("₦${transactions[index]['wallet_bal'].toString()}"),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Transaction Reference"),
            Text(transactions[index]["reference_id"]),
          ],
        ),
      ],
    );
  }

  Widget _content(List<dynamic> transactions) {
    var service = transactions[index]["service"].toString().toUpperCase();
    if (service == "DATA PURCHASE") {
      return data(transactions);
    } else if (service == "AIRTIME PURCHASE") {
      return airtime(transactions);
    } else if (service == "EDU PIN PURCHASE") {
      return edupin(transactions);
    } else if (service == "ELECTRIC PURCHASE") {
      return electric(transactions);
    } else if (service == "WALLET FUNDING") {
      return wallet_funding(transactions);
    } else {
      return cable(transactions);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, "/transactions");
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Text("Transation"),
          backgroundColor: Color.fromRGBO(82, 101, 140, 1),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: BlocBuilder<TransactionCubit, TransacStates>(
            builder: (context, state) {
              return state is TransacLoaded
                  ? state.transactions.isNotEmpty
                      ? ListView(
                        children: [
                          RepaintBoundary(
                            key: screen,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                        state.transactions[index]["service"]
                                            .toString()
                                            .toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromRGBO(
                                            82,
                                            101,
                                            140,
                                            1,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        state.transactions[index]["status"]
                                            .toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 15,
                                          color:
                                              state.transactions[index]["status"] ==
                                                      "success"
                                                  ? Colors.green
                                                  : state.transactions[index]["status"] ==
                                                      "pending"
                                                  ? Colors.orange
                                                  : Colors.red,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(state.transactions[index]["date"]),
                                      Divider(
                                        thickness: 1.0,
                                        color: Color.fromRGBO(82, 101, 140, 1),
                                      ),
                                    ],
                                  ),
                                  _content(state.transactions),
                                  Divider(
                                    thickness: 1.0,
                                    color: Color.fromRGBO(82, 101, 140, 1),
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
                                  backgroundColor: Color.fromRGBO(
                                    82,
                                    101,
                                    140,
                                    1,
                                  ),
                                ),
                                onPressed: () {
                                  share_receipt();
                                },
                                icon: Icon(Icons.share),
                                label: Text("Share Receipt"),
                              ),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color.fromRGBO(
                                    82,
                                    101,
                                    140,
                                    1,
                                  ),
                                ),
                                onPressed: () {
                                  downloadReceipt();
                                },
                                icon: Icon(Icons.download),
                                label: Text("Download Receipt"),
                              ),
                            ],
                          ),
                        ],
                      )
                      : SizedBox()
                  : SizedBox();
            },
          ),
        ),
      ),
      onPopInvokedWithResult: (b, t) async {
        Navigator.popAndPushNamed(context, "/transactions");
      },
    );
  }
}
