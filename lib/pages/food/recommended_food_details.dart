import 'package:flutter/material.dart';
import 'package:food_delivery_demo/utils/colors.dart';
import 'package:food_delivery_demo/utils/dimensions.dart';
import 'package:food_delivery_demo/widgets/app_icons.dart';
import 'package:food_delivery_demo/widgets/big_text.dart';
import 'package:food_delivery_demo/widgets/expandable_widget.dart';
import 'package:get/get.dart';

class RecommendedFoodDetail extends StatelessWidget {
  const RecommendedFoodDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 80,
            title: Container(
              margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcons(icon: Icons.clear,),
                  AppIcons(icon: Icons.shopping_cart_outlined)
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
                child: Center(child: BigText(text: "Amala Delicacy", size: Dimensions.font26,)),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
              ),
            ),
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "assets/image/food0.png",
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
                  child: ExpandableTextWidget(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Faucibus in ornare quam viverra orci sagittis eu volutpat odio. Ullamcorper malesuada proin libero nunc consequat interdum varius sit. Non pulvinar neque laoreet suspendisse interdum consectetur libero id faucibus. Sem fringilla ut morbi tincidunt augue interdum. At urna condimentum mattis pellentesque id. Volutpat diam ut venenatis tellus. Sed arcu non odio euismod lacinia at. Fringilla est ullamcorper eget nulla facilisi etiam dignissim diam quis. Praesent elementum facilisis leo vel fringilla est. Eros donec ac odio tempor orci dapibus. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Faucibus in ornare quam viverra orci sagittis eu volutpat odio. Ullamcorper malesuada proin libero nunc consequat interdum varius sit. Non pulvinar neque laoreet suspendisse interdum consectetur libero id faucibus. Sem fringilla ut morbi tincidunt augue interdum. At urna condimentum mattis pellentesque id. Volutpat diam ut venenatis tellus. Sed arcu non odio euismod lacinia at. Fringilla est ullamcorper eget nulla facilisi etiam dignissim diam quis. Praesent elementum facilisis leo vel fringilla est. Eros donec ac odio tempor orci dapibus. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Faucibus in ornare quam viverra orci sagittis eu volutpat odio. Ullamcorper malesuada proin libero nunc consequat interdum varius sit. Non pulvinar neque laoreet suspendisse interdum consectetur libero id faucibus. Sem fringilla ut morbi tincidunt augue interdum. At urna condimentum mattis pellentesque id. Volutpat diam ut venenatis tellus. Sed arcu non odio euismod lacinia at. Fringilla est ullamcorper eget nulla facilisi etiam dignissim diam quis. Praesent elementum facilisis leo vel fringilla est. Eros donec ac odio tempor orci dapibus. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Faucibus in ornare quam viverra orci sagittis eu volutpat odio. Ullamcorper malesuada proin libero nunc consequat interdum varius sit. Non pulvinar neque laoreet suspendisse interdum consectetur libero id faucibus. Sem fringilla ut morbi tincidunt augue interdum. At urna condimentum mattis pellentesque id. Volutpat diam ut venenatis tellus. Sed arcu non odio euismod lacinia at. Fringilla est ullamcorper eget nulla facilisi etiam dignissim diam quis. Praesent elementum facilisis leo vel fringilla est. Eros donec ac odio tempor orci dapibus.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. FaucibLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. FaucibLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. FaucibLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. FaucibLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. FaucibLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. FaucibLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. FaucibvLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. FaucibvLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. FaucibLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. FaucibLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. FaucibLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. FaucibLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. FaucibLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. FaucibLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. FaucibLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. FaucibLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Faucib")),
              ],
            )
          )
        ],
      ),
    );
  }
}
