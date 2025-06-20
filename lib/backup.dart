// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, use_key_in_widget_constructors, avoid_print, non_constant_identifier_names, use_build_context_synchronously, unused_local_variable, no_leading_underscores_for_local_identifiers, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, prefer_typing_uninitialized_variables, library_prefixes, unnecessary_null_comparison, unused_field, prefer_final_fields, avoid_unnecessary_containers, unused_element, library_private_types_in_public_api

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'dart:core';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

var _main_url = "https://itdata.pythonanywhere.com";
var main_url = "https://1a52-102-91-72-148.ngrok-free.app";
var dev_url = "http://192.168.0.195:5050";
var _url = main_url;
bool dev = true;
var user_data = {};
var dataplans = {};
var datatypes = [];
var data_plans = [];
var networks = {};
var exams = {};
var electricity = {};
var edupins = {};
var cable_plans = {};
var cable_types = [];
var virtual_accounts = [];
var transfer_amount = 0;
final storage = FlutterSecureStorage();
bool remember_me = false;
String _remember_me = "false";
String theme = "default";
var mainColor;
Color? subColor = Colors.white;
var show_balance = false;
int t_index = 0;
bool biometric = false;
bool emailnotify = false;
bool pushnotify = false;
String _biometric = "false";
String _pushnotify = "false";
String _emailnotify = "false";
var permission_status = "false";

bool set_pin = false;
var new_pin = "";
var conf_pin = "";
var pin_status = "";
bool pin_alert = true;
bool reg_noti_listener = false;
bool reg_data_listener = false;
bool reg_airtime_listener = false;
bool reg_cable_listener = false;
bool reg_edu_listener = false;
bool reg_elec_listener = false;
Random random = Random();
bool fund_wallet_noti = false;
List<dynamic> transactions = [];

List<dynamic> notifications = [];

late IO.Socket socket;

bool connection = false;
void main() async {
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: 'basic_channel',
      channelName: 'Basic notifications',
      channelDescription: 'Notification channel for basic tests',
    ),
  ], debug: true);
  try {
    _remember_me = (await storage.read(key: 'remember_me'))!;
  } catch (e) {
    //print("Could not read remeber me: $e");
  }
  try {
    theme = (await storage.read(key: 'theme'))!;
  } catch (e) {
    //print("Could not read theme: $e");
  }
  try {
    _biometric = (await storage.read(key: 'biometric'))!;
    //print(_biometric);
  } catch (e) {
    //print("Could not read Biometric: $e");
  }
  try {
    _pushnotify = (await storage.read(key: 'pushnotify'))!;
  } catch (e) {
    //print("Could not read Push Noti: $e");
  }
  try {
    _emailnotify = (await storage.read(key: 'emailnotify'))!;
  } catch (e) {
    //print("Could not read Email Noti: $e");
  }
  if (_biometric == "true") {
    biometric = true;
  }
  if (_remember_me == "true") {
    remember_me = true;
  }
  if (_emailnotify == "true") {
    emailnotify = true;
  }

  if (_pushnotify == "true") {
    pushnotify = true;
  }

  if (theme == "default") {
    mainColor = Color.fromRGBO(82, 101, 140, 1);
  } else if (theme == "blue") {
    mainColor = Colors.blue[800];
  } else if (theme == "orange") {
    mainColor = Colors.orange[800];
  } else if (theme == "brown") {
    mainColor = Color.fromARGB(255, 98, 12, 0);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: mainColor),
      initialRoute: "/",
      routes: {
        "/": (context) => SplashScreen(),
        "/landing": (context) => LandingPage(),
        "/login": (context) => LoginPage(),
        "/signup": (context) => SignupPage(),
        "/forgot_password": (context) => ForgotPasswordPage(),
        "/change_password": (context) => ChangeNewPasswordPage(),
        "/dashboard": (context) => DataApp(),
        "/fundWallet": (context) => FundWalletPage(),
        "/bank_fund": (context) => TransferFunding(),
        "/card_fund": (context) => CardFundingPage(),
        "/data": (context) => BuyDataPage(),
        "/airtime": (context) => BuyAirtimePage(),
        "/edupin": (context) => BuyEduPinPage(),
        "/electricity": (context) => BuyElectricityPage(),
        "/cable": (context) => BuyCablePage(),
        "/transactions": (context) => TransactionsPage(),
        "/transaction": (context) => TransactionPage(),
        "/notification": (context) => NotificationsPage(),
        "/about_us": (context) => AboutUsPage(),
        "/settings": (context) => Settings(),
        "/security": (context) => SecurityPage(),
        "/notisetting": (context) => NotificationPage(),
        "/theme": (context) => ThemePage(),
        "/changepin": (context) => ChangePinPage(),
        "/changepassword": (context) => ChangePasswordPage(),
        "/bvn_verification": (context) => BVNVerificationPage(),
        "/profile": (context) => ProfilePage(),
        "/termspolicy": (context) => TermsAndPolicyPage(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void requestPermissions() async {
    try {
      await Permission.storage.request();
      permission_status = "pass";
    } catch (e) {
      //print(e.toString());
      permission_status = "pass";
    }
  }

  void status(var _title, var status) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(title: Text(_title), content: Text(status)),
    );
  }

  void login(var username, var password) async {
    final url = Uri.parse("$_url/user/athentication");
    final headers = {"Content-Type": "application/x-www-form-urlencoded"};
    final body = {"username": username, "password": password};
    try {
      //print("It's Working...");
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        //print("It's Working...");
        var data = jsonDecode(response.body);
        ////print(data);
        if (data["status"] == "ok") {
          var _data = data["data"];
          user_data = _data["user_data"];
          datatypes = _data["data_types"];
          dataplans = _data["dataplans"];
          networks = _data["networks"];
          exams = _data["exams"];
          electricity = _data["electricity"];
          cable_plans = _data["cableplans"];
          cable_types = _data["cable_types"];
          //print(networks);

          if (_data["transactions"].isNotEmpty) {
            transactions = _data["transactions"];
          }
          if (_data["notifications"].isNotEmpty) {
            notifications = _data["notifications"];
          }
          Navigator.popAndPushNamed(context, "/dashboard");
        } else {
          Navigator.popAndPushNamed(context, "/login");
          status("Alert", data["status"]);
        }
      } else {
        Navigator.popAndPushNamed(context, "/login");
        status(
          "Connection Error",
          "check your internet connection and try again!",
        );
      }
    } catch (e) {
      status(
        "Unexpected Error",
        "Could ne not connect, check your internet connection and try again! ${e.toString()}",
      );
      Navigator.popAndPushNamed(context, "/login");
    }
  }

  void rememberMe() async {
    if (remember_me == true) {
      //print("hereeeeee");
      String username = (await storage.read(key: 'username'))!;
      String password = (await storage.read(key: 'password'))!;
      login(username, password);
    } else {
      Timer(Duration(seconds: 3), () {
        Navigator.popAndPushNamed(context, "/login");
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (dev == true) {
      _url = dev_url;
    } else {
      _url = main_url;
    }
    requestPermissions();
    rememberMe();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Image.asset("assets/images/loading.gif", scale: 10.0)),
      ],
    );
  }
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [mainColor, Color.fromARGB(255, 48, 60, 132)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Welcome to DataPlus',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'The easiest way to purchase data, airtime, pay bills, and manage your subscriptions.',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to sign up page
                      Navigator.pushNamed(context, "/login");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Features Section
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Why Choose Us?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Experience seamless transactions, quick service delivery, and reliable support tailored for your needs.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  SizedBox(height: 30),

                  // Grid Layout for Features
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _calculateCrossAxisCount(context),
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      final features = [
                        [
                          Icons.wifi,
                          'Data Purchase',
                          'Affordable plans for all networks',
                        ],
                        [
                          Icons.phone_android,
                          'Airtime',
                          'Instant recharge anytime',
                        ],
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
                        [
                          Icons.account_balance_wallet,
                          'Wallet',
                          'Easily manage your funds',
                        ],
                        [
                          Icons.security,
                          'Secure',
                          'Advanced data security and encryption',
                        ],
                        [
                          Icons.support_agent,
                          '24/7 Support',
                          'Dedicated customer service',
                        ],
                        [
                          Icons.insights,
                          'Track Expenses',
                          'Monitor your spending trends',
                        ],
                      ];
                      return _buildFeature(
                        features[index][0] as IconData,
                        features[index][1] as String,
                        features[index][2] as String,
                      );
                    },
                  ),
                ],
              ),
            ),

            // Testimonials Section
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'What Our Users Say',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Join thousands of satisfied customers who trust DataPlus for their daily transactions.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  SizedBox(height: 20),
                  _buildTestimonial(
                    'John Doe',
                    'Fantastic app! Seamless and reliable. Highly recommend to everyone.',
                  ),
                  _buildTestimonial(
                    'Jane Smith',
                    'Great customer service and very easy to use. My go-to app for transactions.',
                  ),
                ],
              ),
            ),

            // Footer Section
            Container(
              color: Colors.grey.shade200,
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Ready to Simplify Your Transactions?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to sign in or sign up
                      Navigator.pushNamed(context, "/signup");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Join Now',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Contact Us',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/phone.png", scale: 80),
                      Text("   +2349164916848"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/whatsapp.png", scale: 50),
                      Text("   +2349024255041"),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    '© 2024 DataPlus. All rights reserved.',
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
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

  Widget _buildFeature(IconData icon, String title, String description) {
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
          Icon(icon, size: 40, color: mainColor),
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
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonial(String name, String feedback) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(15),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 5),
          Text(feedback, style: TextStyle(fontSize: 14, color: Colors.black54)),
        ],
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    if (dev == true) {
      _url = dev_url;
    } else {
      _url = main_url;
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

  void login() async {
    setState(() {});
    final url = Uri.parse("$_url/user/athentication");
    final headers = {"Content-Type": "application/x-www-form-urlencoded"};
    final body = {"username": username.text, "password": password.text};
    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        //print("It's Working...");
        var data = jsonDecode(response.body);
        ////print(data);
        if (data["status"] == "ok") {
          var _data = data["data"];
          user_data = _data["user_data"];
          datatypes = _data["data_types"];
          dataplans = _data["dataplans"];
          networks = _data["networks"];
          exams = _data["exams"];
          electricity = _data["electricity"];
          cable_plans = _data["cableplans"];
          cable_types = _data["cable_types"];
          ////print(datatypes);
          if (_data["transactions"].isNotEmpty) {
            transactions = _data["transactions"];
          }
          if (_data["notifications"].isNotEmpty) {
            notifications = _data["notifications"];
          }
          if (user_data["bvn"] != "") {
            virtual_accounts = _data["vaccounts"];
          }
          Navigator.pop(context);
          Navigator.popAndPushNamed(context, "/dashboard");
        } else {
          Navigator.pop(context);
          status("Alert", data["status"]);
        }
      } else {
        Navigator.pop(context);
        status(
          "Connection Error",
          "check your internet connection and try again!",
        );
      }
    } catch (e) {
      Navigator.pop(context);
      status(
        "Unexpected Error",
        "Could ne not connect, check your internet connection and try again! ${e.toString()}",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Image.asset("assets/images/data_app_logo.png", scale: 40),
                      Text(
                        'IT Data',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: mainColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(height: 70),
                  Text(
                    "Sign in to your account",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 30), // Space between title and fields
                  TextFormField(
                    controller: username,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: TextStyle(color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: mainColor),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'All field required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0), // Spacing between fields
                  TextFormField(
                    controller: password,
                    decoration: InputDecoration(
                      labelText: 'Password',
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
                    obscureText: true, // Hide password
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          // Navigate to login page
                          Navigator.popAndPushNamed(
                            context,
                            "/forgot_password",
                          );
                        },
                        child: Text(
                          'Forget Password?',
                          style: TextStyle(color: mainColor),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 10,
                            child: Checkbox(
                              checkColor: subColor,
                              activeColor: mainColor,
                              value: remember_me,
                              onChanged: (value) {
                                setState(() {
                                  remember_me = value!;
                                });
                                //print(remember_me);
                              },
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Navigate to login page
                              if (remember_me == true) {
                                remember_me = false;
                              } else {
                                remember_me = true;
                              }
                              //print(remember_me);
                              setState(() {});
                            },
                            child: Text(
                              'Remember me',
                              style: TextStyle(color: mainColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 24.0), // Spacing before the login button
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (remember_me == true) {
                          await storage.write(
                            key: 'remember_me',
                            value: '${remember_me.toString()}',
                          );
                          await storage.write(
                            key: 'username',
                            value: username.text,
                          );
                          await storage.write(
                            key: 'password',
                            value: password.text,
                          );
                          //print("setting remember");
                        }
                        process();
                        login();
                      }
                    },
                    child: Text('Login'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      padding: EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 15,
                      ),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Don't have an account? "),
                      TextButton(
                        onPressed: () {
                          // Navigate to login page
                          Navigator.popAndPushNamed(context, "/signup");
                        },
                        child: Text(
                          'Create Account',
                          style: TextStyle(color: mainColor),
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to login page
                      Navigator.popAndPushNamed(context, "/landing");
                    },
                    child: Text(
                      'Go to main page',
                      style: TextStyle(color: mainColor),
                    ),
                  ),
                  Row(
                    children: [
                      Text('Test Mode', style: TextStyle(color: mainColor)),
                      Switch(
                        value: dev,
                        activeColor: mainColor,
                        onChanged: (value) async {
                          //print("hello");
                          setState(() {
                            dev = value;
                            if (dev == true) {
                              _url = dev_url;
                            } else {
                              _url = main_url;
                            }
                            //print(_url);
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      onPopInvokedWithResult: (b, t) async {},
    );
  }
}

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController fullname = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController number = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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

  void status(var _title, var status) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(title: Text(_title), content: Text(status)),
    );
  }

  void signup() async {
    final url = Uri.parse("$_url/user/signup");
    final headers = {"Content-Type": "application/x-www-form-urlencoded"};
    final body = {
      "fullname": fullname.text,
      "username": username.text,
      "email": email.text,
      "tel": number.text,
      "address": address.text,
      "password": password.text,
    };
    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        //print("It's Working...");
        var data = jsonDecode(response.body);
        //print(data);
        if (data["status"] == "ok") {
          var _data = data["data"];
          user_data = _data["user_data"];
          datatypes = _data["data_types"];
          dataplans = _data["dataplans"];
          networks = _data["networks"];
          exams = _data["exams"];
          electricity = _data["electricity"];
          cable_plans = _data["cableplans"];
          cable_types = _data["cable_types"];
          if (_data["transactions"].isNotEmpty) {
            transactions = _data["transactions"];
          }
          if (_data["notifications"].isNotEmpty) {
            notifications = _data["notifications"];
          }

          set_pin = true;

          Navigator.pop(context);
          Navigator.popAndPushNamed(context, "/changepin");
        } else {
          Navigator.pop(context);
          status("Alert", "Wrong username or password!");
        }
      } else {
        Navigator.pop(context);
        status(
          "Connection Error",
          "check your internet connection and try again!",
        );
      }
    } catch (e) {
      Navigator.pop(context);
      status(
        "Unexpected Error",
        "Could ne not connect, check your internet connection and try again! ${e.toString()}",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 50),
                  Row(
                    children: [
                      Image.asset("assets/images/data_app_logo.png", scale: 40),
                      Text(
                        'IT Data',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: mainColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Text("Create an account", style: TextStyle(fontSize: 20)),
                  SizedBox(height: 10),

                  // Already have an account?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Already have an account? "),
                      TextButton(
                        onPressed: () {
                          // Navigate to login page
                          Navigator.popAndPushNamed(context, "/login");
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(color: mainColor),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5), // Space between title and fields
                  TextFormField(
                    controller: fullname,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
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
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: username,
                    decoration: InputDecoration(
                      labelText: 'Username',
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
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      labelText: 'Email',
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
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: address,
                    decoration: InputDecoration(
                      labelText: 'Address',
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
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: number,
                    keyboardType: TextInputType.phone,
                    maxLength: 11,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
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
                  SizedBox(height: 10.0), // Spacing between fields
                  TextFormField(
                    controller: password,
                    decoration: InputDecoration(
                      labelText: 'Password',
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
                    obscureText: true, // Hide password
                  ),
                  SizedBox(height: 10.0), // Spacing between fields
                  TextFormField(
                    controller: confirmPassword,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
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
                    obscureText: true, // Hide password
                  ),
                  SizedBox(height: 10.0),
                  // Sign Up Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle sign-up logic (e.g., validation, API call)
                        if (_formKey.currentState!.validate()) {
                          if (password.text == confirmPassword.text) {
                            process();
                            signup();
                          } else {
                            status("Alert", "Password do not match!");
                          }
                        }

                        // Optionally, navigate to the login page or dashboard
                      },
                      child: Text('Sign Up'),
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
                ],
              ),
            ),
          ),
        ),
      ),
      onPopInvokedWithResult: (b, t) async {
        Navigator.popAndPushNamed(context, "/login");
      },
    );
  }
}

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController username = TextEditingController();
  final TextEditingController verification_code = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool code_sent = false;
  var _status = "";
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

  void send_verification_code() async {
    final url = Uri.parse("$_url/user/forgot-password");
    final headers = {"Content-Type": "application/x-www-form-urlencoded"};
    final body = {"username": username.text};
    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        //print("It's Working...");
        var data = jsonDecode(response.body);
        ////print(data);
        if (data["status"] == "ok") {
          var _data = data["data"];
          user_data = _data["user_data"];
          setState(() {
            code_sent = true;
            _status =
                "Verification code was sent to this email address: ${user_data['email']}";
          });
          Navigator.pop(context);
        } else {
          Navigator.pop(context);
          status("Alert", data["status"]);
        }
      } else {
        Navigator.pop(context);
        status(
          "Connection Error",
          "check your internet connection and try again!",
        );
      }
    } catch (e) {
      Navigator.pop(context);
      status(
        "Unexpected Error",
        "Could ne not connect, check your internet connection and try again! ${e.toString()}",
      );
    }
  }

  void verify_code() async {
    final url = Uri.parse("$_url/user/code-verification");
    final headers = {"Content-Type": "application/x-www-form-urlencoded"};
    final body = {
      "username": user_data["username"],
      "code": verification_code.text,
    };
    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        //print("It's Working...");
        var data = jsonDecode(response.body);
        ////print(data);
        if (data["status"] == "ok") {
          setState(() {
            code_sent = false;
          });
          Navigator.pop(context);
          Navigator.popAndPushNamed(context, "/change_password");
        } else {
          Navigator.pop(context);
          status("Alert", data["status"]);
        }
      } else {
        Navigator.pop(context);
        status(
          "Connection Error",
          "check your internet connection and try again!",
        );
      }
    } catch (e) {
      Navigator.pop(context);
      status(
        "Unexpected Error",
        "Could ne not connect, check your internet connection and try again! ${e.toString()}",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Image.asset("assets/images/data_app_logo.png", scale: 40),
                      Text(
                        'IT Data',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: mainColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(height: 70),
                  Text("Forgot Password", style: TextStyle(fontSize: 20)),
                  SizedBox(height: 5),
                  code_sent
                      ? Text("$_status")
                      : Text("Enter your username/email"),
                  SizedBox(height: 30),
                  code_sent != true
                      ? // Space between title and fields
                      TextFormField(
                        controller: username,
                        decoration: InputDecoration(
                          labelText: 'Username/email',
                          labelStyle: TextStyle(color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: mainColor),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'All field required';
                          }
                          return null;
                        },
                      )
                      :
                      // Spacing between fields
                      TextFormField(
                        controller: verification_code,
                        decoration: InputDecoration(
                          labelText: 'Code',
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
                        obscureText: true, // Hide password
                      ),
                  SizedBox(height: 24.0), // Spacing before the login button
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        process();
                        if (code_sent == false) {
                          send_verification_code();
                        } else {
                          verify_code();
                        }
                      }
                    },
                    child: Text(code_sent ? 'Verify' : 'Send Code'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      padding: EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 15,
                      ),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
      onPopInvokedWithResult: (b, t) async {},
    );
  }
}

class ChangeNewPasswordPage extends StatefulWidget {
  const ChangeNewPasswordPage({super.key});

  @override
  State<ChangeNewPasswordPage> createState() => _ChangeNewPasswordPageState();
}

class _ChangeNewPasswordPageState extends State<ChangeNewPasswordPage> {
  final TextEditingController password = TextEditingController();
  final TextEditingController cpassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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

  void change_password() async {
    final url = Uri.parse("$_url/user/change-password");
    final headers = {"Content-Type": "application/x-www-form-urlencoded"};
    final body = {"username": user_data['username'], "password": password.text};
    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        //print("It's Working...");
        var data = jsonDecode(response.body);
        ////print(data);
        if (data["status"] == "ok") {
          Navigator.pop(context);
          Navigator.popAndPushNamed(context, "/login");
          status("Alert", "Password changed successfully!");
        } else {
          Navigator.pop(context);
          status("Alert", data["status"]);
        }
      } else {
        Navigator.pop(context);
        status(
          "Connection Error",
          "check your internet connection and try again!",
        );
      }
    } catch (e) {
      Navigator.pop(context);
      status(
        "Unexpected Error",
        "Could ne not connect, check your internet connection and try again! ${e.toString()}",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Image.asset("assets/images/data_app_logo.png", scale: 40),
                      Text(
                        'IT Data',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: mainColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(height: 70),
                  Text("Change Passowrd", style: TextStyle(fontSize: 20)),
                  SizedBox(height: 30), // Space between title and fields
                  TextFormField(
                    controller: password,
                    decoration: InputDecoration(
                      labelText: 'Enter new password',
                      labelStyle: TextStyle(color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: mainColor),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'All field required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0), // Spacing between fields
                  TextFormField(
                    controller: cpassword,
                    decoration: InputDecoration(
                      labelText: 'Confirm password',
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
                    obscureText: true, // Hide password
                  ),

                  SizedBox(height: 24.0), // Spacing before the login button
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        process();
                        change_password();
                      }
                    },
                    child: Text('Change Password'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      padding: EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 15,
                      ),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          // Navigate to login page
                          Navigator.popAndPushNamed(context, "/login");
                        },
                        child: Text(
                          'Back to login Page',
                          style: TextStyle(color: mainColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      onPopInvokedWithResult: (b, t) async {},
    );
  }
}

class DataApp extends StatefulWidget {
  const DataApp({super.key});

  @override
  State<DataApp> createState() => _DataAppState();
}

class _DataAppState extends State<DataApp> {
  _connect() {
    socket.onConnect((data) {
      //print("Connection Established");
      socket.emit('join', {"username": user_data['username']});
      connection = true;
      socket.on('message', (data) {
        //print(data);
      });
      socket.on('fundWallet', (data) {
        //print(data);
        user_data["wallet_bal"] = data["wallet_bal"];
        transactions = data["transactions"];
        notifications = data["notifications"];
        int id = random.nextInt(100);
        if (pushnotify == true) {
          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: id,
              channelKey: 'basic_channel',
              title: "Wallet Fund",
              body: "${data['content']}",
            ),
          );
        }
      });
    });
    // socket.onConnectError((data) => //print("Connect Error: $data"));
    // socket.onDisconnect((data) => //print("Connect Closed"));
  }

  recv_noti() {
    socket.on('notification', (data) {
      if (pushnotify == true) {
        //print("here");

        int id = random.nextInt(100);
        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: id,
            channelKey: 'basic_channel',
            title: data["title"],
            body: data["content"],
          ),
        );
      }
    });
  }

  void noti_actions() async {
    try {
      AwesomeNotifications().setListeners(
        onActionReceivedMethod: (receivedAction) async {
          // Check if the app context is available
          Navigator.popAndPushNamed(context, "/notification");
        },
      );
    } catch (e) {
      status("Error", e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    // Implement some initialization operations here.
    if (connection == false) {
      socket = IO.io(
        "$_url",
        IO.OptionBuilder().setTransports(['websocket']).build(),
      );
      _connect();

      noti_actions();
    }
  }

  void status(var _title, var status) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(title: Text(_title), content: Text(status)),
    );
  }

  List<Widget> recent_tranc() {
    List<Widget> wdgt = [];
    var index = 0;
    for (var item in transactions) {
      wdgt.add(
        Card(
          child: ListTile(
            leading: Icon(
              item["status"] == "success"
                  ? Icons.check_circle
                  : item["status"] == "pending"
                  ? Icons.pending
                  : Icons.warning,
              color:
                  item["status"] == "success"
                      ? Colors.green
                      : item["status"] == "pending"
                      ? Colors.orange
                      : Colors.red,
            ),
            trailing: Text(
              "${item['status']}",
              style: TextStyle(
                color:
                    item["status"] == "success"
                        ? Colors.green
                        : item["status"] == "pending"
                        ? Colors.orange
                        : Colors.red,
              ),
            ),
            title: Text("${item['service']}".toUpperCase()),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                Text("${item['date']}"),
                SizedBox(height: 5),
                Text("To: ${item['tel']}"),
              ],
            ),
          ),
        ),
      );
      index++;
      if (index == 3) {
        break;
      }
    }
    return wdgt;
  }

  @override
  Widget build(BuildContext context) {
    if (reg_noti_listener == false) {
      recv_noti();
      reg_noti_listener = true;
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

    Widget _buildFeature(IconData icon, String title, String description) {
      return GestureDetector(
        onTap: () {
          //print(title);
          if (title == "Data Purchase") {
            Navigator.popAndPushNamed(context, "/data");
          } else if (title == "Airtime") {
            Navigator.popAndPushNamed(context, "/airtime");
          } else if (title == "TV Subscriptions") {
            Navigator.popAndPushNamed(context, "/cable");
          } else if (title == "Education") {
            Navigator.popAndPushNamed(context, "/edupin");
          } else if (title == "Bill Payments") {
            Navigator.popAndPushNamed(context, "/electricity");
          } else {
            status(
              "More",
              "There valued customer, more services will be added soon.",
            );
          }
        },
        child: Container(
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
              Icon(icon, size: 40, color: mainColor),
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
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
        ),
      );
    }

    return PopScope(
      child: Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text("IT Data (${user_data['username']})"),
          backgroundColor: mainColor,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, "/notification");
              },
              icon: Icon(Icons.notifications),
            ),
          ],
          elevation: 0.0,
        ),
        body: RefreshIndicator(
          color: mainColor,
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          height: 120,
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Wallet balance",
                                      style: TextStyle(color: subColor),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      show_balance == true
                                          ? "₦${user_data['wallet_bal']}"
                                          : "****",
                                      style: TextStyle(
                                        color: subColor,
                                        fontSize: 26,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        show_balance =
                                            show_balance == false
                                                ? true
                                                : false;
                                        setState(() {});
                                      },
                                      icon: Icon(
                                        Icons.remove_red_eye,
                                        color: subColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 90,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  padding: EdgeInsets.all(10),
                                  side: BorderSide(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                  backgroundColor: mainColor,
                                ),
                                onPressed: () {
                                  Navigator.popAndPushNamed(
                                    context,
                                    "/fundWallet",
                                  );
                                },
                                icon: Icon(Icons.add),
                                label: Text("Fund Wallet  "),
                              ),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  padding: EdgeInsets.all(10),
                                  side: BorderSide(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                  backgroundColor: mainColor,
                                ),
                                onPressed: () {
                                  Navigator.popAndPushNamed(
                                    context,
                                    "/transactions",
                                  );
                                },
                                icon: Icon(Icons.history),
                                label: Text("Transactions  "),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Services", style: TextStyle(fontSize: 18)),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: _calculateCrossAxisCount(
                                  context,
                                ),
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
                              [
                                Icons.phone_android,
                                'Airtime',
                                'Instant recharge anytime',
                              ],
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
                              [
                                Icons.school,
                                'Education',
                                'Buy result PIN checker',
                              ],
                              [
                                Icons.more_horiz,
                                'More',
                                'Explore more services',
                              ],
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
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Recent Transactions",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child:
                        transactions.isEmpty
                            ? Center(child: Text("No recent transactions"))
                            : Column(children: recent_tranc()),
                  ),
                ],
              ),
            ],
          ),
          onRefresh: () async {
            final url = Uri.parse("$_url/user/refresh/all_data");
            final headers = {
              "Content-Type": "application/x-www-form-urlencoded",
            };
            final body = {"username": user_data["username"]};
            try {
              final response = await http.post(
                url,
                headers: headers,
                body: body,
              );
              if (response.statusCode == 200) {
                //print("It's Working...");
                var data = jsonDecode(response.body);
                //print(data);
                if (data["status"] == "ok") {
                  var _data = data["data"];
                  user_data = _data["user_data"];
                  if (_data["transactions"].isNotEmpty) {
                    transactions = _data["transactions"];
                  }
                  if (_data["notifications"].isNotEmpty) {
                    notifications = _data["notifications"];
                  }
                  if (user_data["bvn"] != "") {
                    virtual_accounts = _data["vaccounts"];
                  }
                  //Navigator.pop(context);
                  //Navigator.popAndPushNamed(context, "/dashboard");
                  setState(() {});
                } else {
                  //Navigator.pop(context);
                  status("Alert", data["status"]);
                }
              } else {
                //Navigator.pop(context);
                status(
                  "Connection Error",
                  "check your internet connection and try again!",
                );
              }
            } catch (e) {
              //Navigator.pop(context);
              status(
                "Unexpected Error",
                "Could ne not connect, check your internet connection and try again! ${e.toString()}",
              );
            }
          },
        ),
      ),
      onPopInvokedWithResult: (b, t) async {},
    );
  }
}

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: mainColor),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 80,
                          child: Image.asset("assets/images/profile.png"),
                        ),
                        Text(
                          "${user_data['fullname']}",
                          style: TextStyle(
                            color: subColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${user_data['email']}",
                          style: TextStyle(color: subColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.wallet, size: 35),
                  title: Text('Fund Wallet', style: TextStyle(fontSize: 20)),
                  onTap: () {
                    // Navigate to Dashboard
                    Navigator.pop(context);
                    Navigator.popAndPushNamed(context, "/fundWallet");
                    // Close drawer
                  },
                ),
                Divider(thickness: 1),
                SizedBox(height: 5),
                ListTile(
                  leading: Icon(Icons.history, size: 35),
                  title: Text('Transactions', style: TextStyle(fontSize: 20)),
                  onTap: () {
                    // Navigate to Pay Bills
                    Navigator.pop(context); // Close drawer
                    Navigator.popAndPushNamed(context, "/transactions");
                  },
                ),
                Divider(thickness: 1),
                SizedBox(height: 5),
                ListTile(
                  leading: Icon(Icons.notifications, size: 35),
                  title: Text('Notifications', style: TextStyle(fontSize: 20)),
                  onTap: () {
                    // Navigate to Pay Bills
                    Navigator.pop(context); // Close drawer
                    Navigator.popAndPushNamed(context, "/notification");
                  },
                ),
                Divider(thickness: 1),
                SizedBox(height: 5),
                ListTile(
                  leading: Icon(Icons.person, size: 35),
                  title: Text('Profile', style: TextStyle(fontSize: 20)),
                  onTap: () {
                    // Navigate to Usage History
                    Navigator.pop(context);
                    Navigator.popAndPushNamed(
                      context,
                      "/profile",
                    ); // Close drawer
                  },
                ),
                Divider(thickness: 1),
                SizedBox(height: 5),
                ListTile(
                  leading: Icon(Icons.settings, size: 35),
                  title: Text('Settings', style: TextStyle(fontSize: 20)),
                  onTap: () {
                    // Navigate to Account Settings
                    Navigator.pop(context); // Close drawer
                    if (2 == 2) {
                      Navigator.popAndPushNamed(context, "/settings");
                    } else {
                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              content: Text("An unknown error occured!"),
                            ),
                      );
                    }
                  },
                ),
                Divider(thickness: 1),
                SizedBox(height: 5),
                ListTile(
                  leading: Icon(Icons.receipt, size: 35),
                  title: Text('Terms & Policy', style: TextStyle(fontSize: 20)),
                  onTap: () {
                    // Navigate to View Bills
                    Navigator.pop(context);

                    Navigator.popAndPushNamed(context, "/termspolicy");
                  },
                ),
                Divider(thickness: 1),
                SizedBox(height: 5),
                ListTile(
                  leading: Icon(Icons.info, size: 35),
                  title: Text('About Us', style: TextStyle(fontSize: 20)),
                  onTap: () {
                    // Navigate to Usage History
                    Navigator.pop(context); // Close drawer
                    Navigator.popAndPushNamed(context, "/about_us");
                  },
                ),
                Divider(thickness: 1),
                SizedBox(height: 5),
                ListTile(
                  leading: Icon(Icons.logout, size: 35),
                  title: Text('Logout', style: TextStyle(fontSize: 20)),
                  onTap: () {
                    // Add logout functionality
                    Navigator.pop(context); // Close drawer
                    showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            title: Text("Confirm"),
                            content: Text("Are you sure you want to logout?"),
                            actions: [
                              ElevatedButton(
                                onPressed: () async {
                                  dataplans = {};
                                  datatypes = [];
                                  data_plans = [];
                                  networks = {};
                                  exams = {};
                                  electricity = {};
                                  edupins = {};
                                  cable_plans = {};
                                  cable_types = [];
                                  transactions = [];
                                  notifications = [];
                                  virtual_accounts = [];
                                  remember_me = false;
                                  _remember_me = "false";
                                  theme = "default";
                                  mainColor = Color.fromRGBO(82, 101, 140, 1);

                                  subColor = Colors.white;
                                  show_balance = false;
                                  t_index = 0;
                                  biometric = false;
                                  emailnotify = false;
                                  pushnotify = false;
                                  _biometric = "false";
                                  _pushnotify = "false";
                                  _emailnotify = "false";
                                  permission_status = "false";
                                  set_pin = false;
                                  new_pin = "";
                                  conf_pin = "";
                                  pin_status = "";
                                  pin_alert = true;
                                  reg_noti_listener = false;
                                  reg_data_listener = false;
                                  reg_airtime_listener = false;
                                  reg_cable_listener = false;
                                  reg_edu_listener = false;
                                  reg_elec_listener = false;
                                  await storage.write(
                                    key: 'pushnotify',
                                    value: "${pushnotify.toString()}",
                                  );
                                  await storage.write(
                                    key: 'remember_me',
                                    value: "${remember_me.toString()}",
                                  );
                                  await storage.write(
                                    key: 'theme',
                                    value: "${theme.toString()}",
                                  );
                                  await storage.write(
                                    key: 'emailnotify',
                                    value: "${emailnotify.toString()}",
                                  );
                                  await storage.write(
                                    key: 'biometric',
                                    value: "${biometric.toString()}",
                                  );

                                  Navigator.popAndPushNamed(context, "/login");
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: mainColor,
                                ),
                                child: Text("Yes"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: mainColor,
                                ),
                                child: Text("No"),
                              ),
                            ],
                          ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FundWalletPage extends StatefulWidget {
  const FundWalletPage({super.key});

  @override
  State<FundWalletPage> createState() => _FundWalletPageState();
}

class _FundWalletPageState extends State<FundWalletPage> {
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
          title: Text("Fund Wallet"),
          backgroundColor: mainColor,
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              ListTile(
                onTap: (() => Navigator.popAndPushNamed(context, "/bank_fund")),
                title: Text(
                  "Fund with Bank Transfer",
                  style: TextStyle(fontSize: 25),
                ),
                leading: Image.asset("assets/images/bank.png", scale: 10.0),
              ),
              Divider(thickness: 1),
              ListTile(
                onTap: (() => Navigator.popAndPushNamed(context, "/card_fund")),
                title: Text(
                  "Fund with ATM Card",
                  style: TextStyle(fontSize: 25),
                ),
                leading: Image.asset("assets/images/card.png", scale: 10.0),
              ),
              Divider(thickness: 1),
            ],
          ),
        ),
      ),
      onPopInvokedWithResult: (b, t) async {
        Navigator.popAndPushNamed(context, "/dashboard");
      },
    );
  }
}

class TransferFunding extends StatefulWidget {
  const TransferFunding({super.key});

  @override
  State<TransferFunding> createState() => _TransferFundingState();
}

class _TransferFundingState extends State<TransferFunding> {
  TextEditingController amount = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    // Implement some initialization operations here.
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
              children: [Text("Getting virtual accounts, please wait...")],
            ),
          ),
    );
  }

  void get_virtual_accounts() async {
    final url = Uri.parse("$_url/user/create-virtual-account");
    final headers = {"Content-Type": "application/x-www-form-urlencoded"};
    final body = {
      "account_type": "dynamic",
      "username": user_data["username"],
      "amount": amount.text,
    };

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        //print("It's Working...");
        var data = jsonDecode(response.body);
        ////print(data);
        if (data["status"] == "ok") {
          virtual_accounts = data["virtual-accounts"];
          transfer_amount = (int.tryParse(amount.text.toString()))!;
          setState(() {});
          Navigator.pop(context);
        } else {
          Navigator.pop(context);
          status("Alert", data["status"]);
        }
      } else {
        Navigator.pop(context);
        status(
          "Connection Error",
          "check your internet connection and try again!",
        );
      }
    } catch (e) {
      Navigator.pop(context);
      status(
        "Unexpected Error",
        "Could ne not connect, check your internet connection and try again! ${e.toString()}",
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
              Navigator.popAndPushNamed(context, "/fundWallet");
            },
            icon: Icon(Icons.arrow_back),
          ),
          backgroundColor: mainColor,
          title: Text("Transfer Funding"),
        ),
        body: RefreshIndicator(
          child: ListView(
            children: [
              user_data['bvn'] == "" || virtual_accounts.isEmpty
                  ? Padding(
                    padding: EdgeInsets.all(10),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 5),
                          Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              "Get tired of enter transfer amount\n each time you want to get dynamic account? Provide your BVN in the account settings to get your static account number.",
                            ),
                          ),
                          SizedBox(height: 5),
                          TextFormField(
                            controller: amount,
                            keyboardType: TextInputType.phone,
                            maxLength: 11,
                            decoration: InputDecoration(
                              labelText: 'Transfer Amount',
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
                          SizedBox(height: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(10),
                              backgroundColor: mainColor,
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                process();
                                get_virtual_accounts();
                              }
                            },
                            child: Text(
                              "Get Virtual Accounts",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  : SizedBox(),
              for (var account in virtual_accounts)
                (Card(
                  color: mainColor,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${account['bank_name']}",
                          style: TextStyle(
                            color: subColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "${account['account_name']}",
                          style: TextStyle(
                            color: subColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        transfer_amount == 0
                            ? SizedBox()
                            : Text(
                              "Transfer Amount: ${transfer_amount}",
                              style: TextStyle(
                                color: subColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${account['account_number']}",
                              style: TextStyle(
                                color: subColor,
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Clipboard.setData(
                                  ClipboardData(
                                    text: "${account['account_number']}",
                                  ),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Text Copied")),
                                );
                              },
                              icon: Icon(Icons.copy, color: subColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
            ],
          ),
          onRefresh: () async {
            final url = Uri.parse("$_url/user/refresh/vaccounts");
            final headers = {
              "Content-Type": "application/x-www-form-urlencoded",
            };
            final body = {"username": user_data["username"]};
            try {
              final response = await http.post(
                url,
                headers: headers,
                body: body,
              );
              if (response.statusCode == 200) {
                //print("It's Working...");
                var data = jsonDecode(response.body);
                //print(data);
                if (data["status"] == "ok") {
                  var _data = data["data"];
                  user_data = _data["user_data"];
                  if (user_data["bvn"] != "") {
                    virtual_accounts = _data["vaccounts"];
                  }
                  //Navigator.pop(context);
                  //Navigator.popAndPushNamed(context, "/dashboard");
                  setState(() {});
                } else {
                  //Navigator.pop(context);
                  status("Alert", data["status"]);
                }
              } else {
                //Navigator.pop(context);
                status(
                  "Connection Error",
                  "check your internet connection and try again!",
                );
              }
            } catch (e) {
              //Navigator.pop(context);
              status(
                "Unexpected Error",
                "Could ne not connect, check your internet connection and try again! ${e.toString()}",
              );
            }
          },
        ),
      ),
      onPopInvokedWithResult: (b, t) async {
        Navigator.popAndPushNamed(context, "/fundWallet");
      },
    );
  }
}

class CardFundingPage extends StatefulWidget {
  @override
  _CardFundingPageState createState() => _CardFundingPageState();
}

class _CardFundingPageState extends State<CardFundingPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController cardNumber = TextEditingController();
  TextEditingController expiryDate = TextEditingController();
  TextEditingController cvv = TextEditingController();
  TextEditingController cardHolderName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, "/fundWallet");
            },
            icon: Icon(Icons.arrow_back),
          ),
          backgroundColor: mainColor,
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
                      borderSide: BorderSide(color: mainColor),
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
                            borderSide: BorderSide(color: mainColor),
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
                            borderSide: BorderSide(color: mainColor),
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
                      borderSide: BorderSide(color: mainColor),
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
                                  Icon(Icons.check_circle, color: Colors.green),
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
                      backgroundColor: mainColor,
                      padding: EdgeInsets.all(20),
                    ),
                    child: Text("Proceed", style: TextStyle(fontSize: 25)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onPopInvokedWithResult: (b, t) async {
        Navigator.popAndPushNamed(context, "/fundWallet");
      },
    );
  }
}

class BuyDataPage extends StatefulWidget {
  const BuyDataPage({super.key});

  @override
  State<BuyDataPage> createState() => _BuyDataPageState();
}

class _BuyDataPageState extends State<BuyDataPage> {
  TextEditingController number = TextEditingController();
  TextEditingController pin1 = TextEditingController();
  TextEditingController pin2 = TextEditingController();
  TextEditingController pin3 = TextEditingController();
  TextEditingController pin4 = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FocusNode pin_1 = FocusNode();
  final FocusNode pin_2 = FocusNode();
  final FocusNode pin_3 = FocusNode();
  final FocusNode pin_4 = FocusNode();

  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _isAuthenticated = false;
  var pin_title = "Enter your pin";
  var network = "";
  var datatype = "";
  var dataplan = {};

  Future<void> biametric_authentication() async {
    try {
      bool isBiometricSupported = await _localAuth.isDeviceSupported();
      if (!isBiometricSupported) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Warning!"),
              content: Text(
                "Biometric authentication is not supported on this device!",
              ),
            );
          },
        );
        //print("Error 1");
        return;
      }
      bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
      if (!canCheckBiometrics) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Warning!"),
              content: Text("No biometric features are available!"),
            );
          },
        );
        //print("Error 2");
        return;
      }

      _isAuthenticated = await _localAuth.authenticate(
        localizedReason: 'Authenticate with your fingerprint',
        options: const AuthenticationOptions(
          useErrorDialogs: false,
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
      if (_isAuthenticated) {
        process();
        make_transaction();
      } else {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Warning!"),
              content: Text("Fingerprint not recognized!"),
            );
          },
        );
      }
      setState(() {});
    } catch (e) {
      //print(e.toString());
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Warning!"),
            content: Text("An unexpected error occured! ${e.toString()}"),
          );
        },
      );
    }
  }

  void status(var status) {
    Navigator.popAndPushNamed(context, "/dashboard");
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

  void make_transaction() async {
    final url = Uri.parse("$_url/user/make-purchase");
    final headers = {"Content-Type": "application/x-www-form-urlencoded"};
    final body = {
      "service": "data",
      "username": user_data["username"].toString(),
      "data_id": dataplan['id'].toString(),
      "number": number.text.toString(),
    };
    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        //print("It's Working...");
        var data = jsonDecode(response.body);
        ////print(data);
        if (data["status"] == "success") {
          user_data["wallet_bal"] = data["wallet_bal"];
          transactions = data["transactions"];

          setState(() {});
          //Navigator.pop(context);
          //Navigator.popAndPushNamed(context, "/dashboard");
          status(data["status"]);
        } else {
          //print("It's Working...2");
          data["wallet_bal"] ?? "0.0";
          if (data["transactions"] != null) {
            transactions = data["transactions"];
          } else {
            transactions = transactions;
          }
          setState(() {});
          status(data["status"]);
        }
      } else {
        Navigator.pop(context);
        status("Check your internet connection and try again!");
      }
    } catch (e) {
      Navigator.pop(context);
      status(
        "Could not connect, check your internet connection and try again! ${e.toString()}",
      );
    }
  }

  void enterPin(var pin) {
    if (pin1.text.isEmpty) {
      pin1.text = pin.toString();
    } else if (pin2.text.isEmpty) {
      pin2.text = pin.toString();
    } else if (pin3.text.isEmpty) {
      pin3.text = pin.toString();
    } else {
      pin4.text = pin.toString();
      var _pin = "${pin1.text}${pin2.text}${pin3.text}${pin4.text}";
      pin1.text = "";
      pin2.text = "";
      pin3.text = "";
      pin4.text = "";
      if (_pin == user_data["t_pin"]) {
        process();
        make_transaction();
      } else {
        Vibrate.vibrate();
        Navigator.pop(context);
        showDialog(
          context: context,
          builder:
              (context) =>
                  AlertDialog(content: Text("Incorrect pin, try again.")),
        );
      }
    }
  }

  void deletePin() {
    if (pin4.text.isNotEmpty) {
      pin4.text = "";
    } else if (pin3.text.isNotEmpty) {
      pin3.text = "";
    } else if (pin2.text.isNotEmpty) {
      pin2.text = "";
    } else {
      pin1.text = "";
    }
  }

  void showBottomDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Enter confrimation pin"),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      readOnly: true,
                      obscureText: true,
                      obscuringCharacter: "⓿",
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: pin1,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      readOnly: true,
                      obscureText: true,
                      obscuringCharacter: "⓿",
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: pin2,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      readOnly: true,
                      obscureText: true,
                      obscuringCharacter: "⓿",
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: pin3,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      readOnly: true,
                      obscureText: true,
                      obscuringCharacter: "⓿",
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: pin4,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      enterPin(1);
                    },
                    child: Text(
                      "1",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(2);
                    },
                    child: Text(
                      "2",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(3);
                    },
                    child: Text(
                      "3",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      enterPin(4);
                    },
                    child: Text(
                      "4",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(5);
                    },
                    child: Text(
                      "5",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(6);
                    },
                    child: Text(
                      "6",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      enterPin(7);
                    },
                    child: Text(
                      "7",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(8);
                    },
                    child: Text(
                      "8",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(9);
                    },
                    child: Text(
                      "9",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      if (biometric) {
                        biametric_authentication();
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Warning"),
                              content: Text(
                                "Enable biometric in the app settings to use biometric for authentication.",
                              ),
                            );
                          },
                        );
                      }
                    },
                    icon: Icon(Icons.fingerprint, size: 28, color: mainColor),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(0);
                    },
                    child: Text(
                      "0",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      deletePin();
                    },
                    icon: Icon(Icons.backspace, color: mainColor),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (reg_data_listener == false) {
      socket.on('data', (data) {
        //print(data);
        Navigator.pop(context);
        status(data["status"]);
      });
      reg_data_listener = true;
    }
    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              data_plans = [];
              Navigator.popAndPushNamed(context, "/dashboard");
            },
            icon: Icon(Icons.arrow_back),
          ),
          backgroundColor: mainColor,
          title: Text("Data"),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: mainColor),
                    ),
                    border: OutlineInputBorder(),
                  ),
                  hint: Text(
                    network == ""
                        ? "Choose Network"
                        : networks[network].toString(),
                    style: TextStyle(color: mainColor),
                  ),
                  items: [
                    for (var network in networks.keys)
                      (DropdownMenuItem(
                        value: network,
                        child: Text("${networks[network]}"),
                      )),
                  ],
                  validator: (value) {
                    if (value == null) {
                      return 'All field required';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      data_plans = [];
                      network = value.toString();
                      if (datatype != "") {
                        //print(network);
                        //print(datatype);
                        if (dataplans[network].containsKey(value.toString())) {
                          setState(() {
                            datatype = value.toString();
                            data_plans = dataplans["$network"][datatype];
                          });
                        } else {
                          setState(() {
                            data_plans = [];
                          });
                          showDialog(
                            context: context,
                            builder:
                                (context) => AlertDialog(
                                  content: Text(
                                    "No Data type: $datatype on this network!",
                                  ),
                                ),
                          );
                        }
                      }
                    });
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: number,
                  keyboardType: TextInputType.phone,
                  maxLength: 11,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
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
                SizedBox(height: 10),
                network != ""
                    ? DropdownButtonFormField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      hint: Text(
                        "Choose Data Type",
                        style: TextStyle(color: mainColor),
                      ),
                      items: [
                        for (var _datatype in datatypes)
                          (DropdownMenuItem(
                            value: _datatype,
                            child: Text(_datatype),
                          )),
                      ],
                      validator: (value) {
                        if (value == null) {
                          return 'All field required';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (dataplans["$network"].containsKey(value)) {
                          setState(() {
                            datatype = value.toString();
                            data_plans = dataplans["$network"][datatype];
                          });
                        } else {
                          setState(() {
                            data_plans = [];
                            network = "";
                          });
                          showDialog(
                            context: context,
                            builder:
                                (context) => AlertDialog(
                                  content: Text(
                                    "No Data type: $value on this network!",
                                  ),
                                ),
                          );
                        }
                      },
                    )
                    : SizedBox(),
                SizedBox(height: 10),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: mainColor),
                    ),
                    border: OutlineInputBorder(),
                  ),
                  hint: Text(
                    dataplan.isEmpty
                        ? "Choose Plan"
                        : "${dataplan['plan']} ${dataplan['validate']} ${dataplan['sale_price']}",
                    style: TextStyle(color: mainColor),
                  ),
                  items: [
                    for (int i in List.generate(
                      data_plans.length,
                      (index) => index,
                      growable: false,
                    ))
                      (DropdownMenuItem(
                        value: i,
                        child: Text(
                          "${data_plans[i]['plan']} ${data_plans[i]['validate']} ${data_plans[i]['sale_price']}",
                        ),
                      )),
                  ],
                  validator: (value) {
                    if (value == null) {
                      return 'All field required';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    var i = int.tryParse(value.toString());
                    setState(() {
                      dataplan = data_plans[i!];
                    });
                    //print(dataplan);
                  },
                ),
                SizedBox(height: 10),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(25),
                    backgroundColor: mainColor,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showBottomDrawer(context);
                    }
                  },
                  child: Text("Pay", style: TextStyle(fontSize: 30)),
                ),
              ],
            ),
          ),
        ),
      ),
      onPopInvokedWithResult: (b, t) async {
        Navigator.popAndPushNamed(context, "/dashboard");
      },
    );
  }
}

class BuyAirtimePage extends StatefulWidget {
  const BuyAirtimePage({super.key});

  @override
  State<BuyAirtimePage> createState() => _BuyAirtimePageState();
}

class _BuyAirtimePageState extends State<BuyAirtimePage> {
  TextEditingController number = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController pin1 = TextEditingController();
  TextEditingController pin2 = TextEditingController();
  TextEditingController pin3 = TextEditingController();
  TextEditingController pin4 = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _isAuthenticated = false;

  final FocusNode pin_1 = FocusNode();
  final FocusNode pin_2 = FocusNode();
  final FocusNode pin_3 = FocusNode();
  final FocusNode pin_4 = FocusNode();

  var provider = "none";
  var airtimetype = "none";
  var network = "";

  var airtimetypes = {
    "none": "Choose Airtime Type",
    "vtu": "VTU",
    "sns": "SHARE AND SELL",
  };

  Future<void> biametric_authentication() async {
    try {
      bool isBiometricSupported = await _localAuth.isDeviceSupported();
      if (!isBiometricSupported) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Warning!"),
              content: Text(
                "Biometric authentication is not supported on this device!",
              ),
            );
          },
        );
        //print("Error 1");
        return;
      }
      bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
      if (!canCheckBiometrics) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Warning!"),
              content: Text("No biometric features are available!"),
            );
          },
        );
        //print("Error 2");
        return;
      }

      _isAuthenticated = await _localAuth.authenticate(
        localizedReason: 'Authenticate with your fingerprint',
        options: const AuthenticationOptions(
          useErrorDialogs: false,
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
      if (_isAuthenticated) {
        process();
        make_transaction();
      } else {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Warning!"),
              content: Text("Fingerprint not recognized!"),
            );
          },
        );
      }
      setState(() {});
    } catch (e) {
      //print(e.toString());
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Warning!"),
            content: Text("An unexpected error occured!"),
          );
        },
      );
    }
  }

  void status(var status) {
    Navigator.popAndPushNamed(context, "/dashboard");
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

  void make_transaction() async {
    final url = Uri.parse("$_url/user/make-purchase");
    final headers = {"Content-Type": "application/x-www-form-urlencoded"};
    final body = {
      "service": "airtime",
      "network": network,
      "username": user_data["username"].toString(),
      "airtime_type": airtimetype.toString(),
      "number": number.text.toString(),
      "amount": amount.text.toString(),
    };
    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        //print("It's Working...");
        var data = jsonDecode(response.body);
        ////print(data);
        if (data["status"] == "success") {
          user_data["wallet_bal"] = data["wallet_bal"];
          transactions = data["transactions"];
          setState(() {});
          //Navigator.pop(context);
          //Navigator.popAndPushNamed(context, "/dashboard");
          status(data["status"]);
        } else {
          if (data["wallet_bal"] != null) {
            user_data["wallet_bal"] = data["wallet_bal"];
          } else {
            user_data["wallet_bal"] = "0.0";
          }
          if (data["transactions"] != null) {
            transactions = data["transactions"];
          } else {
            transactions = transactions;
          }
          setState(() {});
          status(data["status"]);
        }
      } else {
        Navigator.pop(context);
        status("Check your internet connection and try again!");
      }
    } catch (e) {
      Navigator.pop(context);
      status(
        "Could not connect, check your internet connection and try again! ${e.toString()}",
      );
    }
  }

  void process() {
    //print("${pin1.text} ${pin2.text} ${pin3.text} ${pin4.text}");
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
  }

  void enterPin(var pin) {
    if (pin1.text.isEmpty) {
      pin1.text = pin.toString();
    } else if (pin2.text.isEmpty) {
      pin2.text = pin.toString();
    } else if (pin3.text.isEmpty) {
      pin3.text = pin.toString();
    } else {
      pin4.text = pin.toString();
      var _pin = "${pin1.text}${pin2.text}${pin3.text}${pin4.text}";
      pin1.text = "";
      pin2.text = "";
      pin3.text = "";
      pin4.text = "";
      if (_pin == user_data["t_pin"]) {
        process();
        make_transaction();
      } else {
        Vibrate.vibrate();
        Navigator.pop(context);
        showDialog(
          context: context,
          builder:
              (context) =>
                  AlertDialog(content: Text("Incorrect pin, try again.")),
        );
      }
    }
  }

  void deletePin() {
    if (pin4.text.isNotEmpty) {
      pin4.text = "";
    } else if (pin3.text.isNotEmpty) {
      pin3.text = "";
    } else if (pin2.text.isNotEmpty) {
      pin2.text = "";
    } else {
      pin1.text = "";
    }
  }

  void showBottomDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Enter Pin"),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      readOnly: true,
                      obscureText: true,
                      obscuringCharacter: "⓿",
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: pin1,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      readOnly: true,
                      obscureText: true,
                      obscuringCharacter: "⓿",
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: pin2,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      readOnly: true,
                      obscureText: true,
                      obscuringCharacter: "⓿",
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: pin3,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      readOnly: true,
                      obscureText: true,
                      obscuringCharacter: "⓿",
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: pin4,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      enterPin(1);
                    },
                    child: Text(
                      "1",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(2);
                    },
                    child: Text(
                      "2",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(3);
                    },
                    child: Text(
                      "3",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      enterPin(4);
                    },
                    child: Text(
                      "4",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(5);
                    },
                    child: Text(
                      "5",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(6);
                    },
                    child: Text(
                      "6",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      enterPin(7);
                    },
                    child: Text(
                      "7",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(8);
                    },
                    child: Text(
                      "8",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(9);
                    },
                    child: Text(
                      "9",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      if (biometric) {
                        biametric_authentication();
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Warning"),
                              content: Text(
                                "Enable biometric in the app settings to use biometric for authentication.",
                              ),
                            );
                          },
                        );
                      }
                    },
                    icon: Icon(Icons.fingerprint, size: 28, color: mainColor),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(0);
                    },
                    child: Text(
                      "0",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      deletePin();
                    },
                    icon: Icon(Icons.backspace, color: mainColor),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (reg_airtime_listener == false) {
      socket.on('airtime', (data) {
        //print(data);
        Navigator.pop(context);
        status(data["status"]);
      });
      reg_airtime_listener = true;
    }
    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, "/dashboard");
            },
            icon: Icon(Icons.arrow_back),
          ),
          backgroundColor: mainColor,
          title: Text("Airtime"),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: mainColor),
                    ),
                    border: OutlineInputBorder(),
                  ),
                  hint: Text(
                    network == ""
                        ? "Choose Network"
                        : networks[network].toString(),
                    style: TextStyle(color: mainColor),
                  ),
                  items: [
                    for (var network in networks.keys)
                      (DropdownMenuItem(
                        value: network,
                        child: Text("${networks[network]}"),
                      )),
                  ],
                  validator: (value) {
                    if (value == null) {
                      return 'All field required';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      network = value.toString();
                    });
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: number,
                  keyboardType: TextInputType.phone,
                  maxLength: 11,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
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
                SizedBox(height: 10),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: mainColor),
                    ),
                    border: OutlineInputBorder(),
                  ),
                  hint: Text(
                    airtimetypes[airtimetype].toString(),
                    style: TextStyle(color: mainColor),
                  ),
                  items: [
                    DropdownMenuItem(value: "vtu", child: Text("VTU")),
                    DropdownMenuItem(value: "sns", child: Text("SHARE N SELL")),
                  ],
                  validator: (value) {
                    if (value == null) {
                      return 'All field required';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      airtimetype = (airtimetypes[value.toString()])!;
                    });
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: amount,
                  keyboardType: TextInputType.phone,
                  maxLength: 11,
                  decoration: InputDecoration(
                    labelText: 'Amount',
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
                SizedBox(height: 10),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(25),
                    backgroundColor: mainColor,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showBottomDrawer(context);
                    }
                  },
                  child: Text("Pay", style: TextStyle(fontSize: 30)),
                ),
              ],
            ),
          ),
        ),
      ),
      onPopInvokedWithResult: (b, t) async {
        Navigator.popAndPushNamed(context, "/dashboard");
      },
    );
  }
}

class BuyEduPinPage extends StatefulWidget {
  const BuyEduPinPage({super.key});

  @override
  State<BuyEduPinPage> createState() => _BuyEduPinPageState();
}

class _BuyEduPinPageState extends State<BuyEduPinPage> {
  TextEditingController number = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController pin1 = TextEditingController();
  TextEditingController pin2 = TextEditingController();
  TextEditingController pin3 = TextEditingController();
  TextEditingController pin4 = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _isAuthenticated = false;

  final FocusNode pin_1 = FocusNode();
  final FocusNode pin_2 = FocusNode();
  final FocusNode pin_3 = FocusNode();
  final FocusNode pin_4 = FocusNode();

  var exam = "none";
  var quatity = "none";

  var quantities = {
    "none": "Choose Quantity",
    "1": "1 Quantity",
    "2": "2 Quantities",
    "3": "4 Quantities",
    "4": "5 Quantities",
    "5": "9 Quantities",
  };

  Future<void> biametric_authentication() async {
    try {
      bool isBiometricSupported = await _localAuth.isDeviceSupported();
      if (!isBiometricSupported) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Warning!"),
              content: Text(
                "Biometric authentication is not supported on this device!",
              ),
            );
          },
        );
        //print("Error 1");
        return;
      }
      bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
      if (!canCheckBiometrics) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Warning!"),
              content: Text("No biometric features are available!"),
            );
          },
        );
        //print("Error 2");
        return;
      }

      _isAuthenticated = await _localAuth.authenticate(
        localizedReason: 'Authenticate with your fingerprint',
        options: const AuthenticationOptions(
          useErrorDialogs: false,
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
      if (_isAuthenticated) {
        status("success");
      } else {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Warning!"),
              content: Text("Fingerprint not recognized!"),
            );
          },
        );
      }
      setState(() {});
    } catch (e) {
      //print(e.toString());
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Warning!"),
            content: Text("An unexpected error occured!"),
          );
        },
      );
    }
  }

  void status(var status) {
    Navigator.popAndPushNamed(context, "/dashboard");
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
                    color: Colors.green,
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
                    color: Colors.orange,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        } else {
          return AlertDialog(
            title: Icon(Icons.warning_rounded, color: Colors.red, size: 50),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Transaction Failed!",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  void process() {
    //print("${pin1.text} ${pin2.text} ${pin3.text} ${pin4.text}");
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
  }

  void enterPin(var pin) {
    if (pin1.text.isEmpty) {
      pin1.text = pin.toString();
    } else if (pin2.text.isEmpty) {
      pin2.text = pin.toString();
    } else if (pin3.text.isEmpty) {
      pin3.text = pin.toString();
    } else {
      pin4.text = pin.toString();
      var _pin = "${pin1.text}${pin2.text}${pin3.text}${pin4.text}";
      pin1.text = "";
      pin2.text = "";
      pin3.text = "";
      pin4.text = "";
      if (_pin == user_data["t_pin"]) {
        process();
      } else {
        Vibrate.vibrate();
        Navigator.pop(context);
        showDialog(
          context: context,
          builder:
              (context) =>
                  AlertDialog(content: Text("Incorrect pin, try again.")),
        );
      }
    }
  }

  void deletePin() {
    if (pin4.text.isNotEmpty) {
      pin4.text = "";
    } else if (pin3.text.isNotEmpty) {
      pin3.text = "";
    } else if (pin2.text.isNotEmpty) {
      pin2.text = "";
    } else {
      pin1.text = "";
    }
  }

  void showBottomDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Enter Pin"),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      readOnly: true,
                      obscureText: true,
                      obscuringCharacter: "⓿",
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: pin1,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
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
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      readOnly: true,
                      obscureText: true,
                      obscuringCharacter: "⓿",
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: pin2,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      readOnly: true,
                      obscureText: true,
                      obscuringCharacter: "⓿",
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: pin3,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      readOnly: true,
                      obscureText: true,
                      obscuringCharacter: "⓿",
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: pin4,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      enterPin(1);
                    },
                    child: Text(
                      "1",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(2);
                    },
                    child: Text(
                      "2",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(3);
                    },
                    child: Text(
                      "3",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      enterPin(4);
                    },
                    child: Text(
                      "4",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(5);
                    },
                    child: Text(
                      "5",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(6);
                    },
                    child: Text(
                      "6",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      enterPin(7);
                    },
                    child: Text(
                      "7",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(8);
                    },
                    child: Text(
                      "8",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(9);
                    },
                    child: Text(
                      "9",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      if (biometric) {
                        biametric_authentication();
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Warning"),
                              content: Text(
                                "Enable biometric in the app settings to use biometric for authentication.",
                              ),
                            );
                          },
                        );
                      }
                    },
                    icon: Icon(Icons.fingerprint, size: 28, color: mainColor),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(0);
                    },
                    child: Text(
                      "0",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      deletePin();
                    },
                    icon: Icon(Icons.backspace, color: mainColor),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (reg_edu_listener == false) {
      socket.on('edupin', (data) {
        //print(data);
        try {
          Navigator.pop(context);
          status(data["status"]);
        } catch (e) {
          //print("Error");
        }
      });
      reg_edu_listener = true;
    }
    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, "/dashboard");
            },
            icon: Icon(Icons.arrow_back),
          ),
          backgroundColor: mainColor,
          title: Text("Edu Pin"),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: mainColor),
                    ),
                    border: OutlineInputBorder(),
                  ),
                  hint: Text(
                    exam == "none"
                        ? "Choose Exam Type"
                        : exams[exam].toString(),
                    style: TextStyle(color: mainColor),
                  ),
                  items: [
                    for (var exam in exams.keys)
                      (DropdownMenuItem(
                        value: exam,
                        child: Text(exam.toString()),
                      )),
                  ],
                  validator: (value) {
                    if (value == null) {
                      return 'All field required';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      exam = value.toString();
                      if (quatity != "") {
                        var a = exams[exam].toString();
                        var total = (int.tryParse(a)! * int.tryParse(quatity)!);

                        amount.text = total.toString();
                      }
                    });
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: number,
                  keyboardType: TextInputType.phone,
                  maxLength: 11,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
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
                SizedBox(height: 10),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: mainColor),
                    ),
                    border: OutlineInputBorder(),
                  ),
                  hint: Text(
                    quantities[quatity].toString(),
                    style: TextStyle(color: mainColor),
                  ),
                  items: [
                    for (var i in quantities.keys)
                      (DropdownMenuItem(
                        value: i,
                        child: Text(quantities[i].toString()),
                      )),
                  ],
                  validator: (value) {
                    if (value == null) {
                      return 'All field required';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      quatity = value.toString();
                      var a = exams[exam].toString();
                      var total = (int.tryParse(a)! * int.tryParse(quatity)!);

                      amount.text = total.toString();
                    });
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  readOnly: true,
                  controller: amount,
                  keyboardType: TextInputType.phone,
                  maxLength: 11,
                  decoration: InputDecoration(
                    labelText: 'Amount',
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
                SizedBox(height: 10),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(25),
                    backgroundColor: mainColor,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showBottomDrawer(context);
                    }
                  },
                  child: Text("Pay", style: TextStyle(fontSize: 30)),
                ),
              ],
            ),
          ),
        ),
      ),
      onPopInvokedWithResult: (b, t) async {
        Navigator.popAndPushNamed(context, "/dashboard");
      },
    );
  }
}

class BuyElectricityPage extends StatefulWidget {
  const BuyElectricityPage({super.key});

  @override
  State<BuyElectricityPage> createState() => _BuyElectricityPageState();
}

class _BuyElectricityPageState extends State<BuyElectricityPage> {
  TextEditingController number = TextEditingController();
  TextEditingController meter = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController pin1 = TextEditingController();
  TextEditingController pin2 = TextEditingController();
  TextEditingController pin3 = TextEditingController();
  TextEditingController pin4 = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _isAuthenticated = false;

  final FocusNode pin_1 = FocusNode();
  final FocusNode pin_2 = FocusNode();
  final FocusNode pin_3 = FocusNode();
  final FocusNode pin_4 = FocusNode();

  var disco_name = "none";
  int disco_id = 0;
  var metertype = "";
  var check_meter = false;
  var meter_data = "";

  var providers = {
    "none": "Select Disco Provider",
    "1": "Kano Electric",
    "2": "Aba Electric",
    "3": "Benin Electric",
    "4": "Eko Electric",
    "5": "Enugu Electric",
    "6": "Ibandan Electric",
    "7": "Ikeja Electric",
    "8": "Jos Electric",
    "9": "Kaduna Electric",
    "10": "Kano Electric",
    "11": "Port Harcourt Electric",
    "12": "Yola Electric",
  };
  var metertypes = {
    "none": "Choose Meter Type",
    "1": "prepaid",
    "2": "postpaid",
  };
  void _status(var _title, var status) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(title: Text(_title), content: Text(status)),
    );
  }

  void validateMeterNumber() async {
    //print("am here");
    int m = (int.tryParse(meter.text))!;
    final url = Uri.parse(
      "https://postranet.com/api/validatemeter?meternumber=$m&disconame=$disco_name&mtype=$metertype",
    );
    final headers = {"Content-Type": "application/json"};
    try {
      //print("am here1");
      final response = await http.get(url, headers: headers);
      //print("am here2");
      if (response.statusCode == 200) {
        //print("It's Working...");
        var data = jsonDecode(response.body);

        //print("am here3");
        check_meter = false;
        meter_data = data["name"].toString();
        setState(() {});
      } else {
        //print("am here5");
        check_meter = false;
        meter_data = "Could not fetch data, try again.";
        setState(() {});
      }
    } catch (e) {
      //print("am here6");
      check_meter = false;
      meter_data = "Could not fetch data, try again.";
      setState(() {});
    }
  }

  Future<void> biametric_authentication() async {
    try {
      bool isBiometricSupported = await _localAuth.isDeviceSupported();
      if (!isBiometricSupported) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Warning!"),
              content: Text(
                "Biometric authentication is not supported on this device!",
              ),
            );
          },
        );
        //print("Error 1");
        return;
      }
      bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
      if (!canCheckBiometrics) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Warning!"),
              content: Text("No biometric features are available!"),
            );
          },
        );
        //print("Error 2");
        return;
      }

      _isAuthenticated = await _localAuth.authenticate(
        localizedReason: 'Authenticate with your fingerprint',
        options: const AuthenticationOptions(
          useErrorDialogs: false,
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
      if (_isAuthenticated) {
        status("success");
      } else {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Warning!"),
              content: Text("Fingerprint not recognized!"),
            );
          },
        );
      }
      setState(() {});
    } catch (e) {
      //print(e.toString());
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Warning!"),
            content: Text("An unexpected error occured!"),
          );
        },
      );
    }
  }

  void status(var status) {
    Navigator.popAndPushNamed(context, "/dashboard");
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
                    color: Colors.green,
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
                    color: Colors.orange,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        } else {
          return AlertDialog(
            title: Icon(Icons.warning_rounded, color: Colors.red, size: 50),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Transaction Failed!",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  void process() {
    //print("${pin1.text} ${pin2.text} ${pin3.text} ${pin4.text}");
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
  }

  void enterPin(var pin) {
    if (pin1.text.isEmpty) {
      pin1.text = pin.toString();
    } else if (pin2.text.isEmpty) {
      pin2.text = pin.toString();
    } else if (pin3.text.isEmpty) {
      pin3.text = pin.toString();
    } else {
      pin4.text = pin.toString();
      var _pin = "${pin1.text}${pin2.text}${pin3.text}${pin4.text}";
      pin1.text = "";
      pin2.text = "";
      pin3.text = "";
      pin4.text = "";
      if (_pin == user_data["t_pin"]) {
        process();
      } else {
        Vibrate.vibrate();
        Navigator.pop(context);
        showDialog(
          context: context,
          builder:
              (context) =>
                  AlertDialog(content: Text("Incorrect pin, try again.")),
        );
      }
    }
  }

  void deletePin() {
    if (pin4.text.isNotEmpty) {
      pin4.text = "";
    } else if (pin3.text.isNotEmpty) {
      pin3.text = "";
    } else if (pin2.text.isNotEmpty) {
      pin2.text = "";
    } else {
      pin1.text = "";
    }
  }

  void showBottomDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Enter Pin"),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      readOnly: true,
                      obscureText: true,
                      obscuringCharacter: "⓿",
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: pin1,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      readOnly: true,
                      obscureText: true,
                      obscuringCharacter: "⓿",
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: pin2,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      readOnly: true,
                      obscureText: true,
                      obscuringCharacter: "⓿",
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: pin3,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      readOnly: true,
                      obscureText: true,
                      obscuringCharacter: "⓿",
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: pin4,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      enterPin(1);
                    },
                    child: Text(
                      "1",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(2);
                    },
                    child: Text(
                      "2",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(3);
                    },
                    child: Text(
                      "3",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      enterPin(4);
                    },
                    child: Text(
                      "4",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(5);
                    },
                    child: Text(
                      "5",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(6);
                    },
                    child: Text(
                      "6",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      enterPin(7);
                    },
                    child: Text(
                      "7",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(8);
                    },
                    child: Text(
                      "8",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(9);
                    },
                    child: Text(
                      "9",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      if (biometric) {
                        biametric_authentication();
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Warning"),
                              content: Text(
                                "Enable biometric in the app settings to use biometric for authentication.",
                              ),
                            );
                          },
                        );
                      }
                    },
                    icon: Icon(Icons.fingerprint, size: 28, color: mainColor),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(0);
                    },
                    child: Text(
                      "0",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      deletePin();
                    },
                    icon: Icon(Icons.backspace, color: mainColor),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (reg_elec_listener == false) {
      socket.on('electricity', (data) {
        //print(data);
        try {
          Navigator.pop(context);
          status(data["status"]);
        } catch (e) {
          //print("Error");
        }
      });
      reg_elec_listener = true;
    }
    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, "/dashboard");
            },
            icon: Icon(Icons.arrow_back),
          ),
          backgroundColor: mainColor,
          title: Text("Electricity"),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: mainColor),
                    ),
                    border: OutlineInputBorder(),
                  ),
                  hint: Text(
                    disco_name == "none"
                        ? "Choose Disco Name"
                        : disco_name.toString(),
                    style: TextStyle(color: mainColor),
                  ),
                  items: [
                    for (var i in electricity.keys)
                      (DropdownMenuItem(
                        value: i,
                        child: Text(electricity[i].toString()),
                      )),
                  ],
                  validator: (value) {
                    if (value == null) {
                      return 'All field required';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      disco_name = electricity[value.toString()];
                      disco_id = (int.tryParse(value.toString()))!;
                    });
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: number,
                  keyboardType: TextInputType.phone,
                  maxLength: 11,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
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
                SizedBox(height: 10),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: mainColor),
                    ),
                    border: OutlineInputBorder(),
                  ),
                  hint: Text(
                    metertype == ""
                        ? "Choose Meter type"
                        : metertypes[metertype].toString(),
                    style: TextStyle(color: mainColor),
                  ),
                  items: [
                    DropdownMenuItem(value: "1", child: Text("PREPAID")),
                    DropdownMenuItem(value: "2", child: Text("POSTPAID")),
                  ],
                  validator: (value) {
                    if (value == null) {
                      return 'All field required';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      metertype = (metertypes[value.toString()])!;
                    });
                  },
                ),
                SizedBox(height: 10),
                check_meter
                    ? Row(
                      children: [
                        Image.asset("assets/images/loading.gif", scale: 25.0),
                        Text(
                          "Validating...",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                    : meter_data == "Could not fetch data, try again."
                    ? Text(
                      "$meter_data",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                    : meter_data != ""
                    ? Text(
                      "$meter_data".toUpperCase(),
                      style: TextStyle(
                        color:
                            meter_data == "INVALID METER NUMBER"
                                ? Colors.red
                                : Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                    : SizedBox(height: 0.01),
                TextFormField(
                  controller: meter,
                  keyboardType: TextInputType.phone,
                  maxLength: 11,
                  readOnly: check_meter,
                  decoration: InputDecoration(
                    labelText: 'Meter Number',
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
                  onChanged: (value) {
                    if (value.length == 11) {
                      setState(() {
                        check_meter = true;
                      });
                      validateMeterNumber();
                    } else {
                      setState(() {
                        meter_data = "";
                      });
                    }
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: amount,
                  keyboardType: TextInputType.phone,
                  maxLength: 11,
                  decoration: InputDecoration(
                    labelText: 'Amount',
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
                SizedBox(height: 10),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(25),
                    backgroundColor: mainColor,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        int.tryParse(amount.text.toString())! >= 500) {
                      showBottomDrawer(context);
                    } else {
                      _status(
                        "Amount Error",
                        "The amount must not be less than N500",
                      );
                    }
                  },
                  child: Text("Pay", style: TextStyle(fontSize: 30)),
                ),
              ],
            ),
          ),
        ),
      ),
      onPopInvokedWithResult: (b, t) async {
        Navigator.popAndPushNamed(context, "/dashboard");
      },
    );
  }
}

class BuyCablePage extends StatefulWidget {
  const BuyCablePage({super.key});

  @override
  State<BuyCablePage> createState() => _BuyCablePageState();
}

class _BuyCablePageState extends State<BuyCablePage> {
  TextEditingController number = TextEditingController();
  TextEditingController iuc_number = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController pin1 = TextEditingController();
  TextEditingController pin2 = TextEditingController();
  TextEditingController pin3 = TextEditingController();
  TextEditingController pin4 = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _isAuthenticated = false;

  final FocusNode pin_1 = FocusNode();
  final FocusNode pin_2 = FocusNode();
  final FocusNode pin_3 = FocusNode();
  final FocusNode pin_4 = FocusNode();

  var cable = "none";
  var cable_plan = {};
  bool check_iuc = false;
  var iuc_data = "";

  void validateMeterNumber() async {
    //print("am here");
    int iuc = (int.tryParse(iuc_number.text))!;
    final url = Uri.parse(
      "https://postranet.com/api/validateiuc?smart_card_number=$iuc&cablename=${cable.toUpperCase()}",
    );
    final headers = {"Content-Type": "application/json"};
    try {
      //print("am here1");
      final response = await http.get(url, headers: headers);
      //print("am here2");
      if (response.statusCode == 200) {
        //print("It's Working...");
        var data = jsonDecode(response.body);

        //print("am here3");
        check_iuc = false;
        iuc_data = data["name"].toString();
        setState(() {});
      } else {
        //print("am here5");
        check_iuc = false;
        iuc_data = "Could not fetch data, try again.";
        setState(() {});
      }
    } catch (e) {
      //print("am here6");
      check_iuc = false;
      iuc_data = "Could not fetch data, try again.";
      setState(() {});
    }
  }

  Future<void> biametric_authentication() async {
    try {
      bool isBiometricSupported = await _localAuth.isDeviceSupported();
      if (!isBiometricSupported) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Warning!"),
              content: Text(
                "Biometric authentication is not supported on this device!",
              ),
            );
          },
        );
        //print("Error 1");
        return;
      }
      bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
      if (!canCheckBiometrics) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Warning!"),
              content: Text("No biometric features are available!"),
            );
          },
        );
        //print("Error 2");
        return;
      }

      _isAuthenticated = await _localAuth.authenticate(
        localizedReason: 'Authenticate with your fingerprint',
        options: const AuthenticationOptions(
          useErrorDialogs: false,
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
      if (_isAuthenticated) {
        status("success");
      } else {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Warning!"),
              content: Text("Fingerprint not recognized!"),
            );
          },
        );
      }
      setState(() {});
    } catch (e) {
      //print(e.toString());
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Warning!"),
            content: Text("An unexpected error occured!"),
          );
        },
      );
    }
  }

  void status(var status) {
    Navigator.popAndPushNamed(context, "/dashboard");
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
                    color: Colors.green,
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
                    color: Colors.orange,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        } else {
          return AlertDialog(
            title: Icon(Icons.warning_rounded, color: Colors.red, size: 50),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Transaction Failed!",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  void process() {
    //print("${pin1.text} ${pin2.text} ${pin3.text} ${pin4.text}");
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
  }

  void enterPin(var pin) {
    if (pin1.text.isEmpty) {
      pin1.text = pin.toString();
    } else if (pin2.text.isEmpty) {
      pin2.text = pin.toString();
    } else if (pin3.text.isEmpty) {
      pin3.text = pin.toString();
    } else {
      pin4.text = pin.toString();
      var _pin = "${pin1.text}${pin2.text}${pin3.text}${pin4.text}";
      pin1.text = "";
      pin2.text = "";
      pin3.text = "";
      pin4.text = "";
      if (_pin == user_data["t_pin"]) {
        process();
      } else {
        Vibrate.vibrate();
        Navigator.pop(context);
        showDialog(
          context: context,
          builder:
              (context) =>
                  AlertDialog(content: Text("Incorrect pin, try again.")),
        );
      }
    }
  }

  void deletePin() {
    if (pin4.text.isNotEmpty) {
      pin4.text = "";
    } else if (pin3.text.isNotEmpty) {
      pin3.text = "";
    } else if (pin2.text.isNotEmpty) {
      pin2.text = "";
    } else {
      pin1.text = "";
    }
  }

  void showBottomDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Enter Pin"),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      readOnly: true,
                      obscureText: true,
                      obscuringCharacter: "⓿",
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: pin1,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      readOnly: true,
                      obscureText: true,
                      obscuringCharacter: "⓿",
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: pin2,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      readOnly: true,
                      obscureText: true,
                      obscuringCharacter: "⓿",
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: pin3,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      readOnly: true,
                      obscureText: true,
                      obscuringCharacter: "⓿",
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: pin4,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      enterPin(1);
                    },
                    child: Text(
                      "1",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(2);
                    },
                    child: Text(
                      "2",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(3);
                    },
                    child: Text(
                      "3",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      enterPin(4);
                    },
                    child: Text(
                      "4",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(5);
                    },
                    child: Text(
                      "5",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(6);
                    },
                    child: Text(
                      "6",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      enterPin(7);
                    },
                    child: Text(
                      "7",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(8);
                    },
                    child: Text(
                      "8",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(9);
                    },
                    child: Text(
                      "9",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      if (biometric) {
                        biametric_authentication();
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Warning"),
                              content: Text(
                                "Enable biometric in the app settings to use biometric for authentication.",
                              ),
                            );
                          },
                        );
                      }
                    },
                    icon: Icon(Icons.fingerprint, size: 28, color: mainColor),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(0);
                    },
                    child: Text(
                      "0",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      deletePin();
                    },
                    icon: Icon(Icons.backspace, color: mainColor),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (reg_cable_listener == false) {
      socket.on('cable', (data) {
        //print(data);
        try {
          Navigator.pop(context);
          status(data["status"]);
        } catch (e) {
          //print("Error");
        }
      });
      reg_cable_listener = true;
    }
    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, "/dashboard");
            },
            icon: Icon(Icons.arrow_back),
          ),
          backgroundColor: mainColor,
          title: Text("Cable"),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: mainColor),
                    ),
                    border: OutlineInputBorder(),
                  ),
                  hint: Text(
                    cable == "none" ? "Choose Cable" : "",
                    style: TextStyle(color: mainColor),
                  ),
                  items: [
                    for (var cable in cable_types)
                      (DropdownMenuItem(value: cable, child: Text(cable))),
                  ],
                  validator: (value) {
                    if (value == null) {
                      return 'All field required';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      cable = value.toString();
                    });
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: number,
                  keyboardType: TextInputType.phone,
                  maxLength: 11,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
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
                SizedBox(height: 10),
                check_iuc
                    ? Row(
                      children: [
                        Image.asset("assets/images/loading.gif", scale: 25.0),
                        Text(
                          "Validating...",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                    : iuc_data == "Could not fetch data, try again."
                    ? Text(
                      "$iuc_data",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                    : iuc_data != ""
                    ? Text(
                      "$iuc_data".toUpperCase(),
                      style: TextStyle(
                        color:
                            iuc_data == "INVALID IUC NUMBER"
                                ? Colors.red
                                : Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                    : SizedBox(height: 0.01),
                TextFormField(
                  controller: iuc_number,
                  keyboardType: TextInputType.phone,
                  maxLength: 11,
                  readOnly: check_iuc,
                  decoration: InputDecoration(
                    labelText: 'IUC Number',
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
                  onChanged: (value) {
                    if (value.length == 11) {
                      setState(() {
                        check_iuc = true;
                      });
                      validateMeterNumber();
                    } else {
                      setState(() {
                        iuc_data = "";
                      });
                    }
                  },
                ),
                SizedBox(height: 10),
                cable != "none"
                    ? DropdownButtonFormField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      hint: Text(
                        "Choose Cable Plan",
                        style: TextStyle(color: mainColor),
                      ),
                      items: [
                        for (var sub in cable_plans[cable])
                          (DropdownMenuItem(
                            value: sub,
                            child: Text(
                              "${sub['plan'].toString()} ${sub['sale_price'].toString()}",
                            ),
                          )),
                      ],
                      validator: (value) {
                        if (value == null) {
                          return 'All field required';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          cable_plan = jsonDecode(value.toString());
                        });
                      },
                    )
                    : SizedBox(),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(25),
                    backgroundColor: mainColor,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showBottomDrawer(context);
                    }
                  },
                  child: Text("Pay", style: TextStyle(fontSize: 30)),
                ),
              ],
            ),
          ),
        ),
      ),
      onPopInvokedWithResult: (b, t) async {
        Navigator.popAndPushNamed(context, "/dashboard");
      },
    );
  }
}

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
          backgroundColor: mainColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              transactions.isEmpty
                  ? Center(child: Text("No Transactions history yet!"))
                  : RefreshIndicator(
                    color: mainColor,
                    child: ListView.builder(
                      itemCount: transactions.length,
                      itemBuilder: (context, index) {
                        final transaction = transactions[index];
                        try {
                          return Card(
                            elevation: 3,
                            child: ListTile(
                              onTap: () {
                                t_index = index;
                                Navigator.popAndPushNamed(
                                  context,
                                  "/transaction",
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
                                transaction['service'].toString().toUpperCase(),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 5),
                                  Text("₦${transaction['amount'].toString()}"),
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
                                          : transaction['status'] == 'pending'
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
                      final url = Uri.parse("$_url/user/refresh/transactions");
                      final headers = {
                        "Content-Type": "application/x-www-form-urlencoded",
                      };
                      final body = {"username": user_data["username"]};
                      try {
                        final response = await http.post(
                          url,
                          headers: headers,
                          body: body,
                        );
                        if (response.statusCode == 200) {
                          //print("It's Working...");
                          var data = jsonDecode(response.body);
                          //print(data);
                          if (data["status"] == "ok") {
                            var _data = data["data"];

                            if (_data["transactions"].isNotEmpty) {
                              transactions = _data["transactions"];
                              setState(() {});
                            }

                            //Navigator.pop(context);
                            //Navigator.popAndPushNamed(context, "/dashboard");
                          } else {
                            //Navigator.pop(context);
                            status("Alert", data["status"]);
                          }
                        } else {
                          //Navigator.pop(context);
                          status(
                            "Connection Error",
                            "check your internet connection and try again!",
                          );
                        }
                      } catch (e) {
                        //Navigator.pop(context);
                        status(
                          "Unexpected Error",
                          "Could ne not connect, check your internet connection and try again! ${e.toString()}",
                        );
                      }
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

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final screen = GlobalKey();
  share_receipt() async {
    final boundary =
        screen.currentContext?.findRenderObject() as RenderRepaintBoundary;
    var image = await boundary.toImage(pixelRatio: ui.window.devicePixelRatio);
    var byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    var pngBytes = byteData!.buffer.asUint8List();
    var file_path = "/storage/emulated/0/Download/DataApp_Receipt.png";
    File(file_path).writeAsBytesSync(pngBytes);
    Share.shareXFiles([XFile(file_path)]);
  }

  downloadReceipt() async {
    try {
      final boundary =
          screen.currentContext?.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(
        pixelRatio: ui.window.devicePixelRatio,
      );
      var byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData!.buffer.asUint8List();
      File(
        "/storage/emulated/0/Download/DataApp_Receipt.png",
      ).writeAsBytesSync(pngBytes);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(content: Text("Receipt Downloaded!"));
        },
      );
    } catch (e) {
      //print(e.toString());
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(content: Text("Error downloading Receipt!"));
        },
      );
    }
  }

  Widget data() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Provider"),
            Text(transactions[t_index]["provider"].toUpperCase()),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Data Plan"), Text(transactions[t_index]["plan"])],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Type"),
            Text(transactions[t_index]["type"].toUpperCase()),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Amount"),
            Text("₦${transactions[t_index]["amount"].toString()}"),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Recepiant"), Text(transactions[t_index]["tel"])],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Balance"),
            Text("₦${user_data['wallet_bal'].toString()}"),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Transaction Reference"),
            Text(transactions[t_index]["reference_id"]),
          ],
        ),
      ],
    );
  }

  Widget airtime() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("provider"),
            Text(transactions[t_index]["provider"].toUpperCase()),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Amount"),
            Text("₦${transactions[t_index]["amount"].toString()}"),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Recepiant"), Text(transactions[t_index]["tel"])],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Balance"),
            Text("₦${user_data['wallet_bal'].toString()}"),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Transaction Reference"),
            Text(transactions[t_index]["reference_id"]),
          ],
        ),
      ],
    );
  }

  Widget wallet_funding() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Amount"),
            Text("₦${transactions[t_index]["amount"].toString()}"),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Balance"),
            Text("₦${user_data['wallet_bal'].toString()}"),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Transaction Reference"),
            Text(transactions[t_index]["reference_id"]),
          ],
        ),
      ],
    );
  }

  Widget electric() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Disco Provider"),
            Text(transactions[t_index]["provider"].toUpperCase()),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Amount"),
            Text("₦${transactions[t_index]["amount"].toString()}"),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Recepiant"), Text(transactions[t_index]["tel"])],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Units"),
            Text(transactions[t_index]["unit"].toString()),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("PIN"), Text(transactions[t_index]["pin"])],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Balance"),
            Text("₦${user_data['wallet_bal'].toString()}"),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Transaction Reference"),
            Text(transactions[t_index]["reference_id"]),
          ],
        ),
      ],
    );
  }

  Widget edupin() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Exam Type"), Text(transactions[t_index]["exam"])],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Amount"),
            Text("₦${transactions[t_index]["amount"].toString()}"),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("PIN"), Text(transactions[t_index]["pin"])],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Recepiant"), Text(transactions[t_index]["tel"])],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Balance"),
            Text("₦${user_data['wallet_bal'].toString()}"),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Transaction Reference"),
            Text(transactions[t_index]["reference_id"]),
          ],
        ),
      ],
    );
  }

  Widget cable() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Provider"),
            Text(transactions[t_index]["provider"].toUpperCase()),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Plan"), Text(transactions[t_index]["plan"])],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Amount"),
            Text("₦${transactions[t_index]["amount"].toString()}"),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Recepiant"), Text(transactions[t_index]["tel"])],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Balance"),
            Text("₦${user_data['wallet_bal'].toString()}"),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Transaction Reference"),
            Text(transactions[t_index]["reference_id"]),
          ],
        ),
      ],
    );
  }

  Widget _content() {
    var service = transactions[t_index]["service"].toString().toUpperCase();
    if (service == "DATA PURCHASE") {
      return data();
    } else if (service == "AIRTIME PURCHASE") {
      return airtime();
    } else if (service == "EDU PIN PURCHASE") {
      return edupin();
    } else if (service == "ELECTRIC PURCHASE") {
      return electric();
    } else if (service == "WALLET FUNDING") {
      return wallet_funding();
    } else {
      return cable();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, "/transactions");
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Text("Transation"),
          backgroundColor: mainColor,
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              RepaintBoundary(
                key: screen,
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/images/data_app_logo.png",
                            scale: 40.0,
                          ),
                          Text("Transaction Receipt"),
                        ],
                      ),
                      SizedBox(height: 5),
                      Column(
                        children: [
                          Text(
                            transactions[t_index]["service"]
                                .toString()
                                .toUpperCase(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: mainColor,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            transactions[t_index]["status"].toUpperCase(),
                            style: TextStyle(
                              fontSize: 15,
                              color:
                                  transactions[t_index]["status"] == "success"
                                      ? Colors.green
                                      : transactions[t_index]["status"] ==
                                          "pending"
                                      ? Colors.orange
                                      : Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(transactions[t_index]["date"]),
                          Divider(thickness: 1.0, color: mainColor),
                        ],
                      ),
                      _content(),
                      Divider(thickness: 1.0, color: mainColor),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: mainColor),
                    onPressed: () {
                      share_receipt();
                    },
                    icon: Icon(Icons.share),
                    label: Text("Share Receipt"),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: mainColor),
                    onPressed: () {
                      downloadReceipt();
                    },
                    icon: Icon(Icons.download),
                    label: Text("Download Receipt"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      onPopInvokedWithResult: (b, t) async {
        Navigator.popAndPushNamed(context, "/transactions");
      },
    );
  }
}

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
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
          title: Text('Notification'),
          backgroundColor: mainColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              notifications.isEmpty
                  ? Center(child: Text("No Notifications yet!"))
                  : RefreshIndicator(
                    color: mainColor,
                    child: ListView.builder(
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        final notification = notifications[index];
                        return Card(
                          elevation: 3,
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("${notification['title']}"),
                                Text("${notification['date'].toString()}"),
                              ],
                            ),
                            subtitle: Text("${notification['content']}"),
                          ),
                        );
                      },
                    ),
                    onRefresh: () async {
                      final url = Uri.parse("$_url/user/refresh/notifications");
                      final headers = {
                        "Content-Type": "application/x-www-form-urlencoded",
                      };
                      final body = {"username": user_data["username"]};
                      try {
                        final response = await http.post(
                          url,
                          headers: headers,
                          body: body,
                        );
                        if (response.statusCode == 200) {
                          //print("It's Working...");
                          var data = jsonDecode(response.body);
                          //print(data);
                          if (data["status"] == "ok") {
                            var _data = data["data"];

                            if (_data["notifications"].isNotEmpty) {
                              notifications = _data["notifications"];
                              setState(() {});
                            }

                            //Navigator.pop(context);
                            //Navigator.popAndPushNamed(context, "/dashboard");
                          } else {
                            //Navigator.pop(context);
                            status("Alert", data["status"]);
                          }
                        } else {
                          //Navigator.pop(context);
                          status(
                            "Connection Error",
                            "check your internet connection and try again!",
                          );
                        }
                      } catch (e) {
                        //Navigator.pop(context);
                        status(
                          "Unexpected Error",
                          "Could ne not connect, check your internet connection and try again! ${e.toString()}",
                        );
                      }
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

class AboutUsPage extends StatelessWidget {
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
          title: Text("About Us"),
          backgroundColor: mainColor,
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
                  color: mainColor,
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
      ),
      onPopInvokedWithResult: (b, t) async {
        Navigator.popAndPushNamed(context, "/dashboard");
      },
    );
  }
}

class Settings extends StatelessWidget {
  const Settings({super.key});

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
          title: Text("Settings"),
          backgroundColor: mainColor,
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              ListTile(
                onTap: (() => Navigator.popAndPushNamed(context, "/security")),
                title: Text("Account Security", style: TextStyle(fontSize: 25)),
                leading: Icon(Icons.admin_panel_settings, size: 25),
              ),
              Divider(thickness: 1),
              ListTile(
                onTap:
                    (() => Navigator.popAndPushNamed(context, "/notisetting")),
                title: Text("Notification", style: TextStyle(fontSize: 25)),
                leading: Icon(Icons.notifications, size: 25),
              ),
              Divider(thickness: 1),
              ListTile(
                onTap: (() => Navigator.popAndPushNamed(context, "/theme")),
                title: Text("Theme", style: TextStyle(fontSize: 25)),
                leading: Icon(Icons.format_paint, size: 25),
              ),
              Divider(thickness: 1),
              ListTile(
                title: Text("Delete Account", style: TextStyle(fontSize: 25)),
                leading: Icon(Icons.delete, size: 25),
              ),
              Divider(thickness: 1),
            ],
          ),
        ),
      ),
      onPopInvokedWithResult: (b, t) async {
        Navigator.popAndPushNamed(context, "/dashboard");
      },
    );
  }
}

class SecurityPage extends StatefulWidget {
  const SecurityPage({super.key});

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, "/settings");
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Text("Security"),
          backgroundColor: mainColor,
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              ListTile(
                onTap:
                    (() =>
                        Navigator.popAndPushNamed(context, "/changepassword")),
                title: Text("Change Password", style: TextStyle(fontSize: 25)),
                leading: Icon(Icons.security, size: 25),
              ),
              Divider(thickness: 1),
              ListTile(
                onTap: (() => Navigator.popAndPushNamed(context, "/changepin")),
                title: Text(
                  "Change Transaction Pin",
                  style: TextStyle(fontSize: 25),
                ),
                leading: Icon(Icons.lock, size: 25),
              ),
              Divider(thickness: 1),
              ListTile(
                title: Text("Biometric", style: TextStyle(fontSize: 25)),
                leading: Icon(Icons.fingerprint, size: 25),
                trailing: Switch(
                  value: biometric,
                  activeColor: mainColor,
                  onChanged: (value) async {
                    setState(() {
                      biometric = value;
                    });
                    await storage.write(
                      key: 'biometric',
                      value: "${biometric.toString()}",
                    );
                  },
                ),
              ),
              Divider(thickness: 1),
              ListTile(
                onTap:
                    (() => Navigator.popAndPushNamed(
                      context,
                      "/bvn_verification",
                    )),
                title: Text("BVN Verification", style: TextStyle(fontSize: 25)),
                leading: Icon(Icons.security, size: 25),
              ),
              Divider(thickness: 1),
            ],
          ),
        ),
      ),
      onPopInvokedWithResult: (b, t) async {
        Navigator.popAndPushNamed(context, "/settings");
      },
    );
  }
}

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, "/settings");
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Text("Notification Settings"),
          backgroundColor: mainColor,
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              ListTile(
                title: Text(
                  "Push Notification",
                  style: TextStyle(fontSize: 25),
                ),
                trailing: Switch(
                  value: pushnotify,
                  activeColor: mainColor,
                  onChanged: (value) async {
                    //print("hello");
                    setState(() {
                      pushnotify = value;
                    });
                    await storage.write(
                      key: 'pushnotify',
                      value: "${pushnotify.toString()}",
                    );
                  },
                ),
              ),
              Divider(thickness: 1),
              ListTile(
                title: Text(
                  "Email Notification",
                  style: TextStyle(fontSize: 25),
                ),
                trailing: Switch(
                  value: emailnotify,
                  activeColor: mainColor,
                  onChanged: (value) async {
                    if (value == true) {}
                    setState(() {
                      emailnotify = value;
                    });
                    await storage.write(
                      key: 'emailnotify',
                      value: "${emailnotify.toString()}",
                    );
                  },
                ),
              ),
              Divider(thickness: 1),
            ],
          ),
        ),
      ),
      onPopInvokedWithResult: (b, t) async {
        Navigator.popAndPushNamed(context, "/settings");
      },
    );
  }
}

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, "/settings");
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Text("Choose Theme"),
          backgroundColor: mainColor,
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              ListTile(
                onTap: () async {
                  await storage.write(key: 'theme', value: 'default');
                  setState(() {
                    theme = "default";
                    mainColor = Color.fromRGBO(82, 101, 140, 1);
                  });
                },
                title: Text("Default", style: TextStyle(fontSize: 25)),
                leading: Icon(
                  Icons.square,
                  size: 25,
                  color: Color.fromRGBO(82, 101, 140, 1),
                ),
                trailing:
                    theme == "default"
                        ? Icon(Icons.check_circle, color: mainColor)
                        : SizedBox(),
              ),
              Divider(thickness: 1),
              ListTile(
                onTap: () async {
                  await storage.write(key: 'theme', value: 'orange');
                  setState(() {
                    theme = "orange";
                    mainColor = Colors.orange[800];
                  });
                },
                title: Text("Orange", style: TextStyle(fontSize: 25)),
                leading: Icon(
                  Icons.square,
                  size: 25,
                  color: Colors.orange[800],
                ),
                trailing:
                    theme == "orange"
                        ? Icon(Icons.check_circle, color: mainColor)
                        : SizedBox(),
              ),
              Divider(thickness: 1),
              ListTile(
                onTap: () async {
                  await storage.write(key: 'theme', value: 'blue');
                  setState(() {
                    theme = "blue";
                    mainColor = Colors.blue[800];
                  });
                },
                title: Text("Blue", style: TextStyle(fontSize: 25)),
                leading: Icon(Icons.square, size: 25, color: Colors.blue[800]),
                trailing:
                    theme == "blue"
                        ? Icon(Icons.check_circle, color: mainColor)
                        : SizedBox(),
              ),
              Divider(thickness: 1),
              ListTile(
                onTap: () async {
                  await storage.write(key: 'theme', value: 'brown');
                  setState(() {
                    theme = "brown";
                    mainColor = Color.fromARGB(255, 98, 12, 0);
                  });
                },
                title: Text("Brown", style: TextStyle(fontSize: 25)),
                leading: Icon(
                  Icons.square,
                  size: 25,
                  color: Color.fromARGB(255, 98, 12, 0),
                ),
                trailing:
                    theme == "brown"
                        ? Icon(Icons.check_circle, color: mainColor)
                        : SizedBox(),
              ),
              Divider(thickness: 1),
            ],
          ),
        ),
      ),
      onPopInvokedWithResult: (b, t) async {
        Navigator.popAndPushNamed(context, "/settings");
      },
    );
  }
}

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController oldPassword = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
          title: Text("Change Password"),
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
                  controller: oldPassword,
                  decoration: InputDecoration(
                    labelText: 'Old Password',
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
                TextFormField(
                  controller: password,
                  decoration: InputDecoration(
                    labelText: 'Password',
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
                  obscureText: true, // Hide password
                ),
                SizedBox(height: 20.0), // Spacing between fields
                TextFormField(
                  controller: confirmPassword,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
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
                  obscureText: true, // Hide password
                ),
                SizedBox(height: 10.0),
                // Sign Up Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Show error message for mismatched passwords
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Passwords do not match")),
                      );
                    },
                    child: Text('Change Password'),
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

class ChangePinPage extends StatefulWidget {
  const ChangePinPage({super.key});

  @override
  State<ChangePinPage> createState() => _ChangePinPageState();
}

class _ChangePinPageState extends State<ChangePinPage> {
  TextEditingController pin1 = TextEditingController();
  TextEditingController pin2 = TextEditingController();
  TextEditingController pin3 = TextEditingController();
  TextEditingController pin4 = TextEditingController();

  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _isAuthenticated = false;

  void status(var _title, var status) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(title: Text(_title), content: Text(status)),
    );
  }

  void setPin() async {
    final url = Uri.parse("$_url/user/set-pin");
    final headers = {"Content-Type": "application/x-www-form-urlencoded"};
    final body = {"username": user_data["username"], "t_pin": new_pin};
    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        //print("It's Working...");
        var data = jsonDecode(response.body);
        //print(data);
        if (data["status"] == "ok") {
          user_data["t_pin"] = new_pin;
          setState(() {
            new_pin = "";
            conf_pin = "";
          });
          Navigator.pop(context);
          Navigator.popAndPushNamed(context, "/dashboard");
        }
      } else {
        Navigator.pop(context);
        status(
          "Connection Error",
          "check your internet connection and try again!",
        );
      }
    } catch (e) {
      Navigator.pop(context);
      status(
        "Unexpected Error",
        "Could ne not connect, check your internet connection and try again! ${e.toString()}",
      );
    }
  }

  void process() {
    //print("${pin1.text}${pin2.text}${pin3.text}${pin4.text}");
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
  }

  void check_pin() {
    if (set_pin == true) {
      if (new_pin.isEmpty) {
        new_pin = "${pin1.text}${pin2.text}${pin3.text}${pin4.text}";
        pin_status = "";
        pin1.text = "";
        pin2.text = "";
        pin3.text = "";
        pin4.text = "";
        setState(() {});
      } else {
        conf_pin = "${pin1.text}${pin2.text}${pin3.text}${pin4.text}";
        if (conf_pin == new_pin) {
          pin_status = "";
          set_pin = false;
          process();
          setPin();
        } else {
          pin1.text = "";
          pin2.text = "";
          pin3.text = "";
          pin4.text = "";
          conf_pin = "";
          new_pin = "";
          pin_status = "Pin didn't match,";
          Vibrate.vibrate();
          setState(() {});
        }
      }
    } else {
      var old_pin = "${pin1.text}${pin2.text}${pin3.text}${pin4.text}";
      if (user_data["t_pin"] == old_pin) {
        set_pin = true;
        pin1.text = "";
        pin2.text = "";
        pin3.text = "";
        pin4.text = "";
        conf_pin = "";
        pin_status = "";
        setState(() {});
      } else {
        pin1.text = "";
        pin2.text = "";
        pin3.text = "";
        pin4.text = "";
        conf_pin = "";
        pin_status = "Pin didn't match,";
        Vibrate.vibrate();
        setState(() {});
      }
    }
  }

  void enterPin(var pin) {
    if (pin1.text.isEmpty) {
      pin1.text = pin.toString();
    } else if (pin2.text.isEmpty) {
      pin2.text = pin.toString();
    } else if (pin3.text.isEmpty) {
      pin3.text = pin.toString();
    } else {
      pin4.text = pin.toString();
      check_pin();
    }
  }

  void deletePin() {
    if (pin4.text.isNotEmpty) {
      pin4.text = "";
    } else if (pin3.text.isNotEmpty) {
      pin3.text = "";
    } else if (pin2.text.isNotEmpty) {
      pin2.text = "";
    } else {
      pin1.text = "";
    }
  }

  void alert() async {
    Timer(Duration(seconds: 1), () {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text("Warning"),
              content: Text(
                "Your default pin is: 0000, Change it now for security purpose or skip to change it later.",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    set_pin = false;
                    Navigator.popAndPushNamed(context, "/dashboard");
                  },
                  child: Text("Skip"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Change"),
                ),
              ],
            ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (user_data["t_pin"] == "0000" && pin_alert == true) {
      alert();
      setState(() {
        pin_alert = false;
      });
    }
    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              setState(() {
                new_pin = "";
                conf_pin = "";
                pin_status = "";
                set_pin = false;
              });
              Navigator.popAndPushNamed(context, "/security");
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Text(
            set_pin ? "Set Transaction Pin" : "Change Transaction PIN",
          ),
          backgroundColor: mainColor,
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                set_pin
                    ? new_pin.isEmpty
                        ? "$pin_status Enter new pin"
                        : "$pin_status Confirm pin"
                    : "$pin_status Enter old pin",
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      readOnly: true,
                      obscureText: true,
                      obscuringCharacter: "⓿",
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: pin1,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      readOnly: true,
                      obscureText: true,
                      obscuringCharacter: "⓿",
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: pin2,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      readOnly: true,
                      obscureText: true,
                      obscuringCharacter: "⓿",
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: pin3,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      readOnly: true,
                      obscureText: true,
                      obscuringCharacter: "⓿",
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: pin4,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      enterPin(1);
                    },
                    child: Text(
                      "1",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(2);
                    },
                    child: Text(
                      "2",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(3);
                    },
                    child: Text(
                      "3",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      enterPin(4);
                    },
                    child: Text(
                      "4",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(5);
                    },
                    child: Text(
                      "5",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(6);
                    },
                    child: Text(
                      "6",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      enterPin(7);
                    },
                    child: Text(
                      "7",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(8);
                    },
                    child: Text(
                      "8",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(9);
                    },
                    child: Text(
                      "9",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.fingerprint, size: 28, color: mainColor),
                  ),
                  TextButton(
                    onPressed: () {
                      enterPin(0);
                    },
                    child: Text(
                      "0",
                      style: TextStyle(fontSize: 40, color: mainColor),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      deletePin();
                    },
                    icon: Icon(Icons.backspace, color: mainColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      onPopInvokedWithResult: (b, t) async {
        Navigator.popAndPushNamed(context, "/security");
      },
    );
  }
}

class BVNVerificationPage extends StatefulWidget {
  const BVNVerificationPage({super.key});

  @override
  State<BVNVerificationPage> createState() => _BVNVerificationPageState();
}

class _BVNVerificationPageState extends State<BVNVerificationPage> {
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
        //print("It's Working...");
        var data = jsonDecode(response.body);
        ////print(data);
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

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController fullname = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    fullname.text = user_data['fullname'];
    username.text = user_data['username'];
    phone.text = user_data['tel'];
    address.text = user_data['address'];
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
  }

  void updateProfile() async {
    final url = Uri.parse("$_url/user/update-profile");
    final headers = {"Content-Type": "application/x-www-form-urlencoded"};
    final body = {
      "username": user_data["username"],
      "fullname": fullname.text,
      "tel": phone.text,
      "address": address.text,
    };
    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        //print("It's Working...");
        var data = jsonDecode(response.body);
        //print(data);
        if (data["status"] == "ok") {
          user_data = data["user_data"];
          setState(() {});
          Navigator.pop(context);
          status("Alert", "Profile updated successfully!");

          //Navigator.pop(context);
          //Navigator.popAndPushNamed(context, "/dashboard");
        } else {
          Navigator.pop(context);
          status("Alert", data["status"]);
        }
      } else {
        Navigator.pop(context);
        status(
          "Connection Error",
          "check your internet connection and try again!",
        );
      }
    } catch (e) {
      Navigator.pop(context);
      status(
        "Unexpected Error",
        "Could ne not connect, check your internet connection and try again! ${e.toString()}",
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
              Navigator.popAndPushNamed(context, "/dashboard");
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Text("Profile"),
          backgroundColor: mainColor,
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 30), // Space between title and fields
                TextFormField(
                  controller: fullname,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
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
                SizedBox(height: 10.0),
                TextFormField(
                  controller: username,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Username',
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
                SizedBox(height: 10.0),
                TextFormField(
                  controller: phone,
                  maxLength: 11,
                  decoration: InputDecoration(
                    labelText: 'Phone number',
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

                SizedBox(height: 10.0),
                TextFormField(
                  controller: address,
                  decoration: InputDecoration(
                    labelText: 'Address',
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
                SizedBox(height: 10.0), // Spacing between fields
                TextFormField(
                  controller: password,
                  decoration: InputDecoration(
                    labelText: 'Password',
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
                  obscureText: true, // Hide password
                ), // Spacing between fields

                SizedBox(height: 10.0),
                // Sign Up Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle sign-up logic (e.g., validation, API call)
                      if (password.text == user_data['password']) {
                        if (_formKey.currentState!.validate()) {
                          process();
                          updateProfile();
                        }
                        // Proceed with registration
                        //signup();
                        // Optionally, navigate to the login page or dashboard
                      } else {
                        // Show error message for mismatched passwords
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Passwords do not match")),
                        );
                      }
                    },
                    child: Text('Update Profile'),
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
              ],
            ),
          ),
        ),
      ),
      onPopInvokedWithResult: (b, t) async {
        Navigator.popAndPushNamed(context, "/dashboard");
      },
    );
  }
}

class TermsAndPolicyPage extends StatelessWidget {
  const TermsAndPolicyPage({super.key});

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
          title: Text("Terms & Policy"),
          backgroundColor: mainColor,
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
      ),
      onPopInvokedWithResult: (b, t) async {
        Navigator.popAndPushNamed(context, "/dashboard");
      },
    );
  }
}
