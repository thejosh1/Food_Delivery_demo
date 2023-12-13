import 'package:flutter/material.dart';
import 'package:food_delivery_demo/widgets/big_text.dart';
import 'package:food_delivery_demo/widgets/small_text.dart';
import 'package:get/get.dart';

void ShowCustomSnackBar(String message, {bool isError=true, String title="Error"}) {
  Get.snackbar(title, message,
    titleText: BigText(text: title, color: Colors.white,),
    messageText: SmallText(text: message, color: Colors.white,),
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.redAccent
  );
}