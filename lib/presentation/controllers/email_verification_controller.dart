import 'package:get/get.dart';
import 'package:task_manager_project/data/Utility/url.dart';
import 'package:task_manager_project/data/models/response_object.dart';
import 'package:task_manager_project/data/services/network_caller.dart';

class EmailVerificationController extends GetxController {
  bool _inProgress = false;
  String? _errorMessages;

  get inProgress => _inProgress;

  get errorMessages => _errorMessages ?? '';

  Future<bool> emailVerification(String email) async {
    bool _isSuccess = false;
    _inProgress = true;
    update();
    ResponseObject responce =
        await NetWorkCaller.getRequest(Urls.recoverVerifyEmail(email));
    if (responce.isSuccess) {
      _isSuccess = true;
    } else {
      _errorMessages = responce.errorMessage;

    }
    _inProgress = false;
    update();
    return _isSuccess;
  }
}
