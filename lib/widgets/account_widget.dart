import 'package:flutter/material.dart';
import 'package:food_delivery_demo/utils/dimensions.dart';
import 'package:food_delivery_demo/widgets/app_icons.dart';
import 'package:food_delivery_demo/widgets/big_text.dart';

class AccountWidget extends StatelessWidget {
  AppIcons appIcons;
  BigText bigText;
  AccountWidget({Key? key, required this.appIcons, required this.bigText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.height100-40,
      margin: EdgeInsets.only(top: Dimensions.height10, bottom: Dimensions.height10, left: Dimensions.width10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            offset: const Offset(0, 2),
            color: Colors.grey.withOpacity(0.2)
          )
        ]
      ),
      child: Row(
        children: <Widget>[
          appIcons,
          SizedBox(width: Dimensions.width20,),
          bigText
        ],
      ),
    );
  }
}
