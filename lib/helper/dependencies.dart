import 'package:food_delivery_demo/controllers/popular_products_controller.dart';
import 'package:food_delivery_demo/data/api/api_client.dart';
import 'package:food_delivery_demo/data/repositories/popular_products_repo.dart';
import 'package:get/get.dart';

Future<void> init() async {

  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: "http://mvs.bslmeiyu.com"));

  //popular productrepo
  Get.lazyPut(() => PopularProductsRepo(apiClient: Get.find()));

  //popular product controller
  Get.lazyPut(() => PopularProductsController(popularProductsRepo: Get.find()));

}