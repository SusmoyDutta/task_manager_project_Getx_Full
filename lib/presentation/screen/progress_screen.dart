import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project/presentation/Widget/Empty_Widget.dart';
import 'package:task_manager_project/presentation/Widget/Profile_App_Bar.dart';
import 'package:task_manager_project/presentation/Widget/background_widget.dart';
import 'package:task_manager_project/presentation/controllers/progress_task_list_wrapper_controller.dart';
import 'package:task_manager_project/presentation/screen/task_card.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {


  @override
  void initState() {
    super.initState();
    Get.find<ProgressTaskListWrapperController>().getProgressTaskListWrapper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWidget(
        child: GetBuilder<ProgressTaskListWrapperController>(
          builder: (progressTaskListWrapperController) {
            return Visibility(
              visible: progressTaskListWrapperController.inProgress == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: Visibility(
                visible: progressTaskListWrapperController.progressTaskListWrapper.taskList?.isNotEmpty ?? false,
                replacement: EmptyWidget(title: 'Empty',),
                child: ListView.builder(
                  itemCount: progressTaskListWrapperController.progressTaskListWrapper.taskList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return TaskCard(
                      color: MaterialStateColor.resolveWith(
                        (states) => Colors.purple.shade300,
                      ),
                      taskItem: progressTaskListWrapperController.progressTaskListWrapper.taskList![index],
                      refreshList: () {
                        progressTaskListWrapperController.getProgressTaskListWrapper();
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
