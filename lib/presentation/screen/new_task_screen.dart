import 'package:flutter/material.dart';
import 'package:task_manager_project/data/Utility/Url.dart';
import 'package:task_manager_project/data/models/ContnBystatusWrapper.dart';
import 'package:task_manager_project/data/models/TaskListWrapper.dart';
import 'package:task_manager_project/data/services/network_caller.dart';
import 'package:task_manager_project/presentation/Widget/Empty_Widget.dart';
import 'package:task_manager_project/presentation/Widget/Profile_App_Bar.dart';
import 'package:task_manager_project/presentation/Widget/background_widget.dart';
import 'package:task_manager_project/presentation/Widget/snack_Bar_Message.dart';
import 'package:task_manager_project/presentation/screen/Add_new_item.dart';
import 'package:task_manager_project/presentation/screen/TaskCard.dart';
import 'package:task_manager_project/presentation/screen/Task_counter_card.dart';
import 'package:task_manager_project/presentation/utils/appColors.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getAllTaskByStatusInProgress = false;
  CountByStatusWrapper _countByStatusWrapper = CountByStatusWrapper();
  TaskListWrapper _taskListWrapper = TaskListWrapper();
  bool _newTaskListWrapper = false;

  @override
  void initState() {
    _getDataFromApi();
    super.initState();
  }

  void _getDataFromApi() {
    _getAllTaskByStatus();
    _getTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWidget(
        child: Column(
          children: [
            Visibility(
              visible: _getAllTaskByStatusInProgress == false,
              replacement: const Padding(
                padding: EdgeInsets.all(8.0),
                child: LinearProgressIndicator(),
              ),
              child: taskCounterSection,
            ),
            Expanded(
              child: Visibility(
                visible: _newTaskListWrapper == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: RefreshIndicator(
                  onRefresh: () async => _getDataFromApi(),
                  child: Visibility(
                    visible: _taskListWrapper.taskList?.isNotEmpty ?? false,
                    replacement: EmptyWidget(title: 'Empty',),
                    child: ListView.builder(
                      itemCount: _taskListWrapper.taskList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return TaskCard(
                          color: MaterialStateColor.resolveWith(
                              (states) => Colors.blue.shade200),
                          taskItem: _taskListWrapper.taskList![index],
                          refreshList: () {
                            _getDataFromApi();
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: addNewTask,
    );
  }

  Widget get taskCounterSection {
    return SizedBox(
      height: 120,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: ListView.separated(
            itemCount:
                _countByStatusWrapper.listOfTaskByStatusData?.length ?? 0,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return TaskCounterCard(
                title:
                    _countByStatusWrapper.listOfTaskByStatusData![index].sId ??
                        '',
                amount:
                    _countByStatusWrapper.listOfTaskByStatusData![index].sum ??
                        0,
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                width: 8,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget get addNewTask {
    return SizedBox(
      width: 110,
      child: FloatingActionButton(
        backgroundColor: AppColors.themeColors,
        onPressed: () async {
         final result= await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewItem(),
            ),
          );
         if(result != null && result == true){}
         _getDataFromApi();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_reaction_outlined,
              color: Colors.grey.shade50,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              'Add New',
              style: TextStyle(
                color: Colors.grey.shade50,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getAllTaskByStatus() async {
    _getAllTaskByStatusInProgress = true;
    setState(() {});
    final responce = await NetWorkCaller.getRequest(Urls.taskStatusCount);
    if (responce.isSuccess) {
      _countByStatusWrapper =
          CountByStatusWrapper.fromJson(responce.responseBody);
      _getAllTaskByStatusInProgress = false;
      setState(() {});
    } else {
      if (mounted) {
        snackBarMessage(
          context,
          responce.errorMessage ??
              'Get task counter by status has been failed!',
        );
      }
    }
  }

  Future<void> _getTaskList() async {
    _newTaskListWrapper = true;
    setState(() {});
    final responce = await NetWorkCaller.getRequest(Urls.newListTaskByStatus);
    if (responce.isSuccess) {
      _taskListWrapper = TaskListWrapper.fromJson(responce.responseBody);
      _newTaskListWrapper = false;
      setState(() {});
    } else {
      _newTaskListWrapper = false;
      setState(() {});
      if (mounted) {
        snackBarMessage(context, 'Get new task list has been failed!');
      }
    }
  }
}


