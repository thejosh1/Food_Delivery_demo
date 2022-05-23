import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:food_delivery_demo/controllers/popular_products_controller.dart';
import 'package:food_delivery_demo/controllers/recommended_products_controller.dart';
import 'package:food_delivery_demo/model/popular_product_model.dart';
import 'package:food_delivery_demo/pages/food/popular_food_detail.dart';
import 'package:food_delivery_demo/routes/routes_helper.dart';
import 'package:food_delivery_demo/utils/app_constants.dart';
import 'package:food_delivery_demo/utils/colors.dart';
import 'package:food_delivery_demo/utils/dimensions.dart';
import 'package:food_delivery_demo/widgets/app_column.dart';
import 'package:food_delivery_demo/widgets/big_text.dart';
import 'package:food_delivery_demo/widgets/icon_and_text_widget.dart';
import 'package:food_delivery_demo/widgets/small_text.dart';
import 'package:get/get.dart';

class FoodPageBuilder extends StatefulWidget {
  const FoodPageBuilder({Key? key}) : super(key: key);

  @override
  State<FoodPageBuilder> createState() => _FoodPageBuilderState();
}

class _FoodPageBuilderState extends State<FoodPageBuilder> {
  PageController pageController = PageController(viewportFraction: 0.85);

  var _currentPageValue = 0.0;
  var _scaleFactor = 0.8;
  double _height = Dimensions.pageContainer;


  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });

    @override
    void dispose() {
      pageController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    print("The Screen Width is " + MediaQuery.of(context).size.width.toString());
    return Column(
      children: [
        GetBuilder<PopularProductsController>(builder: (popularProducts) {
          return popularProducts.isLoaded?Container(
              height: Dimensions.pageView,
              child: PageView.builder(
                controller: pageController,
                itemCount: popularProducts.popularProductList.length,
                itemBuilder: (context, index) {
                  return _buildPageItem(index, popularProducts.popularProductList[index]);
                },)
          ):CircularProgressIndicator(color: AppColors.mainColor,);
        }),
       GetBuilder<PopularProductsController>(builder: (popularProducts){
         return  DotsIndicator(
           dotsCount: popularProducts.popularProductList.isEmpty?1:popularProducts.popularProductList.length,
           position: _currentPageValue,
           decorator: DotsDecorator(
             activeColor: AppColors.mainColor,
             size: const Size.square(9.0),
             activeSize: const Size(18.0, 9.0),
             activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)
             ),
           ),
         );
       }),
        //Popular text
        SizedBox(height: Dimensions.height30,),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommended"),
              SizedBox(width: Dimensions.width10,),
              Container(margin: const EdgeInsets.only(bottom: 3),child: BigText(text: ".", color: Colors.black26,),),
              SizedBox(width: Dimensions.width10,),
              Container(margin: const EdgeInsets.only(bottom: 2),child: SmallText(text: "FoodPairing"),)
            ],
          ),
        ),
        SizedBox(height: Dimensions.height10,),
        //List of foods
        GetBuilder<RecommendedProductsController>(builder: (recommendedProducts) {
          return recommendedProducts.isLoaded?ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: recommendedProducts.recommendedProductList.length,
              itemBuilder: (context, index,) {
                return GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getRecommendedFoods());
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, bottom: Dimensions.height10),
                    child: Row(
                      children: [
                        //image section
                        Container(
                          height: Dimensions.listViewSize,
                          width: Dimensions.listViewSize,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.radius20),
                              color: Colors.white10,
                              image: DecorationImage(
                                  image: NetworkImage(
                                    AppConstants.BASE_URL+AppConstants.UPLOADS+recommendedProducts.recommendedProductList[index].img!
                                  ), fit: BoxFit.cover
                              )
                          ),
                        ),
                        //text Section
                        Expanded(
                          child: Container(
                            height: Dimensions.height100,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensions.radius20), bottomRight: Radius.circular(Dimensions.radius20))
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BigText(text: recommendedProducts.recommendedProductList[index].name!, overflow: TextOverflow.ellipsis,),
                                  SizedBox(height: Dimensions.height10,),
                                  SmallText(text: recommendedProducts.recommendedProductList[index].name!),
                                  SizedBox(height: Dimensions.height10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconAndTextWidget(icon: Icons.circle_sharp, text: "Normal", iconColor: AppColors.iconColor1,),
                                      IconAndTextWidget(icon: Icons.location_on_outlined, text: "1.7km", iconColor: AppColors.mainColor),
                                      IconAndTextWidget(icon: Icons.access_time_filled_rounded, text: "15 mins", iconColor: AppColors.iconColor2)
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }):CircularProgressIndicator(color: AppColors.mainColor,);
        })

      ],
    );
  }
  Widget _buildPageItem(int index, ProductModel popularProduct){
    Matrix4 matrix = new Matrix4.identity();
    if(index==_currentPageValue.floor()){
      var _currScale = 1-(_currentPageValue - index) * (1 - _scaleFactor);
      var _currTrans = _height*(1-_currScale)/2;
      matrix = Matrix4.diagonal3Values(1, _currScale, 1)..setTranslationRaw(0, _currTrans, 0);
    } else if (index==_currentPageValue.floor()+1) {
      var _currScale = _scaleFactor+(_currentPageValue - index + 1) * (1 - _scaleFactor);
      var _currTrans = _height*(1-_currScale)/2;
      matrix = Matrix4.diagonal3Values(1, _currScale, 1)..setTranslationRaw(1, _currTrans, 1);
    } else if (index==_currentPageValue.floor()-1) {
      var _currScale = 1-(_currentPageValue - index) * (1 - _scaleFactor);
      var _currTrans = _height*(1-_currScale)/2;
      matrix = Matrix4.diagonal3Values(1, _currScale, 1)..setTranslationRaw(1, _currTrans, 1);
    } else {
      var _currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, _currScale, 1)..setTranslationRaw(0, _height*(1 - _currScale), 1);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){
              Get.toNamed(RouteHelper.getPopularFoods(index));
            },
            child: Container(
              height: Dimensions.pageContainer,
              margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: index.isEven?Colors.blue:Color(0xFF9294cc),
                  image: DecorationImage(
                      image: NetworkImage(AppConstants.BASE_URL+AppConstants.UPLOADS+ popularProduct.img!),
                      fit: BoxFit.cover
                  )
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageTextContainer,
              margin: EdgeInsets.only(left: Dimensions.width30, right: Dimensions.width30, bottom: Dimensions.height30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5)
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, 0)
                    ),
                    BoxShadow(
                        color: Colors.white,
                        offset: Offset(5, 0)
                    ),
                  ]
              ),
              child: Container(
                padding: EdgeInsets.only(top: Dimensions.height15, left: Dimensions.width15, right: Dimensions.width10),
                child: AppColumn(text: popularProduct.name!,),
              ),
            ),
          )
        ],
      ),
    );
  }
  
}


