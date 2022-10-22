import 'package:food_delivery_demo/data/repositories/auth_repo.dart';
import 'package:food_delivery_demo/model/response_model.dart';
import 'package:food_delivery_demo/model/sign_up_model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({
    required this.authRepo
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> registration(SignUpModel signUpModel) async {
    _isLoading = true;
    update();
    Response res = await authRepo.registration(signUpModel);
    late ResponseModel responseModel;
    if(res.statusCode=="200") {
      authRepo.saveUserToken(res.body["token"]);
      responseModel = ResponseModel(true, res.body["token"]);
    } else {
      responseModel = ResponseModel(false, res.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }
}