import 'package:get/get.dart';

import '../data/repositories/user_repo.dart';
import '../model/response_model.dart';
import '../model/user_model.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;

  UserController({
    required this.userRepo
  });

  bool _isLoading = false;
  late UserModel _userModel;

  bool get isLoading => _isLoading;
  UserModel get userModel => _userModel;

  Future<ResponseModel> getUserInfo() async {
    Response res = await userRepo.getUserInfo();
    late ResponseModel responseModel;
    if (res.statusCode == 200) {
      _userModel = UserModel.fromJson(res.body);
      _isLoading = true;
      responseModel = ResponseModel(true, "successful");
    } else {
      responseModel = ResponseModel(false, res.statusText!);
    }
    update();
    return responseModel;
  }
}