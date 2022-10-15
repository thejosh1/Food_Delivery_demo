import 'package:flutter/material.dart';
import 'package:food_delivery_demo/utils/colors.dart';
import 'package:food_delivery_demo/utils/dimensions.dart';
import 'package:food_delivery_demo/widgets/account_widget.dart';
import 'package:food_delivery_demo/widgets/app_icons.dart';
import 'package:food_delivery_demo/widgets/big_text.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        title: BigText(
          text: "Profile", size: Dimensions.height20+4, color: Colors.white,
        ),
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: Dimensions.height20),
        child: Column(
          children: <Widget>[
            AppIcons(icon: Icons.person,
              iconcolor: Colors.white,
              iconSize: Dimensions.height100-25,
              backgroundColor: AppColors.mainColor,
              size: Dimensions.height100+50,
            ),
            SizedBox(height: Dimensions.height30,),
            //profile icon
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    AccountWidget(
                        appIcons: AppIcons(icon: Icons.person,
                          iconcolor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          backgroundColor: AppColors.mainColor,
                          size: Dimensions.height10*5,
                        ),
                        bigText: BigText(text: "Joshua",)
                    ),
                    SizedBox(height: Dimensions.height10/2,),
                    //phone
                    AccountWidget(
                        appIcons: AppIcons(icon: Icons.phone,
                          iconcolor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          backgroundColor: AppColors.yellowColor,
                          size: Dimensions.height10*5,
                        ),
                        bigText: BigText(text: "+2349160364381",)
                    ),
                    SizedBox(height: Dimensions.height10/2,),
                    //email
                    AccountWidget(
                        appIcons: AppIcons(icon: Icons.email,
                          iconcolor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          backgroundColor: AppColors.yellowColor,
                          size: Dimensions.height10*5,
                        ),
                        bigText: BigText(text: "ziritetechnologies@gmail.com",)
                    ),
                    SizedBox(height: Dimensions.height10/2,),
                    //address
                    AccountWidget(
                        appIcons: AppIcons(icon: Icons.location_on,
                          iconcolor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          backgroundColor: AppColors.mainColor,
                          size: Dimensions.height10*5,
                        ),
                        bigText: BigText(text: "Fill in your address")
                    ),
                    SizedBox(height: Dimensions.height10/2,),
                    //messages
                    AccountWidget(
                        appIcons: AppIcons(icon: Icons.message_outlined,
                          iconcolor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          backgroundColor: Colors.redAccent,
                          size: Dimensions.height10*5,
                        ),
                        bigText: BigText(text: "Joshua",)
                    ),
                    SizedBox(height: Dimensions.height10/2,)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
