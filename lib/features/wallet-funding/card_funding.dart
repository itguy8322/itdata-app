import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/theme/theme_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_state.dart';

class CardFunding extends StatefulWidget {
  @override
  _CardFundingState createState() => _CardFundingState();
}

class _CardFundingState extends State<CardFunding> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController cardNumber = TextEditingController();
  TextEditingController expiryDate = TextEditingController();
  TextEditingController cvv = TextEditingController();
  TextEditingController cardHolderName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, theme) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, "/fundWallet");
                },
                icon: Icon(Icons.arrow_back),
              ),
              backgroundColor: theme.primaryColor,
              title: Text('Card Funding'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/images/cards.png",
                        scale: 5.0,
                        width: 250,
                        filterQuality: FilterQuality.low,
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: cardNumber,
                      decoration: InputDecoration(
                        labelText: 'Card Number',
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: theme.primaryColor),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid card number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 120,
                          child: TextFormField(
                            controller: expiryDate,
                            decoration: InputDecoration(
                              labelText: 'MM/YY',
                              labelStyle: TextStyle(color: Colors.grey),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: theme.primaryColor,
                                ),
                              ),
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.datetime,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the expiry date';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        SizedBox(
                          width: 100,
                          child: TextFormField(
                            controller: cvv,
                            decoration: InputDecoration(
                              labelText: 'CVV',
                              labelStyle: TextStyle(color: Colors.grey),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: theme.primaryColor,
                                ),
                              ),
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length != 3) {
                                return 'Please enter a valid CVV';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: cardHolderName,
                      decoration: InputDecoration(
                        labelText: 'Cardholder Name',
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: theme.primaryColor),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the cardholder name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 32),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Mock payment process
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                      ),
                                      Text("Payment Successful"),
                                    ],
                                  ),
                                  content: Text(
                                    "Your payment of has been processed.",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pop(
                                          context,
                                        ); // Return to previous page
                                      },
                                      child: Text("OK"),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primaryColor,
                          padding: EdgeInsets.all(20),
                        ),
                        child: Text("Proceed", style: TextStyle(fontSize: 25)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      onPopInvokedWithResult: (b, t) async {
        Navigator.popAndPushNamed(context, "/fundWallet");
      },
    );
  }
}
