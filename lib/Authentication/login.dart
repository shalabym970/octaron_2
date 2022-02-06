import 'dart:convert';
import 'dart:developer';
import 'package:another_flushbar/flushbar.dart';
import 'package:connectivity/connectivity.dart';
import 'package:octaron/Authentication/register.dart';
import 'package:octaron/DialogBox/error_dialog.dart';
import 'package:octaron/DialogBox/loading_dialog.dart';
import 'package:octaron/Widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import '../Store/store_home.dart';
import 'package:octaron/Config/config.dart';
import 'package:http/http.dart' as http;
import '../const.dart';
import'package:octaron/const.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool hidePassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final bool _isLoading = false;
  bool showDialog1 = true;

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
              height: 400,
              width: _screenWidth,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/login_cover.jpeg'),
                      fit: BoxFit.fill)),
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 300,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/login_logo.png'),
                              fit: BoxFit.contain)),
                    ),
                    Positioned(
                      child: Container(
                        margin: const EdgeInsets.only(top: 250),
                        child: const Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: kTextAndIconsColor,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
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
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.email,
                                            color: kSecondaryColor),
                                        border: InputBorder.none,
                                        hintText: "Enter your Email ",
                                        hintStyle: TextStyle(
                                            color: Colors.grey[400]))),
                                TextFormFieldWidget(
                                  controller: passwordController,
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
                                    hintText: "Password",
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: 15,
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
                          "Login",
                          style: TextStyle(
                              color: kTextAndIconsColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                    onTap: () async {
                      var connectivityResult =
                          await (Connectivity().checkConnectivity());
                      if (connectivityResult == ConnectivityResult.mobile ||
                          connectivityResult == ConnectivityResult.wifi) {
                        loginValidator();
                      } else {
                        await Flushbar(
                          icon: const ImageIcon(
                            AssetImage(
                                'assets/images/baseline_wifi_off_black_24dp.png'),
                            size: 40,
                            color: Colors.red,
                          ),
                          titleSize: 20,
                          message: 'No internet connection, connect and try again',
                          messageColor: Colors.red,
                          duration: const Duration(seconds: 10),
                        ).show(context);
                      }
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        "you don't have an account?! ",
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
                          "Register",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor,
                            decoration: TextDecoration.underline,
                            fontSize: 18,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Register()),
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

  // this method using to valid email and password from users

  loginValidator() {
    emailController.text.isNotEmpty && passwordController.text.isNotEmpty
        ? loginUser()
        : displayDialog("Write email and password...\n");
  }

  // this method is to show an error message when there is an  error , so enter the data
  displayDialog(String msg) {
    showDialog(
        context: context,
        builder: (c) {
          return ErrorAlertDialog(message: msg);
        });
  }

  // this method is to user in the  app when his data is valid

  loginUser() async {
    try {
      showDialog(
          context: context,
          builder: (c) {
            return const Expanded(
              child: LoadingAlertDialog(
                message: 'Authenticating, Please wait.....',
              ),
            );
          });

      var url = Uri.parse('$apiUrl/api/login');
      var response = await http.post(url, body: {
        'email': emailController.text,
        'password': passwordController.text
      }, headers: {
        'Accept': "application/json"
      });
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
       await EcommerceApp.sharedPreferences!.setString("token", body['token'].toString());
        await EcommerceApp.sharedPreferences!.setString("user_id", body['user']['id'].toString());
        await EcommerceApp.sharedPreferences!.setString("username", body['user']['username'].toString());
        await EcommerceApp.sharedPreferences!.setInt("cart_count", body['count']);

        Navigator.pop(context);
        Route route = MaterialPageRoute(builder: (c) => const StoreHome());
        Navigator.pushReplacement(context, route);
        await Flushbar(
          icon: const ImageIcon(
            AssetImage('assets/images/baseline_emoji_emotions_black_24dp.png'),
            size: 40,
            color: Colors.green,
          ),
          title: 'Welcome...',
          titleSize: 20,
          message: 'We are glad to have you back.',
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
          message:
              'your Email or Password is not correct please try again or click on forget password...',
          messageColor: Colors.red,
          duration: const Duration(seconds: 10),
        ).show(context);
      }
    } catch (e) {
      setState(() {
        Navigator.pop(context);
      });
      print(e.toString()+'0000000000');
      await Flushbar(
        icon: const ImageIcon(
          AssetImage(
              'assets/images/baseline_error_outline_black_24dp.png'),
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
}
