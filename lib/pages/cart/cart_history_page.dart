import 'package:flutter/material.dart';
import 'package:food_delivery_demo/controllers/cart_controller.dart';
import 'package:food_delivery_demo/utils/app_constants.dart';
import 'package:food_delivery_demo/utils/colors.dart';
import 'package:food_delivery_demo/utils/dimensions.dart';
import 'package:food_delivery_demo/widgets/app_icons.dart';
import 'package:food_delivery_demo/widgets/big_text.dart';
import 'package:get/get.dart';

class CartHistoryPage extends StatelessWidget {
  const CartHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList = Get.find<CartController>().getCartHistoryList();
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

    List<int> itemsPerOrder = cartItemsPerOrderToList();



    var listCounter = 0;

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
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: Dimensions.width20, top: Dimensions.height20, right: Dimensions.width20),
              child: ListView(
                children: <Widget>[
                  for(int i =0; i<itemsPerOrder.length; i++)
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          BigText(text: "10/10/2022"),
                          SizedBox(height: Dimensions.height10),
                          Row(
                            children: <Widget>[
                              Wrap(
                                direction: Axis.horizontal,
                                children: List.generate(itemsPerOrder[i], (index) {
                                  if(listCounter<itemsPerOrder[i]) {
                                    listCounter++;
                                  }
                                  return Container(
                                    height: Dimensions.height100-20,
                                    width: Dimensions.width20*4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(Dimensions.width15/2),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          AppConstants.BASE_URL+AppConstants.UPLOADS+getCartHistoryList[listCounter-1].img!
                                        ), fit: BoxFit.cover
                                      )
                                    ),
                                  );
                                })
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
