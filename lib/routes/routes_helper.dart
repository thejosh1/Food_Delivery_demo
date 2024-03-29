import 'package:food_delivery_demo/pages/address/add_address_page.dart';
import 'package:food_delivery_demo/pages/auth/login_page.dart';
import 'package:food_delivery_demo/pages/cart/cart_page.dart';
import 'package:food_delivery_demo/pages/food/popular_food_detail.dart';
import 'package:food_delivery_demo/pages/food/recommended_food_details.dart';
import 'package:food_delivery_demo/pages/home/home_page.dart';
import 'package:food_delivery_demo/pages/splash/splash_screen.dart';
import 'package:get/get.dart';

import '../pages/address/pick_address_map.dart';

class RouteHelper{
  static const SPLASHSCREEN = "/splash-screen";
  static const INITIAL = "/";
  static const POPULARFOODS = "/popular-foods";
  static const RECOMMENDEDFOODS = "/recommended-foods";
  static const CARTPAGE = "/cart-page";
  static const LOGINPAGE = "/login-page";
  static const ADDADDRESSPAGE = "/add-address-page";
  static const PICKADDRESSMAP = "/pick-address-map";

  static String getSplashScreen() => "$SPLASHSCREEN";
  static String getInitial() => "$INITIAL";
  static String getPopularFoods(int pageId, String page) => "$POPULARFOODS?pageId=$pageId&page=$page";
  static String getRecommendedFoods(int pageId, String page) => "$RECOMMENDEDFOODS?pageId=$pageId&page=$page";
  static String getCartPage() => "$CARTPAGE";
  static String getLoginPage() => "$LoginPage";
  static String getAddAddressPage() => "$ADDADDRESSPAGE";
  static String getPickAddressMap() => "$PICKADDRESSMAP";

  //list of routes to pages
  static List<GetPage> ROUTES = [
    GetPage(name: SPLASHSCREEN, page: ()=>const SplashScreen()),
    GetPage(name: INITIAL, page: ()=>const HomePage()),
    GetPage(name: LOGINPAGE, page: () {
      return const LoginPage();
    }, transition: Transition.fade),
    GetPage(name: POPULARFOODS, page: (){
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters["page"];
      return PopularFoodDetail(pageId: int.parse(pageId!), page:page!);
    },
      transition: Transition.fadeIn
    ),
    GetPage(name: RECOMMENDEDFOODS, page: (){
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];
      return RecommendedFoodDetail(pageId: int.parse(pageId!), page:page!);

    },
        transition: Transition.fadeIn
    ),

    GetPage(name: CARTPAGE, page: (){
      return const CartPage();
    },
      transition: Transition.fadeIn
    ),
    GetPage(name: ADDADDRESSPAGE, page: () {
      return const AddAddressPage();
    }),
    GetPage(name: PICKADDRESSMAP, page: () {
       PickAddressMap _pickAddressMap = Get.arguments;
       return _pickAddressMap;
    },
      transition: Transition.fadeIn
    )
  ];
}