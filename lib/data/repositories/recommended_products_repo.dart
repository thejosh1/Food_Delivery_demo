import 'package:get/get.dart';
import 'package:food_delivery_demo/data/api/api_client.dart';
import 'package:food_delivery_demo/utils/app_constants.dart';

class RecommendedProductsRepo extends GetxService {
  final ApiClient apiClient;

  RecommendedProductsRepo({required this.apiClient});

  Future<Response> getRecommendedProductList()async {
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
  }
}