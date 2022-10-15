import 'package:flutter/material.dart';
import 'package:food_delivery_demo/utils/colors.dart';
import 'package:food_delivery_demo/utils/dimensions.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          SizedBox(height: Dimensions.screenHeight*0.05,),
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
            margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 7,
                  offset: Offset(1, 10),
                  color: Colors.grey.withOpacity(0.2)
                )
              ]
            ),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: "Email",
                prefixIcon: Icon(Icons.email, color: AppColors.yellowColor,),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  borderSide: const BorderSide(
                    width: 1.0,
                    color: Colors.white
                  )
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    borderSide: const BorderSide(
                        width: 1.0,
                        color: Colors.white
                    )
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}
