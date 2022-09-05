import 'package:food_delivery_demo/controllers/cart_controller.dart';
import 'package:food_delivery_demo/controllers/popular_products_controller.dart';
import 'package:food_delivery_demo/controllers/recommended_products_controller.dart';
import 'package:food_delivery_demo/data/api/api_client.dart';
import 'package:food_delivery_demo/data/repositories/cart_repo.dart';
import 'package:food_delivery_demo/data/repositories/popular_products_repo.dart';
import 'package:food_delivery_demo/data/repositories/recommended_products_repo.dart';
import 'package:food_delivery_demo/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  //shared preferences
  Get.lazyPut(() => sharedPreferences);
  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //popular productrepo
  Get.lazyPut(() => PopularProductsRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductsRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));

  //popular product controller
  Get.lazyPut(() => RecommendedProductsController(recommendedProductsRepo: Get.find()));
  Get.lazyPut(() => PopularProductsController(popularProductsRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}