import 'package:food_delivery_demo/data/repositories/popular_products_repo.dart';
import 'package:food_delivery_demo/model/popular_product_model.dart';
import 'package:get/get.dart';

class PopularProductsController extends GetxController {
  final PopularProductsRepo popularProductsRepo;
  PopularProductsController({required this.popularProductsRepo});
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getPopularProductList() async {
    Response res = await popularProductsRepo.getPopularProductList();
    if(res.statusCode == 200) {
      print("got products");
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(res.body).products);
      //print(_popularProductList);
      _isLoaded = true;
      update();
    } else {
      print("Error occurred and the error is "+res.body);
    }

  }
}