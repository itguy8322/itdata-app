import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/theme/theme_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_state.dart';
import 'package:itdata/features/wallet-funding/fund_wallet.dart';

class CardFunding extends StatefulWidget {
  const CardFunding({super.key});

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
            title: Text('Card Funding',style: TextStyle(color: theme.secondaryColor),),
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
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.fromLTRB(50,10,50,10),
                                backgroundColor: theme.primaryColor,
                              ),
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
                              child: Text(
                                "Proceed",
                                style: TextStyle(fontSize: 20, color: theme.secondaryColor),
                              ),
                            ),
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
