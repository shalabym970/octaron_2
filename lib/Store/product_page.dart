import 'dart:developer';

import 'package:octaron/Widgets/custom_app_bar.dart';
import 'package:octaron/Widgets/my_drawer.dart';
import 'package:octaron/Models/product.dart';
import 'package:flutter/material.dart';
import 'package:octaron/Store/store_home.dart';

import '../const.dart';


class ProductPage extends StatefulWidget {
  final Product productModel;


  const ProductPage({Key? key,required this.productModel}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}



class _ProductPageState extends State<ProductPage> {
  int quantityOfItems = 1;

  @override
  Widget build(BuildContext context)
  {
    Size screenSize= MediaQuery.of(context).size;
    return  SafeArea(
      child: Scaffold(
        appBar: MyAppBar(),
        drawer: const MyDrawer(),
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(15.0),
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Stack(
                     children: [
                       Center(
                         child: Image.network(
                           widget.productModel.image,
                           fit: BoxFit.cover,
                         ),
                       ),
                       Container(
                         color: Colors.grey[300],
                         child: const SizedBox(
                           height: 1.0,
                           width: double.infinity,
                         ),
                       )
                     ],
                   ),
                  Container(
                    padding: const EdgeInsets.all(20),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              widget.productModel.name,
                              style: boldTextStyle ,
                            ),
                          ),
                          const SizedBox(
                            height: 10.0 ,
                          ),

                          Text(
                            widget.productModel.productdesc,
                          ),
                          const SizedBox(
                            height: 10.0 ,
                          ),
                          Text(
                           "\$"+  widget.productModel.price.toString(),
                            style: boldTextStyle ,
                          ),
                          const SizedBox(
                            height: 10.0 ,
                          )
                        ],
                      ),

                  ),
                   Padding(
                    padding: EdgeInsets.only(top:8.0),
                    child: Center(
                      child: InkWell(
                        onTap: ()=> log('clicked'),
                        child: Container(
                          decoration:  const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [kPrimaryColor, kSecondaryColor],
                              begin: FractionalOffset(0.0, 0.0),
                              end: FractionalOffset(0.0, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp,
                            ),
                          ),
                          width: MediaQuery.of(context).size.width - 40.0,
                          height: 50.0,
                           child: const Center(
                             child: Text('Add to Cart', style: TextStyle(color: Colors.white ),),
                           ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}

const boldTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
const largeTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 20);
