import 'package:food_delivery_demo/data/api/api_client.dart';
import 'package:food_delivery_demo/model/sign_up_model.dart';
import 'package:food_delivery_demo/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences
  });
  
  Future<Response> registration(SignUpModel signUpModel) async {
    return await apiClient.postData(AppConstants.REGISTRATION_URI, signUpModel.toJson());
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  Future<String>getUserToken() async {
    return await sharedPreferences.getString(AppConstants.TOKEN)??"None";
  }

  Future<Response> login(String email, String password) async {
    return await apiClient.postData(AppConstants.LOGIN_URI, {"email":email, "password":password});
  }

  bool logOut() {
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.PASSWORD);
    sharedPreferences.remove(AppConstants.PHONE);
    apiClient.token = "";
    apiClient.updateHeader("");
    return true;
  }



  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<void> saveUserData(String phonenumber, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.PHONE, phonenumber);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    } catch(e) {
      print(e.toString());
    }
  }
}