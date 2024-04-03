import 'package:get/get.dart';
import 'package:task_manager_project/data/Utility/url.dart';
import 'package:task_manager_project/data/models/response_object.dart';
import 'package:task_manager_project/data/services/network_caller.dart';

class PinVerificationController extends GetxController{
  bool _inProgress = false;
  String? _errorMessage;
  get inProgress => _inProgress;
  get errorMessage => _errorMessage ?? 'Invalid your pin! please try again.';

  Future<bool> pinVerification(String email,String otp) async {
    bool _isSuccess = false;
    _inProgress = true;
    update();
    ResponseObject responce = await NetWorkCaller.getRequest(Urls.recoverVerifyOTP(email, otp));
    if(responce.isSuccess && responce.responseBody ['status'] == 'success'){
      _isSuccess = true;
    }else{
      _errorMessage = responce.errorMessage;
    }
    _inProgress = false;
    update();
    return _isSuccess;
  }

}