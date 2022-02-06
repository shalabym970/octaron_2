import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:connectivity/connectivity.dart';
import 'package:octaron/Authentication/login.dart';
import 'package:octaron/DialogBox/error_dialog.dart';
import 'package:octaron/DialogBox/loading_dialog.dart';
import 'package:octaron/Widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../const.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool hidePassword = true;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width,
        _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 150,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/login_cover.jpeg'),
                      fit: BoxFit.fill)),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: Container(
                      margin: const EdgeInsets.only(top: 100),
                      child: const Center(
                        child: Text(
                          "Register",
                          style: TextStyle(
                              color: kTextAndIconsColor,
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: kTextAndIconsColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromRGBO(143, 148, 251, .2),
                              blurRadius: 20.0,
                              offset: Offset(0, 10))
                        ]),
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                TextFormFieldWidget(
                                    controller: usernameController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.person,
                                            color: kSecondaryColor),
                                        border: InputBorder.none,
                                        hintText: "Username ",
                                        hintStyle: TextStyle(
                                            color: Colors.grey[400]))),
                                TextFormFieldWidget(
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.email,
                                            color: kSecondaryColor),
                                        border: InputBorder.none,
                                        hintText: "Email",
                                        hintStyle: TextStyle(
                                            color: Colors.grey[400]))),
                                TextFormFieldWidget(
                                    controller: phoneController,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                            Icons.phone_android,
                                            color: kSecondaryColor),
                                        border: InputBorder.none,
                                        hintText: "Phone",
                                        hintStyle: TextStyle(
                                            color: Colors.grey[400]))),
                                TextFormFieldWidget(
                                  controller: passwordController,
                                  keyboardType: TextInputType.text,
                                  obscure: hidePassword,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.lock_outline,
                                        color: kSecondaryColor),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          hidePassword = !hidePassword;
                                        });
                                      },
                                      color: kSecondaryColor,
                                      icon: Icon(hidePassword
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                    ),
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ),
                                TextFormFieldWidget(
                                  controller: confirmPasswordController,
                                  keyboardType: TextInputType.text,
                                  obscure: hidePassword,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.lock,
                                        color: kSecondaryColor),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          hidePassword = !hidePassword;
                                        });
                                      },
                                      color: kSecondaryColor,
                                      icon: Icon(hidePassword
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                    ),
                                    border: InputBorder.none,
                                    hintText: "Confirm Password",
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ),
                                TextFormFieldWidget(
                                    controller: cityController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                            Icons.location_city,
                                            color: kSecondaryColor),
                                        border: InputBorder.none,
                                        hintText: "City",
                                        hintStyle: TextStyle(
                                            color: Colors.grey[400]))),
                                TextFormFieldWidget(
                                    controller: addressController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.opacity,
                                            color: kSecondaryColor),
                                        border: InputBorder.none,
                                        hintText: "address",
                                        hintStyle: TextStyle(
                                            color: Colors.grey[400]))),
                              ],
                            ),
                          ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kPrimaryColor,
                      ),
                      child: const Center(
                        child: Text(
                          "Register",
                          style: TextStyle(
                              color: kTextAndIconsColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                    onTap: () async{
                      var connectivityResult =
                      await (Connectivity().checkConnectivity());
                      if (connectivityResult == ConnectivityResult.mobile ||
                          connectivityResult == ConnectivityResult.wifi) {
                        registerValidation();
                      } else {
                        await Flushbar(
                            icon: const ImageIcon(
                            AssetImage(
                            'assets/images/baseline_sentiment_very_dissatisfied_black_24dp.png'),
                      size: 40,
                      color: Colors.red,
                      ),
                      title: 'Sorry...',
                      titleSize: 20,
                      message: "you don't have connection...",
                      messageColor: Colors.red,
                      duration: const Duration(seconds: 10),
                      ).show(context);
                    }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        "already you have an account?! ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor,
                            decoration: TextDecoration.underline,
                            fontSize: 18,
                          ),
                        ),
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()),
                            (Route<dynamic> route) => false,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  registerValidation() {
    usernameController.text.isNotEmpty &&
            emailController.text.isNotEmpty &&
            phoneController.text.isNotEmpty &&
            cityController.text.isNotEmpty &&
            addressController.text.isNotEmpty &&
            passwordController.text.isNotEmpty &&
            confirmPasswordController.text.isNotEmpty
        ? passwordController.text.length >= 6
            ? passwordController.text == confirmPasswordController.text
                ? registration()
                : displayDialog(
                    "password do not match with confirm password...\n")
            : displayDialog(
                "your password must be equal or more than 6 letters...\n")
        : displayDialog("Fill up the registration complete form...\n");
  }

  displayDialog(String msg) {
    showDialog(
        context: context,
        builder: (c) {
          return Expanded(child: ErrorAlertDialog(message: msg));
        });
  }

  registration() async {
    try {
      showDialog(
          context: context,
          builder: (c) {
            return const LoadingAlertDialog(
              message: 'Registering, Please wait.....',
            );
          });
      var url = Uri.parse('$apiUrl/api/userapi');
      var response = await http.post(url, body: {
        'username': usernameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'phone': phoneController.text,
        'gender': 'male',
        'city': cityController.text,
        'address': addressController.text,
      }, headers: {
        'Accept': "application/json"
      });
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 201) {
        Navigator.pop(context);
        clearInfo();
        Route route = MaterialPageRoute(builder: (c) => const Login());
        Navigator.pushReplacement(context, route);
        await Flushbar(
          icon: const ImageIcon(
            AssetImage('assets/images/baseline_emoji_emotions_black_24dp.png'),
            size: 40,
            color: Colors.green,
          ),
          title: 'Congratulation...',
          titleSize: 20,
          message: 'You have successfully completed the registration process.',
          messageColor: Colors.green,
          duration: const Duration(seconds: 10),
        ).show(context);
      } else {
        Navigator.pop(context);
        await Flushbar(
          icon: const ImageIcon(
            AssetImage(
                'assets/images/baseline_sentiment_very_dissatisfied_black_24dp.png'),
            size: 40,
            color: Colors.red,
          ),
          title: 'Sorry...',
          titleSize: 20,
          message: 'The registration process failed, try again.',
          messageColor: Colors.red,
          duration: const Duration(seconds: 10),
        ).show(context);
      }
    } catch (e) {
      setState(() {
        Navigator.pop(context);
      });
      await Flushbar(
        icon: const ImageIcon(
          AssetImage('assets/images/baseline_error_outline_black_24dp.png'),
          size: 40,
          color: Colors.red,
        ),
        title: 'Sorry...',
        titleSize: 20,
        message: 'An error occurred, please try again later',
        messageColor: Colors.red,
        duration: const Duration(seconds: 10),
      ).show(context);
    }
  }

  clearInfo() {
    setState(() {
      usernameController.clear();
      emailController.clear();
      phoneController.clear();
      cityController.clear();
      addressController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
    });
  }
}
