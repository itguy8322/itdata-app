import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/theme/theme_cubit.dart';
import 'package:itdata/data/cubits/theme/theme_state.dart';

void showProcessDialog(BuildContext context, {String label=""}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder:
        (context) => BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, theme) {
            return AlertDialog(
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                spacing: 5,
                children: [
                  CircularProgressIndicator(
                    color: theme.primaryColor,
                    strokeWidth: 8.4,
                    padding: EdgeInsets.all(20),
                  ),
                  Text(label.isNotEmpty? label:"Processing, please wait..."),
                ],
              ),
            );
          },
        ),
  );
}
