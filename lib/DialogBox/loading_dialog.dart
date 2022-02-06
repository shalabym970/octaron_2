import 'package:octaron/Widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:octaron/const.dart';

class LoadingAlertDialog extends StatelessWidget
{
  final String message;
  const LoadingAlertDialog( {Key? key,  required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          circularProgress(),
          const SizedBox(
            height: 10,
          ),
           Text(message,style: const TextStyle(color: Colors.black)),
        ],
      ),
    );
  }
}
