import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:octaron/Config/config.dart';
import 'package:octaron/Store/cart.dart';
import 'package:octaron/Store/product_page.dart';
import 'package:octaron/Counters/cart_item_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:octaron/Widgets/product_tile.dart';
import 'package:octaron/const.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Widgets/my_drawer.dart';
import '../Widgets/search_box.dart';
import '../Models/product.dart';

double width = 1;

class StoreHome extends StatefulWidget {
  const StoreHome({Key? key}) : super(key: key);

  @override
  _StoreHomeState createState() => _StoreHomeState();
}

class _StoreHomeState extends State<StoreHome> {
  Future<List<Product>> fetchProduct() async {
    SharedPreferences.getInstance();
    final response =
        await http.get(Uri.parse('$apiUrl/api/productapi'),headers: {
          'Authorization':'Bearer '+EcommerceApp.sharedPreferences!.getString('token').toString()
        });
    log("response.body");
    log(response.body);
    log('Response body: ${response.body}');

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      return Product.fromJsonList(jsonDecode(response.body)['products']);

    } else {
      throw Exception('Failed to load product');
    }
  }

  List<Product>? futureProducts;

  @override
  void initState() {
    super.initState();

    fetchProduct().then((value) {
      setState(() {
        futureProducts = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [kPrimaryColor, kSecondaryColor],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(0.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
          ),
          title: const Text(
            "Octaron",
            style: TextStyle(
              fontSize: 55.0,
              color: kTextAndIconsColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            Stack(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.shopping_cart,
                    color: kTextAndIconsColor,
                  ),
                  onPressed: () {
                    Route route = MaterialPageRoute(builder: (c) => CartPage());
                    Navigator.pushReplacement(context, route);
                  },
                ),
                Positioned(
                    child: Stack(
                  children: [
                    const Icon(
                      Icons.brightness_1,
                      size: 20.0,
                      color: Colors.green,
                    ),
                    Positioned(
                        top: 3.0,
                        bottom: 4.0,
                        left: 6.0,
                        child: Consumer<CartItemCounter>(
                          builder: (context, counter, _) {
                            return Text(
                              counter.count.toString(),
                              style: const TextStyle(
                                color: kTextAndIconsColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            );
                          },
                        ))
                  ],
                ))
              ],
            )
          ],
        ),
        drawer: const MyDrawer(),
        body: futureProducts == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                      pinned: true, delegate: SearchBoxDelegate()),
                  SliverStaggeredGrid.countBuilder(
                      crossAxisCount: 2,
                      itemCount: futureProducts!.length,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      itemBuilder: (context, index) {
                        return  ProductTile(
                              product: futureProducts![index],
                            );
                      },
                      staggeredTileBuilder: (index) =>
                          const StaggeredTile.fit(1)),
                ],
              ),
      ),
    );
  }
}

Widget card({Color primaryColor = Colors.redAccent, required String imgPath}) {
  return Container();
}

