import 'package:get/get.dart';
import 'package:task_manager_project/data/Utility/url.dart';
import 'package:task_manager_project/data/models/response_object.dart';
import 'package:task_manager_project/data/models/sinin_response.dart';
import 'package:task_manager_project/data/services/network_caller.dart';
import 'package:task_manager_project/presentation/controllers/auth_controllers.dart';

class SingInController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage ?? 'Login failed! Try again';

  Future<bool> singIn(String email, String password) async {
    bool _isSuccess = false;
    _inProgress = true;
    update();
    Map<String, dynamic> inputData = {
      "email": email,
      "password": password,
    };
    final ResponseObject response = await NetWorkCaller.postRequest(
      Urls.login,
      inputData,
      fromSinIn: true,
    );
    if (response.isSuccess) {
      SingInResponce singInResponce =
          SingInResponce.fromJson(response.responseBody);
      await AuthController.saveUserData(singInResponce.userData!);
      await AuthController.saveUserToken(singInResponce.token!);
      update();
      _isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return _isSuccess;
  }
}
