import 'package:get/get.dart';
import 'package:task_manager_project/data/Utility/url.dart';
import 'package:task_manager_project/data/models/response_object.dart';
import 'package:task_manager_project/data/models/task_list_wrapper.dart';
import 'package:task_manager_project/data/services/network_caller.dart';

class ProgressTaskListWrapperController extends GetxController{
  bool _inProgress = false;
  String? _errorMessage;
  TaskListWrapper _progressTaskListWrapper = TaskListWrapper();
  TaskListWrapper get progressTaskListWrapper => _progressTaskListWrapper;
  get inProgress => _inProgress;
  get errorMessage => _errorMessage;
  Future<bool> getProgressTaskListWrapper() async {
    bool _isSuccess = false;
    _inProgress = true;
    update();
    ResponseObject responce = await NetWorkCaller.getRequest(Urls.progressListTaskByStatus);
    if(responce.isSuccess){
      _progressTaskListWrapper = TaskListWrapper.fromJson(responce.responseBody);
      _isSuccess = true;
    }else{
      _errorMessage = responce.errorMessage;
    }
    _inProgress = false;
    update();
    return _isSuccess;
  }
}