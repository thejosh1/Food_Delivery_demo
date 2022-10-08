import 'dart:convert';

import 'package:food_delivery_demo/model/cart_model.dart';
import 'package:food_delivery_demo/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo{
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  void addToCarList(List<CartModel> cartList) {
    cart = [];
    //convert object to string because of sharedpreferences
    cartList.forEach((element) { 
      return cart.add(jsonEncode(element));
    });

    sharedPreferences.setStringList(AppConstants.CartKey, cart);
    //print(sharedPreferences.getStringList(AppConstants.CartKey));
    getCartList();
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if(sharedPreferences.containsKey(AppConstants.CartKey)) {
      carts = sharedPreferences.getStringList(AppConstants.CartKey)!;
    }
    List<CartModel> cartList = [];
    carts.forEach((element)=>cartList.add(CartModel.fromJson(jsonDecode(element))));
    return cartList;
  }

}