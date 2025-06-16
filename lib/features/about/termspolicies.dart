import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/theme/theme_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_state.dart';
import 'package:itdata/features/dashboard/dashboard.dart';

class TermsAndPolicyPage extends StatelessWidget {
  const TermsAndPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, theme) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Dashboard()));
              },
              icon: Icon(Icons.arrow_back, color: theme.secondaryColor,),
            ),
            title: Text("Terms & Policy", style: TextStyle(color: theme.secondaryColor),),
            backgroundColor: theme.primaryColor,
          ),
          body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: [
                Text(
                  "By using the IT Data application, you agree to comply with the terms and conditions outlined here. Please read them carefully.\nUsers must provide accurate information during registration.\nIt is the user’s responsibility to keep login details confidential.\nAny unauthorized use of your account must be reported immediately.\nAll payments are processed securely through our trusted partners.\nUsers are responsible for ensuring sufficient funds for transactions.\nOnce a transaction is completed, refunds are not guaranteed.\nThe application is intended for personal use only.\nUsers must not exploit the app for illegal activities.\nWe value your privacy and ensure your data is securely stored.\nPersonal information will not be shared without your consent, except as required by law.\nData App is not liable for:\nDelays or interruptions caused by third-party service providers.\nLosses due to user negligence or incorrect details.\nWe reserve the right to modify these terms at any time. Continued use of the app implies acceptance of updated terms.\n\nBy using this application, you agree to the above terms and policies.",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
