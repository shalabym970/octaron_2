import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerDivider extends StatelessWidget {
  const DrawerDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 10.0,
      color: Colors.white,
      thickness: 6.0,
    );
  }
}
