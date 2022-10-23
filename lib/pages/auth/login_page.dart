import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_demo/base/custom_loader.dart';
import 'package:food_delivery_demo/pages/auth/sign_up_page.dart';
import 'package:food_delivery_demo/routes/routes_helper.dart';
import 'package:food_delivery_demo/utils/colors.dart';
import 'package:food_delivery_demo/utils/dimensions.dart';
import 'package:food_delivery_demo/widgets/app_text_field.dart';
import 'package:food_delivery_demo/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../base/show_custom_snackbar.dart';
import '../../controllers/auth_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    _login(AuthController authController) {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      if(email.isEmpty) {
        ShowCustomSnackBar("Type in Your email", title: "Name");
      } else if(!GetUtils.isEmail(email)) {
        ShowCustomSnackBar("Your email is not in the correct format", title: "Invalid email");
      } else if(password.length < 6) {
        ShowCustomSnackBar("Password is too short", title: "Invalid Password");
      } else {

        authController.login(email, password).then((status) {
          if(status.isSuccess) {
            Get.toNamed(RouteHelper.INITIAL);
          } else {
            ShowCustomSnackBar(status.message, title: "Error");
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController) {
        return !_authController.isLoading?SingleChildScrollView(
          physics: const  BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              SizedBox(height: Dimensions.screenHeight*0.05,),
              //app logo
              Container(
                height: Dimensions.screenHeight*0.25,
                child: Center(
                  child: CircleAvatar(
                    radius: Dimensions.height100-20,
                    backgroundImage: const AssetImage("assets/image/logo part 1.png"),
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: Dimensions.width20, bottom: Dimensions.height20),
                child: Column(
                  children: [
                    Text("Hello", style: TextStyle(fontSize: Dimensions.font20*3 + Dimensions.font20/2, fontWeight: FontWeight.bold),),
                    Text("Sign in to your account", style: TextStyle(fontSize: Dimensions.font20, color: Colors.grey[500]))
                  ],
                ),
              ),
              //email
              AppTextField(textEditingController: _emailController, hintText: "Email", iconData: Icons.email, color: AppColors.yellowColor),
              SizedBox(height: Dimensions.height20,),
              //password
              AppTextField(textEditingController: _passwordController, hintText: "password", iconData: Icons.password_sharp, color: AppColors.yellowColor, isObscure: true,),
              SizedBox(height: Dimensions.height20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RichText(
                      text: TextSpan(
                          text: "Sign in to your account",
                          style: TextStyle(color: Colors.grey[500], fontSize: Dimensions.font20)
                      )
                  ),
                  SizedBox(width: Dimensions.width10,)
                ],
              ),
              SizedBox(height: Dimensions.screenHeight*0.10,),
              //login
              GestureDetector(
                onTap: () {
                  _login(_authController);
                },
                child: Container(
                  width: Dimensions.screenWidth/2,
                  height: Dimensions.screenHeight/13,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color: AppColors.mainColor
                  ),
                  child: Center(child: BigText(text: "Login", size: Dimensions.font20+Dimensions.font20/2, color: Colors.white,)),
                ),
              ),
              SizedBox(height: Dimensions.screenHeight*0.010,),
              //sign up with
              RichText(
                  text: TextSpan(
                      text: "Don\'t have an account? ",
                      style: TextStyle(color: Colors.grey[500], fontSize: Dimensions.font16),
                      children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>const SignUpPage(), transition: Transition.fade),
                            text: "Create",
                            style: TextStyle(color: AppColors.mainBlackColor, fontSize: Dimensions.font16, fontWeight: FontWeight.bold)
                        )
                      ]
                  )
              ),
            ],
          ),
        ):const CustomLoader();
      }),
    );
  }
}
