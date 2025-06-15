import 'package:flutter/material.dart';

void showStatusDialog(BuildContext context, String status) {
  // Navigator.popAndPushNamed(context, "/dashboard");
  showDialog(
    context: context,
    builder: (context) {
      if (status == "success") {
        return AlertDialog(
          title: SizedBox(
            height: 80,
            child: Image.asset("assets/images/success.gif", scale: 1.0),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Transaction Successful!",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      } else if (status == "pending") {
        return AlertDialog(
          title: Icon(Icons.pending, color: Colors.orange, size: 50),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Transaction Pending!",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      } else if (status == "fail") {
        return AlertDialog(
          title: Icon(Icons.warning_rounded, color: Colors.red, size: 50),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Transaction Failed!",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      } else if (status == "Insufficient balance") {
        return AlertDialog(
          title: Icon(Icons.close, color: Colors.red, size: 50),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Insufficient balance",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      } else {
        return AlertDialog(content: Text(status));
      }
    },
  );
}
