import 'package:flutter/foundation.dart';
import 'package:octaron/Config/config.dart';

class CartItemCounter extends ChangeNotifier {
  final int? _counter = EcommerceApp.sharedPreferences!.getInt('card_count');

  int? get count => _counter;

  Future<void> displayResult() async {
    int? _counter = EcommerceApp.sharedPreferences!.getInt('card_count');
    await Future.delayed(const Duration(milliseconds: 100), () {
      notifyListeners();
    });
  }
}
