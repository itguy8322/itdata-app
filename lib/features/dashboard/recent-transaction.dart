// ignore_for_file: file_names

import 'package:flutter/material.dart';

class RecentTransactions extends StatefulWidget {
  final List<dynamic> transactions;
  const RecentTransactions({super.key, required this.transactions});

  @override
  State<RecentTransactions> createState() => _RecentTransactionsState();
}

class _RecentTransactionsState extends State<RecentTransactions> {
  @override
  Widget build(BuildContext context) {
    final transactions = widget.transactions;
    List<Widget> recent_tranc(List transactions) {
      List<Widget> wdgt = [];
      for (var item in transactions) {
        wdgt.add(
          Card(
            child: ListTile(
              leading: Icon(
                item["status"] == "success"
                    ? Icons.check_circle
                    : item["status"] == "pending"
                    ? Icons.pending
                    : Icons.warning,
                color:
                    item["status"] == "success"
                        ? Colors.green
                        : item["status"] == "pending"
                        ? Colors.orange
                        : Colors.red,
              ),
              trailing: Text(
                "${item['status']}",
                style: TextStyle(
                  color:
                      item["status"] == "success"
                          ? Colors.green
                          : item["status"] == "pending"
                          ? Colors.orange
                          : Colors.red,
                ),
              ),
              title: Text("${item['service']}".toUpperCase()),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Text("${item['date']}"),
                  SizedBox(height: 5),
                  Text("To: ${item['tel']}"),
                ],
              ),
            ),
          ),
        );
      }
      return wdgt;
    }

    return Column(children: recent_tranc(transactions));
  }
}
