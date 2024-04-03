import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project/presentation/Widget/Empty_Widget.dart';
import 'package:task_manager_project/presentation/Widget/Profile_App_Bar.dart';
import 'package:task_manager_project/presentation/Widget/background_widget.dart';
import 'package:task_manager_project/presentation/controllers/complete_task_list_wrapper_controller.dart';
import 'package:task_manager_project/presentation/screen/task_card.dart';
import 'package:task_manager_project/presentation/utils/appColors.dart';

class CompleteScreen extends StatefulWidget {
  const CompleteScreen({super.key});

  @override
  State<CompleteScreen> createState() => _CompleteScreenState();
}

class _CompleteScreenState extends State<CompleteScreen> {

  @override
  void initState() {
    super.initState();
    Get.find<CompleteTaskListWrapperController>().completeTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWidget(
        child: GetBuilder<CompleteTaskListWrapperController>(
          builder: (completeTaskListWrapperController) {
            return Visibility(
              visible: completeTaskListWrapperController.inProgress == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: Visibility(
                visible: completeTaskListWrapperController.completeTaskListWrapper.taskList?.isNotEmpty ?? false,
                replacement: EmptyWidget(title: 'Empty',),
                child: ListView.builder(
                  itemCount: completeTaskListWrapperController.completeTaskListWrapper.taskList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return TaskCard(
                      color: MaterialStateColor.resolveWith(
                        (states) => AppColors.themeColors,
                      ),
                      taskItem:completeTaskListWrapperController.completeTaskListWrapper.taskList![index],
                      refreshList: () {
                        completeTaskListWrapperController.completeTaskList();
                        // _getCompleteTaskList();
                      },
                    );
                  },
                ),
              ),
            );
          }
        ),
      ),
    );
  }
  //
  // Future<void> _getCompleteTaskList() async {
  //   _completeTaskListInInProgress = true;
  //   setState(() {});
  //   final responce = await NetWorkCaller.getRequest(Urls.completedTaskByStatus);
  //   if (responce.isSuccess) {
  //     _completeTaskListWrapper =
  //         TaskListWrapper.fromJson(responce.responseBody);
  //     _completeTaskListInInProgress = false;
  //     setState(() {});
  //   } else {
  //     _completeTaskListInInProgress = false;
  //     setState(() {});
  //     if (mounted) {
  //       snackBarMessage(context,responce.errorMessage??  'Get new task list has been failed!');
  //     }
  //   }
  // }
}
