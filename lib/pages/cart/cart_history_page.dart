import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery_demo/base/no_data_page.dart';
import 'package:food_delivery_demo/controllers/cart_controller.dart';
import 'package:food_delivery_demo/model/cart_model.dart';
import 'package:food_delivery_demo/routes/routes_helper.dart';
import 'package:food_delivery_demo/utils/app_constants.dart';
import 'package:food_delivery_demo/utils/colors.dart';
import 'package:food_delivery_demo/utils/dimensions.dart';
import 'package:food_delivery_demo/widgets/app_icons.dart';
import 'package:food_delivery_demo/widgets/big_text.dart';
import 'package:food_delivery_demo/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistoryPage extends StatelessWidget {
  const CartHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList = Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder = {};

    for(int i=0; i<getCartHistoryList.length; i++) {
      if(cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartItemsTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();



    var listCounter = 0;
    Widget timeWidget(int index) {
      String outputDate = DateTime.now().toString();
      if(index<getCartHistoryList.length) {
        DateTime parseDate = DateFormat('yyyy-MM-dd HH:mm:ss').parse(getCartHistoryList[listCounter].time!);
        DateTime inputDate = DateTime.parse(parseDate.toString());
        DateFormat outputFormat = DateFormat('MM/dd/yyyy HH:mm a');
        outputDate = outputFormat.format(inputDate);
      }
      return BigText(text: outputDate);
    }

    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: Dimensions.height100,
            color: AppColors.mainColor,
            padding: EdgeInsets.only(top: Dimensions.height45-20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                BigText(text: "Cart History", color: Colors.white,),
                AppIcons(icon: Icons.shopping_cart_outlined, backgroundColor: AppColors.mainColor, iconcolor: Colors.white,)
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getCartHistoryList().isNotEmpty?Expanded(
              child: Container(
                margin: EdgeInsets.only(left: Dimensions.width20, top: Dimensions.height20, right: Dimensions.width20),
                child: ListView(
                  children: <Widget>[
                    for(int i =0; i<itemsPerOrder.length; i++)
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            timeWidget(listCounter),
                            SizedBox(height: Dimensions.height10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Wrap(
                                    direction: Axis.horizontal,
                                    children: List.generate(itemsPerOrder[i], (index) {
                                      if(listCounter<itemsPerOrder[i]) {
                                        listCounter++;
                                      }
                                      return index<=2?Container(
                                        height: Dimensions.height100-20,
                                        width: Dimensions.width20*4,
                                        margin: EdgeInsets.only(right: Dimensions.width10/2),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(Dimensions.width15/2),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    AppConstants.BASE_URL+AppConstants.UPLOADS+getCartHistoryList[listCounter-1].img!
                                                ), fit: BoxFit.cover
                                            )
                                        ),
                                      ):Container();
                                    })
                                ),
                                Container(
                                  height: Dimensions.height100-20,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SmallText(text:"Total items"),
                                      BigText(text: itemsPerOrder[i].toString()+" Items", color: AppColors.titleColor,),
                                      GestureDetector(
                                        onTap: () {
                                          var orderTime = cartItemsTimeToList();
                                          Map<int, CartModel> moreOrder = {};
                                          for(int j=0; j<getCartHistoryList.length; j++) {
                                            if(getCartHistoryList[j].time==orderTime[i]) {
                                              moreOrder.putIfAbsent(getCartHistoryList[j].id!, () =>
                                                  CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j]))));
                                            }
                                          }
                                          Get.find<CartController>().setItems = moreOrder;
                                          Get.find<CartController>().addToCartList();
                                          Get.toNamed(RouteHelper.getCartPage() );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: Dimensions.width10, vertical: Dimensions.height10/2),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(Dimensions.radius15/3),
                                              border: Border.all(color: AppColors.mainColor, width: 1)
                                          ),
                                          child: SmallText(text: "One more", color: AppColors.mainColor,),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )

                  ],
                ),
              ),
            ):SizedBox(
                height: MediaQuery.of(context).size.height/1.5,
                child: const Center(child: NoDataPage(text: "You haven't bought anything", imgPath: "assets/image/empty_box.png",)));
          })
        ],
      ),
    );
  }
}
