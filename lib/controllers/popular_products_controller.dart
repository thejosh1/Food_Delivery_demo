import 'package:flutter/material.dart';
import 'package:food_delivery_demo/controllers/cart_controller.dart';
import 'package:food_delivery_demo/data/repositories/popular_products_repo.dart';
import 'package:food_delivery_demo/model/cart_model.dart';
import 'package:food_delivery_demo/model/product_model.dart';
import 'package:food_delivery_demo/utils/colors.dart';
import 'package:get/get.dart';

class PopularProductsController extends GetxController {
  final PopularProductsRepo popularProductsRepo;
  PopularProductsController({required this.popularProductsRepo});
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  int _quantity = 0;
  int get quantity => _quantity;
  int _itemsInCart = 0;
  int get itemsInCart => _itemsInCart+_quantity;

  Future<void> getPopularProductList() async {
    Response res = await popularProductsRepo.getPopularProductList();
    if(res.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(res.body).products);
      _isLoaded = true;
      update();
    } else {
      print("Error occurred and the error is "+res.body.toString());
    }

  }
  void setQuantity(bool isIncrement) {
    if(isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
      // print("number of items "+ _quantity.toString());
    } else {
      _quantity = checkQuantity(_quantity - 1);
      // print("Decrement quantity is now "+ _quantity.toString());
    }
    update();
  }

  int checkQuantity(int quantity) {
    if(itemsInCart+quantity < 0 ) {
      Get.snackbar("Items Count", "You can't reduce more",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white
      );
      if(_itemsInCart>0) {
        _quantity = -_itemsInCart;
        return _quantity;
      }
      return 0;
    } else if (itemsInCart+quantity > 20){
      Get.snackbar("Items Count", "You can't add more",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white
      );
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _itemsInCart = 0;
    _cart = cart;
    var _exits = false;
    _exits = _cart.existsInCart(product);
    // print("exists or not" + _exits.toString());

    if(_exits) {
      _itemsInCart = _cart.getQuantity(product);
    }
    // print("quantity in cart " + _itemsInCart.toString());
  }

  void addItem(ProductModel product) {
    if(_quantity > 0) {
      _cart.addItem(product, _quantity);
      _quantity = 0;
      _itemsInCart = _cart.getQuantity(product);
      _cart.items.forEach((key, value) {
        // print("the id is " + value.id.toString() + " the quantity is " + value.quantity.toString());
        update();
      });
    } else {
      Get.snackbar("Cart", "How many do you want to add",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white
      );
    }

  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}