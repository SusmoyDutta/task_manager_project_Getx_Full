import 'package:flutter/material.dart';
import 'package:task_manager_project/data/Utility/Url.dart';
import 'package:task_manager_project/data/models/TaskListWrapper.dart';
import 'package:task_manager_project/data/services/network_caller.dart';
import 'package:task_manager_project/presentation/Widget/Empty_Widget.dart';
import 'package:task_manager_project/presentation/Widget/Profile_App_Bar.dart';
import 'package:task_manager_project/presentation/Widget/background_widget.dart';
import 'package:task_manager_project/presentation/Widget/snack_Bar_Message.dart';
import 'package:task_manager_project/presentation/screen/TaskCard.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  bool _getAllTaskProgressInProgress = false;
  TaskListWrapper _progressTaskListWrapper = TaskListWrapper();

  @override
  void initState() {
    super.initState();
    _getAllTaskProgress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWidget(
        child: Visibility(
          visible: _getAllTaskProgressInProgress == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: Visibility(
            visible: _progressTaskListWrapper.taskList?.isNotEmpty ?? false,
            replacement: EmptyWidget(title: 'Empty',),
            child: ListView.builder(
              itemCount: _progressTaskListWrapper.taskList?.length ?? 0,
              itemBuilder: (context, index) {
                return TaskCard(
                  color: MaterialStateColor.resolveWith(
                    (states) => Colors.purple.shade300,
                  ),
                  taskItem: _progressTaskListWrapper.taskList![index],
                  refreshList: () {
                    _getAllTaskProgress();
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _getAllTaskProgress() async {
    _getAllTaskProgressInProgress = true;
    setState(() {});
    final responce =
        await NetWorkCaller.getRequest(Urls.progressListTaskByStatus);
    if (responce.isSuccess) {
      _progressTaskListWrapper = TaskListWrapper.fromJson(responce.responseBody);
      _getAllTaskProgressInProgress = false;
      setState(() {});
    } else {
      _getAllTaskProgressInProgress = false;
      setState(() {});
      if (mounted) {
        snackBarMessage(context, 'Get Progress task list has been failed!');
      }
    }
  }
}
