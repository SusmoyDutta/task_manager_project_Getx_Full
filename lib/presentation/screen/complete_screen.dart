import 'package:flutter/material.dart';
import 'package:task_manager_project/data/Utility/Url.dart';
import 'package:task_manager_project/data/models/TaskListWrapper.dart';
import 'package:task_manager_project/data/services/network_caller.dart';
import 'package:task_manager_project/presentation/Widget/Empty_Widget.dart';
import 'package:task_manager_project/presentation/Widget/Profile_App_Bar.dart';
import 'package:task_manager_project/presentation/Widget/background_widget.dart';
import 'package:task_manager_project/presentation/Widget/snack_Bar_Message.dart';
import 'package:task_manager_project/presentation/screen/TaskCard.dart';
import 'package:task_manager_project/presentation/utils/appColors.dart';

class CompleteScreen extends StatefulWidget {
  const CompleteScreen({super.key});

  @override
  State<CompleteScreen> createState() => _CompleteScreenState();
}

class _CompleteScreenState extends State<CompleteScreen> {
  bool _completeTaskListInInProgress = false;
  TaskListWrapper _completeTaskListWrapper = TaskListWrapper();

  @override
  void initState() {
    super.initState();
    _getCompleteTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWidget(
        child: Visibility(
          visible: _completeTaskListInInProgress == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: Visibility(
            visible: _completeTaskListWrapper.taskList?.isNotEmpty ?? false,
            replacement: EmptyWidget(title: 'Empty',),
            child: ListView.builder(
              itemCount: _completeTaskListWrapper.taskList?.length ?? 0,
              itemBuilder: (context, index) {
                return TaskCard(
                  color: MaterialStateColor.resolveWith(
                    (states) => AppColors.themeColors,
                  ),
                  taskItem: _completeTaskListWrapper.taskList![index],
                  refreshList: () {
                    _getCompleteTaskList();
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getCompleteTaskList() async {
    _completeTaskListInInProgress = true;
    setState(() {});
    final responce = await NetWorkCaller.getRequest(Urls.completedTaskByStatus);
    if (responce.isSuccess) {
      _completeTaskListWrapper =
          TaskListWrapper.fromJson(responce.responseBody);
      _completeTaskListInInProgress = false;
      setState(() {});
    } else {
      _completeTaskListInInProgress = false;
      setState(() {});
      if (mounted) {
        snackBarMessage(context, 'Get new task list has been failed!');
      }
    }
  }
}
