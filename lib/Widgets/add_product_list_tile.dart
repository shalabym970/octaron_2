import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../const.dart';

class AddProductListTile extends StatelessWidget {
  final IconData icon;
  final TextInputType keyboardType;
  final String hint;
  final TextEditingController controller;

  const AddProductListTile(
      {Key? key,
      required this.icon,
      required this.keyboardType,
      required this.hint,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: kSecondaryColor),
      title: SizedBox(
        width: 250.0,
        child: TextField(
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.black),
          controller: controller,
          decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
              border: InputBorder.none),
        ),
      ),
    );
  }
}
