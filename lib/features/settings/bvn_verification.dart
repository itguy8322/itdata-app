import 'package:flutter/material.dart';

class BVNVerifiaction extends StatefulWidget {
  const BVNVerifiaction({super.key});

  @override
  State<BVNVerifiaction> createState() => _BVNVerifiactionState();
}

class _BVNVerifiactionState extends State<BVNVerifiaction> {
  final TextEditingController bvn = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Implement some initialization operations here.
    if (user_data["bvn"] != "") {
      bvn.text = user_data["bvn"];
      setState(() {});
    }
  }

  void status(var _title, var status) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(title: Text(_title), content: Text(status)),
    );
  }

  void process() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder:
          (context) => AlertDialog(
            title: SizedBox(
              height: 60,
              child: Image.asset("assets/images/loading.gif", scale: 1.0),
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Processing, please wait...")],
            ),
          ),
    );
    //status("pending");
  }

  void verifyBVN() async {
    final url = Uri.parse("$_url/user/create-virtual-account");
    final headers = {"Content-Type": "application/x-www-form-urlencoded"};
    final body = {
      "account_type": "static",
      "bvn": bvn.text,
      "username": user_data["username"].toString(),
    };
    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        print("It's Working...");
        var data = jsonDecode(response.body);
        //print(data);
        if (data["status"] == "ok") {
          user_data["bvn"] = data["bvn"];
          virtual_accounts = data["virtual-accounts"];
          setState(() {});
          Navigator.pop(context);
          //Navigator.popAndPushNamed(context, "/dashboard");
          status("Virtual Account", data["status"]);
        } else {
          Navigator.pop(context);
          status("Alert", data["status"]);
        }
      } else {
        Navigator.pop(context);
        status("Alert", "Check your internet connection and try again!");
      }
    } catch (e) {
      Navigator.pop(context);
      status(
        "Alert",
        "Could not connect, check your internet connection and try again! ${e.toString()}",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, "/security");
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Text("BVN Verification"),
          backgroundColor: mainColor,
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 30), // Space between title and fields
                TextFormField(
                  controller: bvn,
                  readOnly: user_data["bvn"] == "" ? false : true,
                  decoration: InputDecoration(
                    labelText: 'Enter BVN number',
                    labelStyle: TextStyle(color: Colors.grey),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: mainColor),
                    ),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'All field required';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20.0), // Spacing between fields

                SizedBox(height: 20.0), // Spacing between fields
                // Sign Up Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Show error message for mismatched passwords
                      if (_formKey.currentState!.validate()) {
                        if (user_data["bvn"] == "") {
                          process();
                          verifyBVN();
                        }
                      }
                    },
                    child: Text(
                      user_data["bvn"] == ""
                          ? 'Verify'
                          : "BVN already Verified",
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      padding: EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 15,
                      ),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  textAlign: TextAlign.center,
                  "Note: Your BVN name must be the same as your account name!",
                ),
              ],
            ),
          ),
        ),
      ),
      onPopInvokedWithResult: (b, t) async {
        Navigator.popAndPushNamed(context, "/security");
      },
    );
  }
}
