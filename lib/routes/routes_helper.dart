import 'package:food_delivery_demo/pages/cart/cart_page.dart';
import 'package:food_delivery_demo/pages/food/popular_food_detail.dart';
import 'package:food_delivery_demo/pages/food/recommended_food_details.dart';
import 'package:food_delivery_demo/pages/home/home_page.dart';
import 'package:food_delivery_demo/pages/home/main_food_page.dart';
import 'package:food_delivery_demo/pages/splash/splash_screen.dart';
import 'package:get/get.dart';

class RouteHelper{
  static const SPLASHSCREEN = "/splash-screen";
  static const INITIAL = "/";
  static const POPULARFOODS = "/popular-foods";
  static const RECOMMENDEDFOODS = "/recommended-foods";
  static const CARTPAGE = "/cart-page";

  static String getSplashScreen() => "$SPLASHSCREEN";
  static String getInitial() => "$INITIAL";
  static String getPopularFoods(int pageId, String page) => "$POPULARFOODS?pageId=$pageId&page=$page";
  static String getRecommendedFoods(int pageId, String page) => "$RECOMMENDEDFOODS?pageId=$pageId&page=$page";
  static String getCartPage() => "$CARTPAGE";

  //list of routes to pages
  static List<GetPage> ROUTES = [
    GetPage(name: SPLASHSCREEN, page: ()=>const SplashScreen()),
    GetPage(name: INITIAL, page: ()=>const HomePage()),
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
  ];
}