import 'package:get/get.dart';
import 'package:task_manager_project/presentation/controllers/add_new_task_controller.dart';
import 'package:task_manager_project/presentation/controllers/cancel_task_list_wrapper_controller.dart';
import 'package:task_manager_project/presentation/controllers/complete_task_list_wrapper_controller.dart';
import 'package:task_manager_project/presentation/controllers/delete_task_controller.dart';
import 'package:task_manager_project/presentation/controllers/edit_task_controller.dart';
import 'package:task_manager_project/presentation/controllers/email_verification_controller.dart';
import 'package:task_manager_project/presentation/controllers/new_task-list_controller.dart';
import 'package:task_manager_project/presentation/controllers/pin_verification_controller.dart';
import 'package:task_manager_project/presentation/controllers/progress_task_list_wrapper_controller.dart';
import 'package:task_manager_project/presentation/controllers/set_password_controller.dart';
import 'package:task_manager_project/presentation/controllers/sin_up_controller.dart';
import 'package:task_manager_project/presentation/controllers/sing_in_controller.dart';
import 'package:task_manager_project/presentation/controllers/task_count_by_status_wrapper.dart';
import 'package:task_manager_project/presentation/controllers/update_profile_task_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SingInController(),fenix: true);
    Get.lazyPut(() => SingUpController(),fenix: true);
    Get.lazyPut(() => EmailVerificationController(),fenix: true);
    Get.lazyPut(() => PinVerificationController(),fenix: true);
    Get.lazyPut(() => SetPasswordController(),fenix: true);
    Get.lazyPut(() => CountTaskByStatusWrapper(),fenix: true);
    Get.lazyPut(() => NewTaskLisStatusWrapper(),fenix: true);
    Get.lazyPut(() => CompleteTaskListWrapperController(),fenix: true);
    Get.lazyPut(() => CancelTaskListWrapperController(),fenix: true);
    Get.lazyPut(() => ProgressTaskListWrapperController(),fenix: true);
    Get.lazyPut(() => AddNewTaskController(),fenix: true);
    Get.lazyPut(() => UpdateProfileTaskController(),fenix: true);
    Get.lazyPut(() => EditTaskController(),fenix: true);
    Get.lazyPut(() => DeleteTaskController(),fenix: true);

  }
}