import 'dart:convert';

import 'package:food_delivery_demo/model/cart_model.dart';
import 'package:food_delivery_demo/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo{
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});


  List<String> cart = [];
  List<String> cartHistoryList = [];
  void addToCarList(List<CartModel> cartList) {
    //convert object to string because of sharedpreferences
    // sharedPreferences.remove(AppConstants.CartKey);
    // sharedPreferences.remove(AppConstants.cartHistoryKey);
    var time = DateTime.now().toString();
    cart = [];

    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });

    sharedPreferences.setStringList(AppConstants.CartKey, cart);
    print(sharedPreferences.getStringList(AppConstants.CartKey));
    //getCartList();
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

  List<CartModel> getcartHistoryList() {
    if(sharedPreferences.containsKey(AppConstants.cartHistoryKey)) {
      cartHistoryList = [];
      cartHistoryList = sharedPreferences.getStringList(AppConstants.cartHistoryKey)!;
    }
    List<CartModel> cartListHistory = [];
    cartHistoryList.forEach((element)=>cartListHistory.add(CartModel.fromJson(jsonDecode(element))));
    return cartListHistory;
  }

  void addToCartHistoryList() {
    if(sharedPreferences.containsKey(AppConstants.cartHistoryKey)) {
      cartHistoryList = sharedPreferences.getStringList(AppConstants.cartHistoryKey)!;
    }
    for(int i = 0; i < cart.length; i++) {
      // print("History list "+ cart[i]);
      cartHistoryList.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(AppConstants.cartHistoryKey, cartHistoryList);
    print("History length is "+getcartHistoryList().length.toString());
    for(int i = 0; i<getcartHistoryList().length; i++) {
      print("the time of the order is "+getcartHistoryList()[i].time.toString());
    }
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove(AppConstants.CartKey);
  }

}