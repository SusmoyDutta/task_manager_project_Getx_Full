import 'package:task_manager_project/data/models/TaskByStatusData.dart';

class CountByStatusWrapper {
  String? status;
  List<TaskByStatusData>? listOfTaskByStatusData;

  CountByStatusWrapper({this.status, this.listOfTaskByStatusData});

  CountByStatusWrapper.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      listOfTaskByStatusData = <TaskByStatusData>[];
      json['data'].forEach((v) {
        listOfTaskByStatusData!.add(TaskByStatusData.fromJson(v));
      });
    }
  }
}


