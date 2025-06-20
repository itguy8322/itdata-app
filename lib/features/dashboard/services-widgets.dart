import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/core/dialogs/alert_dialog.dart';
import 'package:itdata/data/cubits/services/data/data_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_state.dart';
import 'package:itdata/features/services/airtime.dart';
import 'package:itdata/features/services/cable.dart';
import 'package:itdata/features/services/data.dart';
import 'package:itdata/features/services/edupin.dart';
import 'package:itdata/features/services/electricity.dart';

class ServicesWidgets extends StatefulWidget {
  const ServicesWidgets({super.key});

  @override
  State<ServicesWidgets> createState() => _ServicesWidgetsState();
}

class _ServicesWidgetsState extends State<ServicesWidgets> {
  Widget _buildFeature(IconData icon, String title, String description) {
    return GestureDetector(
      onTap: () {
        //print(title);
        if (title == "Data Purchase") {
          context.read<DataCubit>().reInitialize();
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Data()));
        } else if (title == "Airtime") {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Airtime()));
        } else if (title == "TV Subscriptions") {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Cable()));
        } else if (title == "Education") {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>EduPin()));
        } else if (title == "Bill Payments") {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Electricity()));
        } else {
          showAlertDialog(context,
            "More Services",
            "There valued customer, more services will be added soon.",
          );
        }
      },
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, theme) {
          return Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 40, color: theme.primaryColor),
                SizedBox(height: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: theme.textColor),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  int _calculateCrossAxisCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 1200) {
      return 4; // Large screens
    } else if (screenWidth > 500) {
      return 3; // Medium screens
    } else {
      return 2; // Small screens
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(height: 10),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _calculateCrossAxisCount(context),
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 6,
            itemBuilder: (context, index) {
              final features = [
                [
                  Icons.wifi,
                  'Data Purchase',
                  'Affordable plans for all networks',
                ],
                [Icons.phone_android, 'Airtime', 'Instant recharge anytime'],
                [
                  Icons.tv,
                  'TV Subscriptions',
                  'Support for major TV providers',
                ],
                [
                  Icons.receipt,
                  'Bill Payments',
                  'Pay utility bills effortlessly',
                ],
                [Icons.school, 'Education', 'Buy result PIN checker'],
                [Icons.more_horiz, 'More', 'Explore more services'],
              ];
              return _buildFeature(
                features[index][0] as IconData,
                features[index][1] as String,
                features[index][2] as String,
              );
            },
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
