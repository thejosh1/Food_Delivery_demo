import 'package:get/get.dart';

class Dimensions{
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

//container sizes for pageview
  static double pageContainer = screenHeight/3.3;
  static double pageTextContainer = screenHeight/6.11;
  static double pageView = screenHeight/2.29;

  //dynamic height padding and margin
  static double height10 = screenHeight/73.3;
  static double height20 = screenHeight/36.65;
  static double height15 = screenHeight/48.9;
  static double height30 = screenHeight/24.4;
  static double height45 = screenHeight/16.3;
  static double height100 = screenHeight/7.33;

  //dynamic width padding and margin
  static double width10 = screenHeight/73.3;
  static double width20 = screenHeight/36.65;
  static double width30 = screenHeight/24.4;
  static double width15 = screenHeight/48.9;
  static double width45 = screenHeight/16.3;

  //font size
  static double font16 = screenHeight/45.81;
  static double font20 = screenHeight/36.65;
  static double font26 = screenHeight/28.2;

  //fontheight 1.2
  static double fontheight = screenHeight/610.8;

  //dynamic radius size
  static double radius20 = screenHeight/36.65;
  static double radius30 = screenHeight/24.4;
  static double radius15 = screenHeight/48.9;

  //dynamic icon size
  static double iconSize24 = screenHeight/30.5;
  static double iconSize16 = screenHeight/45.8;

  //dynamic list size
  static double listViewSize = screenWidth/3;
  static double listTextConSize = screenWidth;

  //popular food
  static double popularFoodImgSize = screenHeight/2.09;

  //bottomnavbarheight
  static double bottomnavbarheight110 = screenHeight/6.66;

  //textHeight
  static double textheight100 = screenHeight/7.3;

  //splash screen dimensions
  static double splashimg = screenHeight/2.93;
}