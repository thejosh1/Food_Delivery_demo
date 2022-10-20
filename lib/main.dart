import 'package:flutter/material.dart';
import 'package:food_delivery_demo/controllers/cart_controller.dart';
import 'package:food_delivery_demo/controllers/popular_products_controller.dart';
import 'package:food_delivery_demo/controllers/recommended_products_controller.dart';
import 'package:food_delivery_demo/pages/auth/login_page.dart';
import 'package:food_delivery_demo/pages/auth/sign_up_page.dart';
import 'package:food_delivery_demo/pages/food/recommended_food_details.dart';
import 'package:food_delivery_demo/pages/home/food_page_builder.dart';
import 'package:food_delivery_demo/pages/home/main_food_page.dart';
import 'package:food_delivery_demo/pages/splash/splash_screen.dart';
import 'package:food_delivery_demo/routes/routes_helper.dart';
import 'package:get/get.dart';
import 'package:food_delivery_demo/pages/food/popular_food_detail.dart';
import 'package:food_delivery_demo/pages/food/recommended_food_details.dart';

import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartdata();
    return GetBuilder<PopularProductsController>(builder: (_) {
      return GetBuilder<RecommendedProductsController>(builder: (_) {
        return const GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Food_Delivery_Demo',
          home: LoginPage(),
          // initialRoute: RouteHelper.SPLASHSCREEN,
          // getPages: RouteHelper.ROUTES,
        );
      });
    });
  }
}

