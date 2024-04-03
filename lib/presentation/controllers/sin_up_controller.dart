import 'package:get/get.dart';
import 'package:task_manager_project/data/Utility/url.dart';
import 'package:task_manager_project/data/models/response_object.dart';
import 'package:task_manager_project/data/services/network_caller.dart';

class SingUpController extends GetxController {
  bool _inProgress = false;
  String? _successMessage;
  String? _errorMessage;
  get inProgress => _inProgress;
  String get successMessage => _successMessage ?? 'Registration Success! Please Sine in.';
  String get errorMessage => _errorMessage ?? 'Registration Failed. Please Try again!';


  Future<bool> singUp (String email, String fastName, String lastName,
      String mobile, String password) async {
    bool _isSusccess = false;
    _inProgress = true;
    update();
    Map<String, dynamic> inputParams = {
      "email": email,
      "fastName": fastName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
    };
    final ResponseObject response = await NetWorkCaller.postRequest(
      Urls.registration,
      inputParams,
    );

    if(response.isSuccess){
     _isSusccess = true;
    }else{
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
   return _isSusccess;
  }
}
