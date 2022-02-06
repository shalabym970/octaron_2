import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {


  final String text;
  final Widget widget;
  final IconData icon;

  const DrawerListTile({Key? key,
    required  this.text,
    required this.widget,
    required this.icon,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
    leading:  Icon( icon ,color: Colors.white,size: 30,),
  title:  Text( text,style: const TextStyle(color: Colors.white,fontSize: 18),),
  onTap: (){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  },
    );
  }
}
