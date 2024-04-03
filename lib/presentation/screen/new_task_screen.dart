import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project/data/models/task_by_status_data.dart';
import 'package:task_manager_project/presentation/Widget/Empty_Widget.dart';
import 'package:task_manager_project/presentation/Widget/Profile_App_Bar.dart';
import 'package:task_manager_project/presentation/Widget/background_widget.dart';
import 'package:task_manager_project/presentation/controllers/new_task-list_controller.dart';
import 'package:task_manager_project/presentation/controllers/task_count_by_status_wrapper.dart';
import 'package:task_manager_project/presentation/screen/add_new_item.dart';
import 'package:task_manager_project/presentation/screen/task_card.dart';
import 'package:task_manager_project/presentation/Widget/Task_counter_card.dart';
import 'package:task_manager_project/presentation/utils/appColors.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {_getDataFromApi(); });

  }

  void _getDataFromApi() async{
   await Get.find<CountTaskByStatusWrapper>().getCountByStatus();
  await  Get.find<NewTaskLisStatusWrapper>().taskNewListController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWidget(
        child: Column(
          children: [
            GetBuilder<CountTaskByStatusWrapper>(
              init: Get.find<CountTaskByStatusWrapper>(),
                builder: (taskCountByStatusWrapper) {
              return Visibility(
                visible: taskCountByStatusWrapper.inProgress == false,
                replacement: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: LinearProgressIndicator(),
                ),
                child: taskCounterSection(
                  taskCountByStatusWrapper
                          .countByStatusWrapper.listOfTaskByStatusData ??
                      [],
                ),
              );
            }),
            Expanded(
              child: GetBuilder<NewTaskLisStatusWrapper>(
                init: Get.find<NewTaskLisStatusWrapper>(),
                  builder: (newTaskListController) {

                return Visibility(
                  visible: newTaskListController.inProgress == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: RefreshIndicator(
                    onRefresh: () async => _getDataFromApi(),
                    child: Visibility(
                      visible: newTaskListController
                              .taskListWrapper.taskList?.isNotEmpty ??
                          false,
                      replacement: EmptyWidget(
                        title: 'Empty',
                      ),
                      child: ListView.builder(
                        itemCount: newTaskListController
                                .taskListWrapper.taskList?.length ??
                            0,
                        itemBuilder: (context, index) {
                          return TaskCard(
                            color: MaterialStateColor.resolveWith(
                                (states) => Colors.blue.shade200),
                            taskItem: newTaskListController
                                .taskListWrapper.taskList![index],
                            refreshList: () {
                              _getDataFromApi();
                            },
                          );
                        },
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: addNewTask,
    );
  }

  Widget taskCounterSection(List<TaskByStatusData> listOfTaskByStatusData) {
    return SizedBox(
      height: 120,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: ListView.separated(
            itemCount: listOfTaskByStatusData.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return TaskCounterCard(
                title: listOfTaskByStatusData[index].sId ?? '',
                amount: listOfTaskByStatusData[index].sum ?? 0,
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
          final result = await Get.to(() => const AddNewItem());
          // final result= await Navigator.push(
          //    context,
          //    MaterialPageRoute(
          //      builder: (context) => const AddNewItem(),
          //    ),
          //  );
          if (result != null && result == true) {}
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
}
