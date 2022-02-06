import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:octaron/const.dart';

class ErrorAlertDialog extends StatelessWidget {
  final String message;

  const ErrorAlertDialog({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 120,
        child: Center(
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const ImageIcon(
                AssetImage(
                    'assets/images/baseline_sentiment_very_dissatisfied_black_24dp.png'),
                size: 37,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                message,
                style: const TextStyle(color: Colors.red, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK',
                style: TextStyle(fontSize: 20.0, color: kTextAndIconsColor)),
            style: ElevatedButton.styleFrom(
              primary: kPrimaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              textStyle:
                  const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}
