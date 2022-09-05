import 'package:flutter/material.dart';
import 'package:food_delivery_demo/controllers/popular_products_controller.dart';
import 'package:food_delivery_demo/controllers/recommended_products_controller.dart';
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
    return GetBuilder<PopularProductsController>(builder: (_) {
      return GetBuilder<RecommendedProductsController>(builder: (_) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          initialRoute: RouteHelper.SPLASHSCREEN,
          getPages: RouteHelper.ROUTES,
        );
      });
    });
  }
}

