import 'package:food_delivery_demo/controllers/cart_controller.dart';
import 'package:food_delivery_demo/data/repositories/cart_repo.dart';
import 'package:food_delivery_demo/model/cart_model.dart';
import 'package:food_delivery_demo/model/popular_product_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  Map<int, CartModel> _items= {};

  void addItem(ProductModel product, int quantity){
    if(_items.containsKey(product.id!)) {
      _items.update(product.id!, (value) {
        return CartModel(
            id: value.id,
            name: value.name,
            price: value.price,
            img: value.img,
            quantity: value.quantity! + quantity,
            isExist: true,
            time: DateTime.now().toString()
        );
      });
    } else {
      _items.putIfAbsent(product.id!, () {
        return CartModel(
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.img,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString()
        );
      });
    }

  }
}