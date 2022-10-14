import 'package:flutter/material.dart';
import 'package:food_delivery_demo/data/repositories/cart_repo.dart';
import 'package:food_delivery_demo/model/cart_model.dart';
import 'package:food_delivery_demo/model/product_model.dart';
import 'package:food_delivery_demo/utils/colors.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  Map<int, CartModel> _items= {};

  Map<int, CartModel> get items=> _items;

  List<CartModel> storageItems = [];

  void addItem(ProductModel product, int quantity){
    var totalQuantity = 0;
    if(_items.containsKey(product.id!)) {
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
            id: value.id,
            name: value.name,
            price: value.price,
            img: value.img,
            quantity: value.quantity! + quantity,
            isExist: true,
            time: DateTime.now().toString(),
          product: product
        );
      });
      if(totalQuantity <= 0) {
        _items.remove(product.id);
      }
    } else {
      if(quantity > 0) {
        _items.putIfAbsent(product.id!, () {
          return CartModel(
              id: product.id,
              name: product.name,
              price: product.price,
              img: product.img,
              quantity: quantity,
              isExist: true,
              time: DateTime.now().toString(),
              product: product,
          );
        });
      } else {
        Get.snackbar("Cart", "You haven't added any item to cart",
            backgroundColor: AppColors.mainColor,
            colorText: Colors.white
        );
      }
    }
    cartRepo.addToCarList(getItems);
    update();
  }

  bool existsInCart(ProductModel product) {
    if(_items.containsKey(product.id)) {
      return true;
    }
    return false;
  }

  int getQuantity(ProductModel product) {
    var quantity = 0;
    if(_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if(key==product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  int get totalAmount {
    var totalprice = 0;
    _items.forEach((key, value) {
      totalprice += value.quantity!*value.price!;
    });

    return totalprice;
  }

  List<CartModel> get getItems {
   return _items.entries.map((e) {
     return e.value;
   }).toList();
  }

  List<CartModel> getCartdata() {
    setCart = cartRepo.getCartList();

    return storageItems;
  }

  set setCart(List<CartModel> item) {
    storageItems = item;
    // print("Number of items is "+storageItems.length.toString());
    for(int i = 0; i<storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  void addtoCartHistoryList() {
    cartRepo.addToCartHistoryList();
    clear();
  }

  void clear() {
    _items = {};
    update();
  }

  set setItems(Map<int, CartModel> setItems) {
    _items = {};
    _items = setItems;
  }

  List<CartModel> getCartHistoryList() {
    return cartRepo.getcartHistoryList();
  }

  void addToCartList() {
    cartRepo.addToCarList(getItems);
    update();
  }
} 