import 'package:flutter/material.dart';
import 'package:food_delivery_demo/base/custom_loader.dart';
import 'package:food_delivery_demo/controllers/auth_controller.dart';
import 'package:food_delivery_demo/controllers/cart_controller.dart';
import 'package:food_delivery_demo/routes/routes_helper.dart';
import 'package:food_delivery_demo/utils/colors.dart';
import 'package:food_delivery_demo/utils/dimensions.dart';
import 'package:food_delivery_demo/widgets/account_widget.dart';
import 'package:food_delivery_demo/widgets/app_icons.dart';
import 'package:food_delivery_demo/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../controllers/location_controller.dart';
import '../../controllers/user_controller.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    if(_isLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        title: BigText(
          text: "Profile", size: Dimensions.height20+4, color: Colors.white,
        ),
      ),
      body: GetBuilder<UserController>(builder: (_userController) {
        return _isLoggedIn?(_userController.isLoading?Container(
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
                          bigText: BigText(text: _userController.userModel.name,)
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
                          bigText: BigText(text: _userController.userModel.phone,)
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
                          bigText: BigText(text: _userController.userModel.email,)
                      ),
                      SizedBox(height: Dimensions.height10/2,),
                      //address
                      GetBuilder<LocationController>(builder: (locationController){
                        if(_isLoggedIn&&locationController.addressList.isEmpty) {
                          return GestureDetector(
                            onTap: () {
                              Get.offNamed(RouteHelper.ADDADDRESSPAGE);
                            },
                            child: AccountWidget(
                                appIcons: AppIcons(icon: Icons.location_on,
                                  iconcolor: Colors.white,
                                  iconSize: Dimensions.height10*5/2,
                                  backgroundColor: AppColors.mainColor,
                                  size: Dimensions.height10*5,
                                ),
                                bigText: BigText(text: "Fill in your address")
                            ),
                          );
                        } else {
                          return GestureDetector(
                            onTap: () {
                              Get.offNamed(RouteHelper.ADDADDRESSPAGE);
                            },
                            child: AccountWidget(
                                appIcons: AppIcons(icon: Icons.location_on,
                                  iconcolor: Colors.white,
                                  iconSize: Dimensions.height10*5/2,
                                  backgroundColor: AppColors.mainColor,
                                  size: Dimensions.height10*5,
                                ),
                                bigText: BigText(text: "Your Address")
                            ),
                          );
                        }
                      }),
                      SizedBox(height: Dimensions.height10/2,),
                      //messages
                      AccountWidget(
                          appIcons: AppIcons(icon: Icons.message_outlined,
                            iconcolor: Colors.white,
                            iconSize: Dimensions.height10*5/2,
                            backgroundColor: Colors.redAccent,
                            size: Dimensions.height10*5,
                          ),
                          bigText: BigText(text: "Message",)
                      ),
                      SizedBox(height: Dimensions.height10/2,),
                      GestureDetector(
                        onTap: () {
                          if(Get.find<AuthController>().isLoggedIn()) {
                            Get.find<AuthController>().loggedOut();
                            Get.find<CartController>().clear();
                            Get.find<CartController>().clearCartHistory();
                            Get.find<LocationController>().clearAddressList();
                            Get.offAllNamed(RouteHelper.INITIAL);
                          } else {
                            print("Already logged out");
                          }
                        },
                        child: AccountWidget(
                            appIcons: AppIcons(icon: Icons.logout,
                              iconcolor: Colors.white,
                              iconSize: Dimensions.height10*5/2,
                              backgroundColor: Colors.redAccent,
                              size: Dimensions.height10*5,
                            ),
                            bigText: BigText(text: "Logout",)
                        ),
                      ),
                      SizedBox(height: Dimensions.height10/2,)
                    ],
                  ),
                ),
              )
            ],
          ),
        ):const CustomLoader()):Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.maxFinite,
              height: Dimensions.height20*8,
              margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          "assets/image/signintocontinue.png"
                      )
                  )
              ),
            ),
            GestureDetector(
              onTap: (){
                Get.toNamed(RouteHelper.LOGINPAGE);
              },
              child: Container(
                width: double.maxFinite,
                height: Dimensions.height20*5,
                margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                ),
                child: Center(child: BigText(text: "Sign in", color: Colors.white, size: Dimensions.font20,)),
              ),
            ),
          ],
        ),);
      }),
    );
  }
}
