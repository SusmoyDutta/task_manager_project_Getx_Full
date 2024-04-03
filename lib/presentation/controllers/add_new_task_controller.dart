import 'package:get/get.dart';
import 'package:task_manager_project/data/Utility/url.dart';
import 'package:task_manager_project/data/models/response_object.dart';
import 'package:task_manager_project/data/services/network_caller.dart';

class AddNewTaskController extends GetxController{
  bool _inProgress = false;
  String? _errorMessage;
  get inProgress => _inProgress;
  get errorMessage => _errorMessage ?? 'Add task failed!';

  Future<bool> getAddNewTask(String title,String description) async {
    bool _isSusccess = false;
    _inProgress = true;
    update();
    Map<String, dynamic> inputParam = {
      "title": title,
      "description": description,
      "status": "New"
    };
    ResponseObject responce = await NetWorkCaller.postRequest(Urls.createTask, inputParam);
    if(responce.isSuccess){
      _isSusccess = true;
    }else{
      _errorMessage = responce.errorMessage;
    }
    _inProgress = false;
    update();
    return _isSusccess;
  }
}