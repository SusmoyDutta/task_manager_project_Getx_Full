import 'package:get/get.dart';
import 'package:task_manager_project/data/Utility/url.dart';
import 'package:task_manager_project/data/models/response_object.dart';
import 'package:task_manager_project/data/models/task_list_wrapper.dart';
import 'package:task_manager_project/data/services/network_caller.dart';

class CancelTaskListWrapperController extends GetxController{
  bool _inProgress = false;
  String? _errorMessage;
  TaskListWrapper _cancelTaskListWrapper = TaskListWrapper();
  get inProgress => _inProgress;
  get errorMessage => _errorMessage;
  TaskListWrapper get cancelTaskListWrapper => _cancelTaskListWrapper;
  Future<bool> getCancelTaskListWrapper() async {
    bool _isSuccess = false;
    _inProgress = true;
    update();
    ResponseObject responce = await NetWorkCaller.getRequest(Urls.cancelListTaskByStatus);
    if(responce.isSuccess){
      _cancelTaskListWrapper = TaskListWrapper.fromJson(responce.responseBody);
      _isSuccess = true;
    }else{
      _errorMessage = responce.errorMessage;
    }
    _inProgress = false;
    update();
    return _isSuccess;
  }
}