import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_project/data/Utility/url.dart';
import 'package:task_manager_project/data/models/response_object.dart';
import 'package:task_manager_project/data/models/singIn_user_data.dart';
import 'package:task_manager_project/data/services/network_caller.dart';
import 'package:task_manager_project/presentation/controllers/auth_controllers.dart';

class UpdateProfileTaskController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  XFile? _pickerImage;
  String? photo;

  get inProgress => _inProgress;

  get errorMessage => _errorMessage ?? 'Update profile failed! Try again.';

  Future<bool> getUpdateProfile(String? email, String? firstName, String? lastName,
      String? mobile,String password) async {
    bool _isSuccess = false;
    _inProgress = true;
    update();
    Map<String, dynamic> inputParams = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
    };
    if (password.isNotEmpty) {
      inputParams['password'] = password;
    }
    if (_pickerImage != null) {
      List<int> bytes = File(_pickerImage!.path).readAsBytesSync();
      photo = base64Encode(bytes);
      inputParams['photo'] = photo;
    }
    ResponseObject responce = await NetWorkCaller.postRequest(
        Urls.profileUpdate, inputParams);
    if (responce.isSuccess &&  responce.responseBody ['status'] == 'success') {
      UserData userData = UserData(
        email: email,
        firstName: firstName,
        lastName:lastName,
        mobile: mobile,
        photo: photo,
      );
      await AuthController.saveUserData(userData);
      _isSuccess = true;
    } else {
      _errorMessage = responce.errorMessage;
    }
    _inProgress = false;
    update();
    return _isSuccess;
  }
}