import 'package:flutter/material.dart';
import 'package:task_manager_project/data/Utility/Url.dart';
import 'package:task_manager_project/data/models/TaskListWrapper.dart';
import 'package:task_manager_project/data/services/network_caller.dart';
import 'package:task_manager_project/presentation/Widget/Empty_Widget.dart';
import 'package:task_manager_project/presentation/Widget/Profile_App_Bar.dart';
import 'package:task_manager_project/presentation/Widget/background_widget.dart';
import 'package:task_manager_project/presentation/Widget/snack_Bar_Message.dart';
import 'package:task_manager_project/presentation/screen/TaskCard.dart';

class CancelScreen extends StatefulWidget {
  const CancelScreen({super.key});

  @override
  State<CancelScreen> createState() => _CancelScreenState();
}

class _CancelScreenState extends State<CancelScreen> {
  bool _getAllCancelTaskListInProgress = false;
  TaskListWrapper _cancelTaskListWrapper = TaskListWrapper();

  @override
  void initState() {
    super.initState();
    _getAllCancelTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWidget(
        child: Visibility(
          visible: _getAllCancelTaskListInProgress == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: Visibility(
            visible: _cancelTaskListWrapper.taskList?.isNotEmpty ?? false,
            replacement:  EmptyWidget(title:  'Empty'),
            child: ListView.builder(
              itemCount: _cancelTaskListWrapper.taskList?.length ?? 0,
              itemBuilder: (context, index) {
                return TaskCard(
                  color: MaterialStateColor.resolveWith(
                    (states) => Colors.red,
                  ),
                  taskItem: _cancelTaskListWrapper.taskList![index],
                  refreshList: () {
                    _getAllCancelTaskList();
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getAllCancelTaskList() async {
    _getAllCancelTaskListInProgress = true;
    setState(() {});
    final responce =
        await NetWorkCaller.getRequest(Urls.cancelListTaskByStatus);
    if (responce.isSuccess) {
      _cancelTaskListWrapper = TaskListWrapper.fromJson(responce.responseBody);
      _getAllCancelTaskListInProgress = false;
      setState(() {});
    } else {
      _getAllCancelTaskListInProgress = false;
      setState(() {});
      if (mounted) {
        snackBarMessage(context, 'Get new task list has been failed!');
      }
    }
  }
}
