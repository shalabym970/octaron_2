import 'dart:convert';
import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:octaron/Admin/adminShiftOrders.dart';
import 'package:octaron/Config/config.dart';
import 'package:octaron/Counters/cart_item_counter.dart';
import 'package:octaron/Store/cart.dart';
import 'package:octaron/Widgets/add_product_list_tile.dart';
import 'package:octaron/Widgets/loading_widget.dart';
import 'package:octaron/Widgets/my_drawer.dart';
import 'package:octaron/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as ImD;
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../const.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage>
    with AutomaticKeepAliveClientMixin<UploadPage> {
  @override
  bool get wantKeepAlive => true;
  File? file;

  List brandList = [
    'Apple',
    'Samsung',
    'Sony',
    'Dell',
    'Hp',
    'Lenovo',
    'Ula',
    'Toshiba',
    'Other'
  ];
  List categoryList = [
    'mobile',
    'Laptop',
    'PC',
    'accessories',
    'Parts',
    'Other',
  ];

  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _descriptionEditingController =
      TextEditingController();
  final TextEditingController _priceEditingController = TextEditingController();
  String productID = DateTime.now().millisecondsSinceEpoch.toString();
  bool uploading = false;
  String? brandValue;
  String? categoryValue;

  @override
  Widget build(BuildContext context) {
    return file == null && brandValue == null && categoryValue == null
        ? displayAdminHomeScreen()
        : displayAdminUploadFormScreen();
  }

  displayAdminHomeScreen() {
    return Scaffold(
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
      drawer: MyDrawer(),
      body: getAdminHomeScreenBody(),
    );
  }

  getAdminHomeScreenBody() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [kBackgroundColor, kBackgroundColor],
          begin: FractionalOffset(0.0, 0.0),
          end: FractionalOffset(0.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shop_two,
              color: kPrimaryColor,
              size: 200.0,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton.icon(
                onPressed: () {
                  takeImage(context);
                },
                label: const Text('Add New Item',
                    style:
                        TextStyle(fontSize: 20.0, color: kTextAndIconsColor)),
                icon: const Icon(Icons.add),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  textStyle: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  takeImage(mContext) {
    return showDialog(
        context: mContext,
        builder: (con) {
          return SimpleDialog(
            title: const Text(
              'Item Image',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            children: [
              SimpleDialogOption(
                child: const Text(
                  'Capture with camera',
                  style: TextStyle(color: kSecondaryColor),
                ),
                onPressed: capturePhotoWithCamera,
              ),
              SimpleDialogOption(
                child: const Text(
                  'Select from gallery',
                  style: TextStyle(color: kSecondaryColor),
                ),
                onPressed: pickPhotoFromGallery,
              ),
              SimpleDialogOption(
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: kSecondaryColor),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  capturePhotoWithCamera() async {
    Navigator.pop(context);
    final image = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxHeight: 680.0, maxWidth: 970);
    if (image == null) return;
    final imageFile = File(image.path);
    setState(() {
      file = imageFile;
    });
  }

  void pickPhotoFromGallery() async {
    Navigator.pop(context);
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageFile = File(image.path);
    setState(() {
      file = imageFile;
    });
  }

  displayAdminUploadFormScreen() {
    return Scaffold(
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
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: kTextAndIconsColor,
          ),
          onPressed: () {
            clearFormInfo();
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (BuildContext context) {
              return const UploadPage();
            }));
          },
        ),
        title: const Text(
          "New Product",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              uploadImageAndSaveItemInfo();
              // uploading ? null : uploadImageAndSaveItemInfo();
            },
            label: const Text('Add',
                style: TextStyle(fontSize: 16.0, color: kTextAndIconsColor)),
            icon: const Icon(Icons.add),
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              textStyle:
                  const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          uploading
              ? circularProgress()
              : const Center(
                  child: Text(
                  'Image uploaded successfully',
                  style: TextStyle(color: Colors.green),
                )),
          SizedBox(
            height: 230,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: FileImage(file!), fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 12)),
          //using for add title into new Product
          AddProductListTile(
              icon: Icons.title,
              keyboardType: TextInputType.text,
              hint: 'Title',
              controller: _titleEditingController),
          const Divider(
            color: kSecondaryColor,
          ),
          //using for select category into new Product

          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: DropdownButtonFormField<String>(
                hint: const Text(
                  'Category',
                  style: TextStyle(color: Colors.grey),
                ),
                dropdownColor: kSecondaryColor,
                icon: const Icon(Icons.arrow_drop_down),
                iconDisabledColor: kPrimaryColor,
                iconEnabledColor: kSecondaryColor,
                iconSize: 36,
                isExpanded: true,
                style: const TextStyle(color: Colors.black, fontSize: 18),
                items: categoryList.map((valueItem) {
                  return DropdownMenuItem<String>(
                    value: valueItem,
                    child: Text(valueItem),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    categoryValue = newValue.toString();
                  });
                },
                value: categoryValue,
                onSaved: (value) {}),
          ),
          //using for add Description into new product
          AddProductListTile(
              icon: Icons.description,
              keyboardType: TextInputType.text,
              hint: 'Description',
              controller: _descriptionEditingController),
          const Divider(
            color: kSecondaryColor,
          ),
          //using for add price into new product
          AddProductListTile(
              icon: Icons.price_check_sharp,
              keyboardType: TextInputType.number,
              hint: 'Price',
              controller: _priceEditingController),
          const Divider(
            color: kSecondaryColor,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: DropdownButtonFormField<String>(
                hint: const Text(
                  'Brand',
                  style: TextStyle(color: Colors.grey),
                ),
                dropdownColor: kSecondaryColor,
                icon: const Icon(Icons.arrow_drop_down),
                iconDisabledColor: kPrimaryColor,
                iconEnabledColor: kSecondaryColor,
                iconSize: 36,
                isExpanded: true,
                style: const TextStyle(color: Colors.black, fontSize: 18),
                items: brandList.map((valueItem) {
                  return DropdownMenuItem<String>(
                    value: valueItem,
                    child: Text(valueItem),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    brandValue = newValue.toString();
                  });
                },
                value: brandValue,
                onSaved: (value) {}),
          ),
        ],
      ),
    );
  }

  clearFormInfo() {
    file = null;
    categoryValue = null;
    brandValue = null;
    _descriptionEditingController.clear();
    _priceEditingController.clear();
    _titleEditingController.clear();
  }

  uploadImageAndSaveItemInfo() async {
    print('****************');
    setState(() {
      uploading = true;
    });
    var url = Uri.parse('$apiUrl/api/productapi');
    var response = await http.post(url, body: {
      'user_id': "1",
      'name': _titleEditingController.text,
      'image': file != null ? 'product_$productID.jpg' : '',
      'category': categoryValue,
      'productdesc': _descriptionEditingController.text,
      'price': _priceEditingController.text,
      'brand': brandValue,
      'qnt': '1'
    }, headers: {
      'Accept': "application/json",
      'Authorization': 'Bearer ' +
          EcommerceApp.sharedPreferences!.getString('token').toString(),
    });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    print(response.statusCode);

    if (response.statusCode == 201) {
      clearFormInfo();
      uploading = false;
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
        return const UploadPage();
      }));
      Flushbar(
        icon: const ImageIcon(
          AssetImage('assets/images/baseline_emoji_emotions_black_24dp.png'),
          size: 40,
          color: Colors.green,
        ),
        titleSize: 20,
        message: 'Your product has been successfully added',
        messageColor: Colors.green,
        duration: const Duration(seconds: 10),
      ).show(context);
    } else {
      setState(() {
        uploading = false;
      });
      Flushbar(
        icon: const ImageIcon(
          AssetImage(
              'assets/images/baseline_sentiment_very_dissatisfied_black_24dp.png'),
          size: 40,
          color: Colors.red,
        ),
        titleSize: 20,
        title: "Sorry....",
        message: 'Your product has not been added',
        messageColor: Colors.red,
        duration: const Duration(seconds: 10),
      ).show(context);
    }
  }
}
