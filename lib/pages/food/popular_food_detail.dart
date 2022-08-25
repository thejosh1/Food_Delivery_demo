import 'package:flutter/material.dart';
import 'package:food_delivery_demo/controllers/cart_controller.dart';
import 'package:food_delivery_demo/controllers/popular_products_controller.dart';
import 'package:food_delivery_demo/pages/cart/cart_page.dart';
import 'package:food_delivery_demo/pages/home/main_food_page.dart';
import 'package:food_delivery_demo/routes/routes_helper.dart';
import 'package:food_delivery_demo/utils/app_constants.dart';
import 'package:food_delivery_demo/utils/colors.dart';
import 'package:food_delivery_demo/utils/dimensions.dart';
import 'package:food_delivery_demo/widgets/app_icons.dart';
import 'package:food_delivery_demo/widgets/app_column.dart';
import 'package:food_delivery_demo/widgets/big_text.dart';
import 'package:food_delivery_demo/widgets/expandable_widget.dart';
import 'package:get/get.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  const PopularFoodDetail({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductsController>().popularProductList[pageId];
   Get.find<PopularProductsController>().initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //background Image
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularFoodImgSize,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      AppConstants.BASE_URL+AppConstants.UPLOADS+product.img!,
                    ), fit: BoxFit.cover
                  ),
                ),
              )
          ),
          //Icon Widget
          Positioned(
              top: Dimensions.height45,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(onTap: (){Get.to(()=>const MainFoodPage());}, child: const AppIcons(icon: Icons.arrow_back_ios)),
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
                          controller.totalItems>=1?
                          Positioned(
                            top:0,
                            right:0,
                            child: AppIcons(
                              icon: Icons.circle,
                              iconcolor: Colors.transparent,
                              size: 20,
                              backgroundColor: AppColors.mainColor,)
                          ) :Container(),
                          controller.totalItems>=1?
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
              )
          ),
          //Food Details
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.popularFoodImgSize-20,
            child: Container(
              padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensions.radius20), topLeft: Radius.circular(Dimensions.radius20)),
                color: Colors.white
              ),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(text: product.name!,),
                  SizedBox(height: Dimensions.height10,),
                  BigText(text: "Introducing"),
                  SizedBox(height: Dimensions.height10,),
                  Expanded(
                    child: SingleChildScrollView(child:
                    ExpandableTextWidget(text:product.description!)
                    )
                  )
                ],
              )
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductsController>(builder: (popularProduct) {
        return Container(
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
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          popularProduct.setQuantity(false);
                        },
                        child: Icon(Icons.remove, color: AppColors.signColor,)),
                    SizedBox(width: Dimensions.width10/2,),
                    BigText(text: popularProduct.itemsInCart.toString()),
                    SizedBox(width: Dimensions.width10/2,),
                    GestureDetector(
                        onTap: (){
                          popularProduct.setQuantity(true);
                        },
                        child: Icon(Icons.add, color: AppColors.signColor,))
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  popularProduct.addItem(product);
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
        );
      },),
    );
  }
}
