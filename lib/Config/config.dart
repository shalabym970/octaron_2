import 'package:shared_preferences/shared_preferences.dart';
import 'package:octaron/Models/product.dart';

class EcommerceApp
{
   final Product product;
   static const String appName = 'Octaron';
   static SharedPreferences ? sharedPreferences;

   static String collectionUser = "users";
   static String collectionOrders = "orders";
   static String userCartList = 'userCart';
   static String subCollectionAddress = 'userAddress';

   static const String userName = 'name';
   static const String userEmail = 'email';
   static const String userPhotoUrl = 'photoUrl';
   static  String? userUID = EcommerceApp.sharedPreferences!.getString('user_id');
   static const String userAvatarUrl = 'url';

   static const String addressID = 'addressID';
   static const String totalAmount = 'totalAmount';
   String get productID => product.id.toString();
   static const String paymentDetails ='paymentDetails';
   static const String orderTime ='orderTime';
   static const String isSuccess ='isSuccess';

  EcommerceApp(this.product);

}