import 'package:task_manager_project/data/models/singIn_user_data.dart';

class SingInResponce {
  String? status;
  String? token;
  UserData? userData;

  SingInResponce({this.status, this.token, this.userData});

  SingInResponce.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    userData = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }

}


