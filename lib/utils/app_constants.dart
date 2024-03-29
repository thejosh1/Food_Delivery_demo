class AppConstants {
  static const String APP_NAME = "Food_Delivery_Demo";
  static const int APP_VERSION = 1;

  static const String BASE_URL = "http://127.0.0.1:8000";
  static const String POPULAR_PRODUCT_URI = "/api/v1/products/popular";
  static const String RECOMMENDED_PRODUCT_URI = "/api/v1/products/recommended";
  //static const String DRINKS_URI = "/api/v1/products/drinks";
  static const String UPLOADS = "/uploads/";

  //user and auth api endpoints
  static const String REGISTRATION_URI = "/api/v1/auth/register";
  static const String LOGIN_URI = "/api/v1/auth/login";
  static const String USER_INFO = "/api/v1/customer/info";

  static const String TOKEN = "";
  static const String PHONE = "";
  static const String PASSWORD = "";
  static const String CartKey = "Cart-list";
  static const String cartHistoryKey = "Cart-History-List";

  //google endpoint
  static const String GEOCODE_URI = "/api/v1/config/geocode-api";
  static const String ZONE_URI = "/api/v1/config/get-zone-id";
  static const String SEARCH_LOCATION_URI = "/api/v1/config/place-api-autocomplete";
  static const String PLACE_DETAIL_URI = "/api/v1/config/place-api-details";
  static const String USER_ADDRESS = "user_address";
  static const String ADD_USER_ADDRESS = "/api/v1/customer/address/add";
  static const String ADDRESS_LIST = "/api/v1/customer/address/list";
}