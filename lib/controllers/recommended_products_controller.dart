import 'package:food_delivery_demo/data/repositories/recommended_products_repo.dart';
import 'package:food_delivery_demo/model/popular_product_model.dart';
import 'package:get/get.dart';

class RecommendedProductsController extends GetxController {
  final RecommendedProductsRepo recommendedProductsRepo;
  RecommendedProductsController({required this.recommendedProductsRepo});
  List<ProductModel> _recommendedProductList = [];
  List<ProductModel> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedProductList() async {
    Response res = await recommendedProductsRepo.getRecommendedProductList();
    if(res.statusCode == 200) {
      print("got products");
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(res.body).products);
      //print(_popularProductList);
      _isLoaded = true;
      update();
    } else {
      print("Error occurred and the error is "+res.body);
    }

  }
}