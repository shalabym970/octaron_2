import 'dart:async';
import 'package:octaron/Authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:octaron/const.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:octaron/Config/config.dart';
import 'Config/config.dart';
import 'Counters/cart_item_counter.dart';
import 'Counters/change_addresss.dart';
import 'Counters/item_quantity.dart';
import 'Counters/total_money.dart';
import 'Store/store_home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EcommerceApp.sharedPreferences = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => CartItemCounter()),
        ChangeNotifierProvider(create: (c) => BookQuantity()),
        ChangeNotifierProvider(create: (c) => AddressChanger()),
        ChangeNotifierProvider(create: (c) => TotalAmount()),
      ],
      child: MaterialApp(
          title: 'Octaron',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: kPrimaryColor,
            scaffoldBackgroundColor: Colors.white,
          ),
          home: const SplashScreen()),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    displaySplash();
  }

  //this method working for pass user to storeHome page if it logedin , else pass it to login page
  displaySplash() {
    Timer(const Duration(seconds: 5), () async {
      Route route;
      if(EcommerceApp.sharedPreferences!.getString('token') != null){
         route = MaterialPageRoute(builder: (_) => const StoreHome());
      }else{
         route = MaterialPageRoute(builder: (_) => const Login());
      }
      Navigator.pushReplacement(context,
          route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

                 Image.asset(
                  'assets/images/welcome.png',
                  fit: BoxFit
                      .fitHeight, // I thought this would fill up my Container but it doesn't
                ),
               Image.asset(
                  'assets/images/landing_2.png',
                  fit: BoxFit
                      .fitHeight, // I thought this would fill up my Container but it doesn't
                ),

            ],
          ),
        ),
      ),
    );
  }
}
