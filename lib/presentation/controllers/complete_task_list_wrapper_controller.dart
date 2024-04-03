import 'package:get/get.dart';
import 'package:task_manager_project/data/Utility/url.dart';
import 'package:task_manager_project/data/models/response_object.dart';
import 'package:task_manager_project/data/models/task_list_wrapper.dart';
import 'package:task_manager_project/data/services/network_caller.dart';

class CompleteTaskListWrapperController extends GetxController{
  bool _inProgress = false;
  String? _errorMessage;
  get inProgress => _inProgress;
  get errorMessage => _errorMessage ?? 'Get new task list has been failed!';
  TaskListWrapper _completeTaskListWrapper = TaskListWrapper();
  TaskListWrapper get completeTaskListWrapper => _completeTaskListWrapper;
  Future<bool> completeTaskList() async {
    bool _isSuccess = false;
    _inProgress = true;
    update();
    ResponseObject responce = await NetWorkCaller.getRequest(Urls.completedTaskByStatus);
    if(responce.isSuccess){
      _completeTaskListWrapper = TaskListWrapper.fromJson(responce.responseBody);
      _isSuccess = true;
    }else{
      _errorMessage = responce.errorMessage;
    }
    _inProgress = false;
    update();
    return _isSuccess;
  }
}