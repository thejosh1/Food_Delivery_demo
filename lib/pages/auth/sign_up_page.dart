import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_demo/utils/colors.dart';
import 'package:food_delivery_demo/utils/dimensions.dart';
import 'package:food_delivery_demo/widgets/app_text_field.dart';
import 'package:food_delivery_demo/widgets/big_text.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _phoneNumberController = TextEditingController();
    List signUpImages = [
      "g.png",
      "t.png",
      "f.png"
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
            //name
            AppTextField(textEditingController: _nameController, hintText: "Name", iconData: Icons.person, color: AppColors.yellowColor),
            SizedBox(height: Dimensions.height20,),
            //email
            AppTextField(textEditingController: _emailController, hintText: "Email", iconData: Icons.email, color: AppColors.yellowColor),
            SizedBox(height: Dimensions.height20,),
            //password
            AppTextField(textEditingController: _passwordController, hintText: "password", iconData: Icons.password_sharp, color: AppColors.yellowColor),
            SizedBox(height: Dimensions.height20,),
            //phone number
            AppTextField(textEditingController: _phoneNumberController, hintText: "Phone Number", iconData: Icons.phone_android_outlined, color: AppColors.yellowColor),
            SizedBox(height: Dimensions.height20,),

            Container(
              width: Dimensions.screenWidth/2,
              height: Dimensions.screenHeight/13,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: AppColors.mainColor
              ),
              child: Center(child: BigText(text: "Sign Up", size: Dimensions.font20+Dimensions.font20/2, color: Colors.white,)),
            ),
            SizedBox(height: Dimensions.height10,),
            //tagline
            RichText(
                text: TextSpan(
                  recognizer: TapGestureRecognizer()..onTap=()=>Get.back,
                  text: "Have an account already",
                  style: TextStyle(color: Colors.grey[500], fontSize: Dimensions.font20)
                )
            ),
            SizedBox(height: Dimensions.screenHeight*0.010,),
            //sign up with
            RichText(
                text: TextSpan(
                    text: "Or sign up with:",
                    style: TextStyle(color: Colors.grey[500], fontSize: Dimensions.font16)
                )
            ),
            Wrap(
              children: List.generate(3, (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: Dimensions.radius30,
                  backgroundImage: AssetImage("assets/image/"+signUpImages[index]),
                ),
              )),
            )
          ],
        ),
      ),
    );
  }
}
