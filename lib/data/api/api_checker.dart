import 'package:food_delivery_demo/base/show_custom_snackbar.dart';
import 'package:food_delivery_demo/routes/routes_helper.dart';
import 'package:get/get.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if(response.statusCode==401) {
      Get.offNamed(RouteHelper.LOGINPAGE);
    } else {
      ShowCustomSnackBar(response.statusText!);
    }
  }
}