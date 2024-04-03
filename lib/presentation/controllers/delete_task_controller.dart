import 'package:get/get.dart';
import 'package:task_manager_project/data/Utility/url.dart';
import 'package:task_manager_project/data/models/response_object.dart';
import 'package:task_manager_project/data/services/network_caller.dart';

class DeleteTaskController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  get inProgress => _inProgress;

  get errorMessage => _errorMessage ?? 'Delete Task has been failed!';

  Future<bool> getDeleteTask(String id) async {
    bool _isSuccess = false;
    _inProgress = true;
    update();
    ResponseObject responce =
        await NetWorkCaller.getRequest(Urls.deleteTask(id));
    if (responce.isSuccess) {
      _isSuccess = true;
    } else {
      _errorMessage = responce.errorMessage;
    }
    _inProgress = false;
    update();
    return _isSuccess;
  }
}
