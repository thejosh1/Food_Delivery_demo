import 'package:get/get.dart';
import 'package:food_delivery_demo/data/api/api_client.dart';

class PopularProductsRepo extends GetxService {
  final ApiClient apiClient;

  PopularProductsRepo({required this.apiClient});

  Future<Response> getPopularProductList()async {
    return await apiClient.getData("/api/v1/products/popular");
  }
}