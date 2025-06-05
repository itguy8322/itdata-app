import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/transaction/transaction_cubit.dart';
import 'package:itdata/features/transactions/view_transaction.dart';
import 'package:itdata/services/auth.dart';
import 'package:itdata/states/transac_states.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  @override
  void initState() {
    super.initState();
  }

  void status(var _title, var status) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(title: Text(_title), content: Text(status)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, "/dashboard");
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Text("Transactions"),
          backgroundColor: Color.fromRGBO(82, 101, 140, 1),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<TransactionCubit, TransacStates>(
            builder: (context, state) {
              return state is TransacLoaded
                  ? state.transactions.isEmpty
                      ? Center(child: Text("No Transactions history yet!"))
                      : RefreshIndicator(
                        color: Color.fromRGBO(82, 101, 140, 1),
                        child: ListView.builder(
                          itemCount: state.transactions.length,
                          itemBuilder: (context, index) {
                            final transaction = state.transactions[index];
                            try {
                              return Card(
                                elevation: 3,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder:
                                            (BuildContext context) =>
                                                ViewTransactionPage(index: 0),
                                      ),
                                    );
                                  },
                                  leading: Icon(
                                    transaction['status'] == 'success'
                                        ? Icons.check_circle
                                        : transaction['status'] == 'pending'
                                        ? Icons.pending
                                        : Icons.warning,
                                    color:
                                        transaction['status'] == 'success'
                                            ? Colors.green
                                            : transaction['status'] == 'pending'
                                            ? Colors.orange
                                            : Colors.red,
                                  ),
                                  title: Text(
                                    transaction['service']
                                        .toString()
                                        .toUpperCase(),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 5),
                                      Text(
                                        "₦${transaction['amount'].toString()}",
                                      ),
                                      SizedBox(height: 5),
                                      Text(transaction['date'].toString()),
                                    ],
                                  ),
                                  trailing: Text(
                                    transaction['status'].toString(),
                                    style: TextStyle(
                                      color:
                                          transaction['status'] == 'success'
                                              ? Colors.green
                                              : transaction['status'] ==
                                                  'pending'
                                              ? Colors.orange
                                              : Colors.red,
                                    ),
                                  ),
                                ),
                              );
                            } catch (e) {
                              return Text(e.toString());
                            }
                          },
                        ),
                        onRefresh: () async {
                          User? user = Auth().currentUser;
                          final transac = BlocProvider.of<TransactionCubit>(
                            context,
                          );
                          transac.load_transactions(
                            user?.email,
                            "transactions",
                          );
                        },
                      )
                  : Center(child: Text("No Transactions history yet!"));
            },
          ),
        ),
      ),
      onPopInvokedWithResult: (b, t) async {
        Navigator.popAndPushNamed(context, "/dashboard");
      },
    );
  }
}
