import 'package:get/get.dart';
import 'package:task_manager_project/data/Utility/url.dart';
import 'package:task_manager_project/data/models/controller_by_status_wrapper.dart';
import 'package:task_manager_project/data/models/response_object.dart';
import 'package:task_manager_project/data/services/network_caller.dart';

class CountTaskByStatusWrapper extends GetxController {
  bool _inProgress = false;
  String? _errorMassage;

  get inProgress => _inProgress;

  get errorMassage =>
      _errorMassage ?? 'Get task counter by status has been failed!';
  CountByStatusWrapper _countByStatusWrapper = CountByStatusWrapper();

  get countByStatusWrapper => _countByStatusWrapper;

  Future<bool> getCountByStatus() async {
    bool _isSuccess = false;
    _inProgress = true;
    update();
    ResponseObject responce =
        await NetWorkCaller.getRequest(Urls.taskStatusCount);
    if (responce.isSuccess) {
      _countByStatusWrapper =
          CountByStatusWrapper.fromJson(responce.responseBody);
      _isSuccess = true;
    } else {
      _errorMassage = responce.errorMessage;
    }
    _inProgress = false;
    update();
    return _isSuccess;
  }
}
