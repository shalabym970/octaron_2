import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:octaron/Config/config.dart';
import 'package:octaron/Models/product.dart';
import 'package:octaron/Store/product_page.dart';
import 'package:octaron/const.dart';

class ProductTile extends StatelessWidget {
  final Product product;

  const ProductTile({required this.product});

  get removeCartFunction => null;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductPage(productModel: product)),
        );
      },
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 180,
                    width: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Image.network(
                      product.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                product.name,
                maxLines: 2,
                style: const TextStyle(
                    fontFamily: 'avenir', fontWeight: FontWeight.w800),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('\$${product.price}',
                      style: const TextStyle(fontSize: 20, fontFamily: 'avenir')),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: removeCartFunction == null
                        ? IconButton(
                        onPressed: () {
                          checkItemInCart(product.id.toString(), context);
                        },
                        icon: const Icon(
                          Icons.add_shopping_cart,
                          color: kSecondaryColor,
                        ))
                        : IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.delete ,
                          color: kSecondaryColor,
                        )),
                  )
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
void checkItemInCart(String productID, BuildContext context) {
  EcommerceApp.sharedPreferences!.getStringList(EcommerceApp.userCartList)!.contains(productID)
      ? Fluttertoast.showToast(msg: 'Item is already in cart')
      : addItemToCart(productID,context) ;
}

addItemToCart(String productID, BuildContext context) {
  List tempCartList = EcommerceApp.sharedPreferences!.getStringList(EcommerceApp.userCartList)!.cast<Product>();
  tempCartList.add(productID);
}
