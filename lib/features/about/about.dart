import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/theme/theme_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_state.dart';
import 'package:itdata/features/dashboard/dashboard.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

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
            title: Text("About Us", style: TextStyle(color: theme.secondaryColor),),
            backgroundColor: theme.primaryColor,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                SizedBox(
                  height: 60,
                  child: Image.asset("assets/images/data_app_logo.png", scale: 2),
                ),
                SizedBox(width: 5.0),
                Text(
                  'IT Data',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'Welcome to IT Data, your one-stop solution for effortless mobile and subscription management. Our platform is designed to simplify your life by providing a seamless way to purchase data, airtime, and other essential subscriptions right from your Android device.\n\nAt IT Data, we are committed to offering:\n1. Convenience: Access all your mobile needs in one place, anytime, anywhere.\n2. Reliability: Enjoy a smooth and secure transaction process every time.\n3. Affordability: Get the best value for your money with competitive rates.',
                  style: TextStyle(fontSize: 16, height: 1.5),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'Our Mission',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  'Our mission is to empower you with easy access to services that keep you connected and productive. Join thousands of satisfied users and experience the difference today!',
                  style: TextStyle(fontSize: 16, height: 1.5),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'Contact Us',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  'For any inquiries or assistance, please contact us at:\n\nEmail: itguy.data@gaimal.com.com\nPhone: +234 916 491 6848\nWhatsApp: +234 916 491 6848\nAddress: Bayero University, Kano, Kano State, Nigeria',
                  style: TextStyle(fontSize: 16, height: 1.5),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
