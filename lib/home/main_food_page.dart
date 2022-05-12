import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery_demo/widgets/small_text.dart';
import '../utils/colors.dart';
import '../widgets/big_text.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      //resizeToAvoidBottomInset: false,

      body: Column(
        children: [
          Container(
              child: Container(
                margin: EdgeInsets.only(top: 15, bottom: 15),
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        BigText(text: "Nigeria", color: AppColors.mainColor,),
                        const SizedBox(height: 5,),
                        Row(
                          children: [
                            SmallText(text: "Lagos", color: Colors.black54,),
                            Icon(Icons.arrow_drop_down_sharp)
                          ],
                        )
                      ],
                    ),
                    Center(
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.mainColor
                        ),
                        child: Icon(Icons.search, color: Colors.white,),
                      ),
                    )
                  ],
                ),
              )
          ),
        ],
      )
    );
  }
}
