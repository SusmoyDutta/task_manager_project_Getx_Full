import 'package:get/get.dart';
import 'package:task_manager_project/data/Utility/url.dart';
import 'package:task_manager_project/data/models/response_object.dart';
import 'package:task_manager_project/data/models/task_list_wrapper.dart';
import 'package:task_manager_project/data/services/network_caller.dart';

class NewTaskLisStatusWrapper extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  get inProgress => _inProgress;

  get errorMassage => _errorMessage ?? 'Get new task list has been failed!';

  TaskListWrapper _taskListWrapper = TaskListWrapper();

 TaskListWrapper get taskListWrapper => _taskListWrapper;

  Future<bool> taskNewListController() async {
    bool _isSuccess = false;
    _inProgress = true;

    ResponseObject responce =
        await NetWorkCaller.getRequest(Urls.newListTaskByStatus);
    if (responce.isSuccess) {
      _taskListWrapper = TaskListWrapper.fromJson(responce.responseBody);
      _isSuccess = true;
    } else {
      _errorMessage = responce.errorMessage;
    }
    _inProgress = false;
     update();
   return _isSuccess ;
  }
}
