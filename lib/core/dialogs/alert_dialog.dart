import 'package:flutter/material.dart';

void showAlertDialog(BuildContext context, String title, String content) {
  showDialog(
    context: context,
    builder:
        (context) => AlertDialog(title: Text(title), content: Text(content)),
  );
}
