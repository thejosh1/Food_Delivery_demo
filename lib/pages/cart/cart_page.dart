import 'package:flutter/material.dart';
import 'package:food_delivery_demo/controllers/cart_controller.dart';
import 'package:food_delivery_demo/controllers/popular_products_controller.dart';
import 'package:food_delivery_demo/controllers/recommended_products_controller.dart';
import 'package:food_delivery_demo/pages/home/main_food_page.dart';
import 'package:food_delivery_demo/routes/routes_helper.dart';
import 'package:food_delivery_demo/utils/app_constants.dart';
import 'package:food_delivery_demo/utils/colors.dart';
import 'package:food_delivery_demo/utils/dimensions.dart';
import 'package:food_delivery_demo/widgets/app_icons.dart';
import 'package:food_delivery_demo/widgets/big_text.dart';
import 'package:food_delivery_demo/widgets/small_text.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: Dimensions.height20*3,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: AppIcons(icon: Icons.arrow_back_ios,
                      iconcolor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimensions.iconSize24,
                    ),
                  ),
                  SizedBox(width: Dimensions.width20*5),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcons(icon: Icons.home_outlined,
                      iconcolor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimensions.iconSize24,
                    ),
                  ),
                  AppIcons(icon: Icons.shopping_cart,
                    iconcolor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                ],
              )
          ),
          Positioned(
              top: Dimensions.height20*5,
              left: Dimensions.width20,
              right: Dimensions.width20,
              bottom: 0,
              child: Container(
                margin: EdgeInsets.only(top: Dimensions.height15),
                //color: Colors.red,
                child: GetBuilder<CartController>(builder: (cartController) {
                  var _cartList = cartController.getItems;
                  return ListView.builder(
                      itemCount: _cartList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: Dimensions.height20*5,
                          width: double.maxFinite,
                          child: Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  var popularProductIndex = Get.find<PopularProductsController>()
                                      .popularProductList
                                      .indexOf(_cartList[index].product!);
                                  if(popularProductIndex >= 0) {
                                    Get.toNamed(RouteHelper.getPopularFoods(popularProductIndex));
                                  } else {
                                    var recommendeedProductIndex = Get.find<RecommendedProductsController>()
                                        .recommendedProductList
                                        .indexOf(_cartList[index].product!);
                                    Get.toNamed(RouteHelper.getRecommendedFoods(recommendeedProductIndex));
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: Dimensions.height10),
                                  height: Dimensions.height20*5,
                                  width: Dimensions.width20*5,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(AppConstants.BASE_URL+AppConstants.UPLOADS+cartController.getItems[index].img!),
                                          fit: BoxFit.cover
                                      ),
                                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                                      color: Colors.white
                                  ),
                                ),
                              ),
                              SizedBox(width: Dimensions.width10,),
                              Expanded(
                                  child: Container(
                                    height: Dimensions.height20*5,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        BigText(text: cartController.getItems[index].name!, color: Colors.black54,),
                                        SmallText(text: "Spicy"),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            BigText(text: cartController.getItems[index].price!.toString(), color: Colors.redAccent,),
                                            Container(
                                              padding: EdgeInsets.only(top: Dimensions.height10, bottom: Dimensions.height10, left: Dimensions.width10, right: Dimensions.width10),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(Dimensions.radius20)
                                              ),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                      onTap: () {
                                                        cartController.addItem(_cartList[index].product!, -1);
                                                        print("being tapped");
                                                      },
                                                      child: Icon(Icons.remove, color: AppColors.signColor,)),
                                                  SizedBox(width: Dimensions.width10/2,),
                                                  BigText(text: _cartList[index].quantity.toString()), //popularProduct.itemsInCart.toString()),
                                                  SizedBox(width: Dimensions.width10/2,),
                                                  GestureDetector(
                                                      onTap: (){
                                                        cartController.addItem(_cartList[index].product!, 1);
                                                        print("being tapped");
                                                      },
                                                      child: Icon(Icons.add, color: AppColors.signColor,))
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                              )
                            ],
                          ),
                        );
                      });
                },)
              )
          )
        ],
      ),
    );
  }
}

