import 'package:food_delivery_demo/controllers/cart_controller.dart';
import 'package:food_delivery_demo/data/repositories/popular_products_repo.dart';
import 'package:food_delivery_demo/model/popular_product_model.dart';
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
      print("Error occurred and the error is "+res.body);
    }

  }
  void setQuantity(bool isIncrement) {
    if(isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if(quantity < 0) {
      return 0;
    } else if (quantity > 20){
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(CartController cart) {
    _quantity = 0;
    _itemsInCart = 0;
    _cart = cart;
  }

  void addItem(ProductModel product) {
    _cart.addItem(product, _quantity);
  }
}