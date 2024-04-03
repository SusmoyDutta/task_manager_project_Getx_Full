import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project/presentation/Widget/Empty_Widget.dart';
import 'package:task_manager_project/presentation/Widget/Profile_App_Bar.dart';
import 'package:task_manager_project/presentation/Widget/background_widget.dart';
import 'package:task_manager_project/presentation/controllers/cancel_task_list_wrapper_controller.dart';
import 'package:task_manager_project/presentation/screen/task_card.dart';

class CancelScreen extends StatefulWidget {
  const CancelScreen({super.key});

  @override
  State<CancelScreen> createState() => _CancelScreenState();
}

class _CancelScreenState extends State<CancelScreen> {

  @override
  void initState() {
    super.initState();
    Get.find<CancelTaskListWrapperController>().getCancelTaskListWrapper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWidget(
        child: GetBuilder<CancelTaskListWrapperController>(
          builder: (cancelTaskListWrapperController) {
            return Visibility(
              visible: cancelTaskListWrapperController.inProgress == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: Visibility(
                visible: cancelTaskListWrapperController.cancelTaskListWrapper.taskList?.isNotEmpty ?? false,
                replacement:  EmptyWidget(title:  'Empty'),
                child: ListView.builder(
                  itemCount: cancelTaskListWrapperController.cancelTaskListWrapper.taskList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return TaskCard(
                      color: MaterialStateColor.resolveWith(
                        (states) => Colors.red,
                      ),
                      taskItem:cancelTaskListWrapperController.cancelTaskListWrapper.taskList![index],
                      refreshList: () {
                        cancelTaskListWrapperController.getCancelTaskListWrapper();
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
}
