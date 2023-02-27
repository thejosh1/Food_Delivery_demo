import 'package:flutter/material.dart';
import 'package:food_delivery_demo/controllers/cart_controller.dart';
import 'package:food_delivery_demo/controllers/popular_products_controller.dart';
import 'package:food_delivery_demo/controllers/recommended_products_controller.dart';
import 'package:food_delivery_demo/routes/routes_helper.dart';
import 'package:food_delivery_demo/utils/colors.dart';
import 'package:get/get.dart';


import 'controllers/user_controller.dart';
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
        return GetBuilder<UserController>(builder: (_) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Food_Delivery_Demo',
            //home: LoginPage(),
            initialRoute: RouteHelper.SPLASHSCREEN,
            getPages: RouteHelper.ROUTES,
            theme: ThemeData(
              primaryColor: AppColors.mainColor,
              fontFamily: "Lato",
            )
          );
        });
      });
    });
  }
}

