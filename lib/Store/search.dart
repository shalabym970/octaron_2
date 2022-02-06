import 'package:octaron/Models/product.dart';
import 'package:octaron/Store/store_home.dart';
import 'package:flutter/material.dart';

import '../Widgets/custom_app_bar.dart';

class SearchProduct extends StatefulWidget {
  @override
  _SearchProductState createState() => new _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(
          bottom: PreferredSize(
            child: searchWidget(),
            preferredSize: Size(56.0, 56.0),
          ),
        ),
      ),
    );
  }

  searchWidget() {}
}
