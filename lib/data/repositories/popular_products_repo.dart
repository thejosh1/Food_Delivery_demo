import 'package:get/get.dart';
import 'package:food_delivery_demo/data/api/api_client.dart';
import 'package:food_delivery_demo/utils/app_constants.dart';

class PopularProductsRepo extends GetxService {
  final ApiClient apiClient;

  PopularProductsRepo({required this.apiClient});

  Future<Response> getPopularProductList()async {
    return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URI);
  }
}