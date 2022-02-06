import 'package:octaron/Address/address.dart';
import 'package:octaron/Admin/upload_items.dart';
import 'package:octaron/Authentication/login.dart';
import 'package:octaron/Config/config.dart';
import 'package:octaron/Address/addAddress.dart';
import 'package:octaron/Store/search.dart';
import 'package:octaron/Store/cart.dart';
import 'package:octaron/Orders/myOrders.dart';
import 'package:octaron/Store/store_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:octaron/Widgets/my_drawer_divider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const.dart';
import 'my_drawer_list_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(top:25.0, bottom: 10.0),
            decoration:  const BoxDecoration(
              gradient: LinearGradient(
                colors: [kPrimaryColor, kSecondaryColor],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(0.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
            child: Column(
              children:  [
                 Text(EcommerceApp.sharedPreferences!.getString('username').toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontFamily: "Signatra",
                ),),
                const SizedBox(
                  height: 12.0,
                ),
                Container(
                  padding: const EdgeInsets.only(top:1.0),
                  decoration:  const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [kPrimaryColor, kSecondaryColor],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(0.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp,
                    ),
                  ),
                  child: Column(
                    children: [
                      const DrawerDivider(),
                      const DrawerListTile(
                        text: "Home",
                        icon: Icons.home,
                        widget: StoreHome(),
                      ),
                      const DrawerDivider(),
                      DrawerListTile(
                        icon: Icons.shopping_basket,
                        text: "My Orders",
                        widget: MyOrders(),
                      ),
                      const DrawerDivider(),
                      DrawerListTile(
                        icon: Icons.shopping_cart,
                        text: "My Cart",
                        widget: CartPage(),
                      ),
                      const DrawerDivider(),
                      DrawerListTile(
                        icon:Icons.search,
                        text: "Search",
                        widget: SearchProduct(),
                      ),
                      const DrawerDivider(),
                      DrawerListTile(
                        icon: Icons.home_work_outlined,
                        text: "Add new address",
                        widget: AddAddress(),
                      ),
                      const DrawerDivider(),
                      const DrawerListTile(
                        icon: Icons.add_business_sharp,
                        text: "Add product",
                        widget: UploadPage(),
                      ),
                      const DrawerDivider(),
                  ListTile(
                    leading:  const Icon( Icons.logout ,color: Colors.white,size: 30,),
                    title:  const Text( "Logout",style: TextStyle(color: Colors.white, fontSize: 18),),
                    onTap: (){
                      EcommerceApp.sharedPreferences!.clear();
                      EcommerceApp.sharedPreferences!.commit();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Login()),
                            (Route<dynamic> route) => false,
                      );
                    },
                  ),

                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
