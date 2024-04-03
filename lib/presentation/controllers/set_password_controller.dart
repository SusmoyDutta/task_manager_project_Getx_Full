import 'package:get/get.dart';
import 'package:task_manager_project/data/Utility/url.dart';
import 'package:task_manager_project/data/models/response_object.dart';
import 'package:task_manager_project/data/services/network_caller.dart';

class SetPasswordController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  get inProgress => _inProgress;

  get errorMessage => _errorMessage;

  Future<bool> setPassword(String email, String otp, String password) async {
    bool _isSuccess = false;
    _inProgress = true;
    update();
    Map<String, dynamic> input = {
      "email": email,
      "OTP": otp,
      "password": password,
    };
    ResponseObject responce =
        await NetWorkCaller.postRequest(Urls.recoverResetPass, input);
    if (responce.isSuccess && responce.responseBody['status'] == 'success') {
      _isSuccess = true;
    } else {
      _errorMessage = responce.errorMessage;
    }
    _inProgress = false;
    update();
    return _isSuccess;
  }
}
