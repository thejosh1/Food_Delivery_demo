import 'package:flutter/material.dart';
import 'package:food_delivery_demo/controllers/cart_controller.dart';
import 'package:food_delivery_demo/controllers/popular_products_controller.dart';
import 'package:food_delivery_demo/controllers/recommended_products_controller.dart';
import 'package:food_delivery_demo/pages/cart/cart_page.dart';
import 'package:food_delivery_demo/routes/routes_helper.dart';
import 'package:food_delivery_demo/utils/app_constants.dart';
import 'package:food_delivery_demo/utils/colors.dart';
import 'package:food_delivery_demo/utils/dimensions.dart';
import 'package:food_delivery_demo/widgets/app_icons.dart';
import 'package:food_delivery_demo/widgets/big_text.dart';
import 'package:food_delivery_demo/widgets/expandable_widget.dart';
import 'package:get/get.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  const RecommendedFoodDetail({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<RecommendedProductsController>().recommendedProductList[pageId];
    Get.find<PopularProductsController>().initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 80,
            title: Container(
              margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(onTap: (){
                    Get.toNamed(RouteHelper.getInitial());
                  }, child: const AppIcons(icon: Icons.clear,)),
                  //AppIcons(icon: Icons.shopping_cart_outlined)
                  GetBuilder<PopularProductsController>(builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                        if(controller.totalItems>=1) {
                          Get.toNamed(RouteHelper.getCartPage());
                        }
                      },
                      child: Stack(
                        children: [
                          const AppIcons(icon: Icons.shopping_cart),
                          Get.find<PopularProductsController>().totalItems>=1?
                          Positioned(
                              top:0,
                              right:0,
                              child: AppIcons(icon: Icons.circle, iconcolor: Colors.transparent, size: 20, backgroundColor: AppColors.mainColor,))
                              :Container(),
                          Get.find<PopularProductsController>().totalItems>=1?
                          Positioned(
                              top:5,
                              right:6,
                              bottom: 5,
                              child: BigText(text: Get.find<PopularProductsController>().totalItems.toString(),
                                size: 12, color: Colors.white ,
                              )
                          )
                              :Container()
                        ],
                      ),
                    );
                  })
                ],
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensions.radius20), topLeft: Radius.circular(Dimensions.radius20))
                ),
                child: Center(child: BigText(text: product.name!, size: Dimensions.font26,)),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
              ),
            ),
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL+AppConstants.UPLOADS+product.img!,
                // "assets/image/food0.png",
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                  child: ExpandableTextWidget(text: product.description!,),
                )
              ]//ExpandableTextWidget
            )
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductsController>(builder:(controller){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: Dimensions.width20*2.5,
                  right: Dimensions.width20*2.5,
                  top: Dimensions.height10,
                  bottom: Dimensions.height10
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.setQuantity(false);
                    },
                    child: AppIcons(icon: Icons.remove, backgroundColor: AppColors.mainColor, iconcolor: Colors.white, iconSize: Dimensions.iconSize24,),
                  ),
                  BigText(text: " \$ ${product.price!} X ${controller.itemsInCart } ", color: AppColors.mainBlackColor, size: Dimensions.font26,),
                  GestureDetector(
                      onTap: () {
                        controller.setQuantity(true);
                      },
                      child: AppIcons(icon: Icons.add, backgroundColor: AppColors.mainColor, iconcolor: Colors.white, iconSize: Dimensions.iconSize24,)
                  )
                ],
              ),
            ),
            Container(
              height: Dimensions.bottomnavbarheight110,
              padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.radius20*2), topRight: Radius.circular(Dimensions.radius20*2)),
                  color: AppColors.buttonBackgroundColor
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(Dimensions.radius20)
                      ),
                      child: Icon(Icons.favorite, color: AppColors.mainColor,)
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.addItem(product);
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                      ),
                      child: BigText(text: "\$ ${product.price!} | Add to cart", color: Colors.white,),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      })
    );
  }
}
