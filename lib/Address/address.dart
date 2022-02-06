import 'package:octaron/Config/config.dart';
import 'package:octaron/Orders//placeOrder.dart';
import 'package:octaron/Widgets/custom_app_bar.dart';
import 'package:octaron/Widgets/loading_widget.dart';
import 'package:octaron/Widgets/wideButton.dart';
import 'package:octaron/Models//address.dart';
import 'package:octaron/Counters/change_addresss.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'addAddress.dart';

class Address extends StatefulWidget
{
  @override
  _AddressState createState() => _AddressState();
}


class _AddressState extends State<Address>
{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
child: Container(),
    );
  }

  noAddressCard() {
    return Card(

    );
  }
}

class AddressCard extends StatefulWidget {

  @override
  _AddressCardState createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  @override
  Widget build(BuildContext context) {

    return InkWell(

    );
  }
}





class KeyText extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Text("");
  }
}
