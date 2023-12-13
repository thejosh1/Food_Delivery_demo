import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery_demo/controllers/popular_products_controller.dart';
import 'package:food_delivery_demo/controllers/recommended_products_controller.dart';
import 'package:food_delivery_demo/pages/home/food_page_builder.dart';
import 'package:food_delivery_demo/utils/colors.dart';
import 'package:food_delivery_demo/utils/dimensions.dart';
import 'package:food_delivery_demo/widgets/big_text.dart';
import 'package:food_delivery_demo/widgets/small_text.dart';
import 'package:get/get.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  Future<void> _loadResources() async{
    await Get.find<PopularProductsController>().getPopularProductList();
    await Get.find<RecommendedProductsController>().getRecommendedProductList();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return RefreshIndicator(child: Column(
      children: [
        //This handles the header section
        Container(
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.height15, bottom: Dimensions.height15),
              padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      BigText(text: "Nigeria", color: AppColors.mainColor,),
                      //SizedBox(height: Dimensions.height10,),
                      Row(
                        children: [
                          SmallText(text: "Lagos", color: Colors.black54,),
                          const Icon(Icons.arrow_drop_down_sharp)
                        ],
                      )
                    ],
                  ),
                  Center(
                    child: Container(
                      height: Dimensions.height45,
                      width: Dimensions.width45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius15),
                          color: AppColors.mainColor
                      ),
                      child: Icon(Icons.search, color: Colors.white, size: Dimensions.iconSize24,),
                    ),
                  )
                ],
              ),
            )
        ),
        //This handles the rest of the body
        const Expanded(child: SingleChildScrollView(child: FoodPageBuilder(),))
      ],
    ), onRefresh: _loadResources);
  }
}
