import 'dart:convert';

import 'package:food_delivery_demo/data/repositories/cart_repo.dart';
import 'package:food_delivery_demo/model/cart_model.dart';
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

    sharedPreferences.setStringList("Cart-list", cart);
    print(sharedPreferences.getStringList("Cart-list"));
  }

}