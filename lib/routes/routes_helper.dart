import 'package:food_delivery_demo/pages/food/popular_food_detail.dart';
import 'package:food_delivery_demo/pages/food/recommended_food_details.dart';
import 'package:food_delivery_demo/pages/home/main_food_page.dart';
import 'package:get/get.dart';

class RouteHelper{
  static const INITIAL = "/";
  static const POPULARFOODS = "/popular-foods";
  static const RECOMMENDEDFOODS = "/recommended-foods";

  static String getInitial() => "$INITIAL";
  static String getPopularFoods(int pageId) => "$POPULARFOODS?pageId=$pageId";
  static String  getRecommendedFoods(int pageId) => "$RECOMMENDEDFOODS?pageId=$page";

  //lsit of routes to pages
  static List<GetPage> ROUTES = [
    GetPage(name: INITIAL, page: ()=>const MainFoodPage()),
    GetPage(name: POPULARFOODS, page: (){
      var pageId = Get.parameters['pageId'];
      return PopularFoodDetail(pageId: int.parse(pageId!));
    },
      transition: Transition.fadeIn
    ),
    GetPage(name: RECOMMENDEDFOODS, page: (){
      var pageId = Get.parameters['pageId'];
      return const RecommendedFoodDetail(pageId: int.parse(pageId!));
    },
        transition: Transition.fadeIn
    )
  ];
}