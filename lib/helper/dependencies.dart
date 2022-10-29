import 'package:food_delivery_demo/controllers/auth_controller.dart';
import 'package:food_delivery_demo/controllers/cart_controller.dart';
import 'package:food_delivery_demo/controllers/popular_products_controller.dart';
import 'package:food_delivery_demo/controllers/recommended_products_controller.dart';
import 'package:food_delivery_demo/data/api/api_client.dart';
import 'package:food_delivery_demo/data/repositories/auth_repo.dart';
import 'package:food_delivery_demo/data/repositories/cart_repo.dart';
import 'package:food_delivery_demo/data/repositories/popular_products_repo.dart';
import 'package:food_delivery_demo/data/repositories/recommended_products_repo.dart';
import 'package:food_delivery_demo/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/user_controller.dart';
import '../data/repositories/user_repo.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  //shared preferences
  Get.lazyPut(() => sharedPreferences);
  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));

  //popular productrepo
  Get.lazyPut(() => PopularProductsRepo(apiClient: Get.find()));
  //recommended products repo
  Get.lazyPut(() => RecommendedProductsRepo(apiClient: Get.find()));
  //cart repo
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  //auth repo
  Get.lazyPut(() => AuthRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
  //user repo
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));

  //recommmended products controller
  Get.lazyPut(() => RecommendedProductsController(recommendedProductsRepo: Get.find()));
  //popular products controller
  Get.lazyPut(() => PopularProductsController(popularProductsRepo: Get.find()));
  //cart controller
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  //AuthController
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  //UserController
  Get.lazyPut(() => UserController(userRepo: Get.find()));

}