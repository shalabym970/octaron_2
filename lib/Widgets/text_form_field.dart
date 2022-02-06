import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final InputDecoration decoration;
  final bool obscure;

  const TextFormFieldWidget(
      {Key? key,
      required this.controller,
      required this.keyboardType,
      required this.decoration,
      this.obscure = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey))),
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: decoration,
          obscureText: obscure,
        ));
  }
}
