import 'package:flutter/material.dart';
import 'package:task_manager_project/data/Utility/Url.dart';
import 'package:task_manager_project/data/models/TaskList.dart';
import 'package:task_manager_project/data/services/network_caller.dart';
import 'package:task_manager_project/presentation/Widget/snack_Bar_Message.dart';
import 'package:task_manager_project/presentation/utils/appColors.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    this.color,
    required this.taskItem,
    required this.refreshList,
  });

  final dynamic color;
  final TaskItem taskItem;
  final VoidCallback refreshList;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _upDateStatusTaskInProgress = false;
  bool _deleteTaskInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskItem.title ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.taskItem.description ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              'Date :${widget.taskItem.createdDate}',
              style: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
            Row(
              children: [
                Chip(
                  label: Text(
                    widget.taskItem.status ?? '',
                    style: TextStyle(
                      color: Colors.grey.shade50,
                    ),
                  ),
                  color: widget.color,
                ),
                const Spacer(), //boro fakha rakhajai
                Visibility(
                  visible: _upDateStatusTaskInProgress == false,
                  replacement: const CircularProgressIndicator(),
                  child: IconButton(
                    onPressed: () {
                      _showUpDateSnackDialog(widget.taskItem.sId!);
                    },
                    icon: const Icon(
                      Icons.edit_attributes_rounded,
                      color: AppColors.themeColors,
                    ),
                  ),
                ),
                Visibility(
                  visible: _deleteTaskInProgress == false,
                  replacement: const CircularProgressIndicator(),
                  child: IconButton(
                    onPressed: () {
                      _deleteTaskItem(widget.taskItem.sId!);
                    },
                    icon: const Icon(
                      Icons.delete_sweep_rounded,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showUpDateSnackDialog(String id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Select status',
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.clear))
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                child: ListTile(
                  title: const Text('New'),
                  trailing: _isCurrentStatus('New')?const Icon(Icons.check_box_outline_blank_sharp):const Icon(Icons.check_box_outlined),
                  onTap: () {
                    if(_isCurrentStatus('New')){
                      return;
                    }
                    _upDateTaskById(id, 'New');
                    Navigator.pop(context);
                  },
                ),

              ),
              Card(
                child: ListTile(
                  title: const Text('Complete'),
                  trailing: _isCurrentStatus('Complete')?const Icon(Icons.check_box_outline_blank_sharp):const Icon(Icons.check_box_outlined),
                  onTap: () {
                    if(_isCurrentStatus('Complete')){
                      return;
                    }
                    _upDateTaskById(id, 'Complete');
                    Navigator.pop(context);
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('Cancel'),
                  trailing: _isCurrentStatus('Cancel')?const Icon(Icons.check_box_outline_blank_sharp):const Icon(Icons.check_box_outlined),
                  onTap: () {
                    if(_isCurrentStatus('Cancel')){
                      return;
                    }
                    _upDateTaskById(id, 'Cancel');
                    Navigator.pop(context);
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('Progress'),
                  trailing: _isCurrentStatus('Progress')?const Icon(Icons.check_box_outline_blank_sharp):const Icon(Icons.check_box_outlined),
                  onTap: () {
                    if(_isCurrentStatus('Progress')){
                      return;
                    }
                    _upDateTaskById(id, 'Progress');
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  bool _isCurrentStatus(String status){
    return widget.taskItem.status! == status;
  }
  Future<void> _upDateTaskById(String id, String status) async {
    _upDateStatusTaskInProgress = true;
    setState(() {});
    final responce =
        await NetWorkCaller.getRequest(Urls.updateTaskStatus(id, status));
    if (responce.isSuccess) {
      _upDateStatusTaskInProgress = false;
      widget.refreshList();
    } else {
      setState(() {});
      if (mounted) {
        snackBarMessage(context, 'Get new task list has been failed!');
      }
    }
  }

  Future<void> _deleteTaskItem(String id) async {
    _deleteTaskInProgress = true;
    setState(() {});
    final responce = await NetWorkCaller.getRequest(Urls.deleteTask(id));
    if (responce.isSuccess) {
      widget.refreshList();
      _deleteTaskInProgress = false;
    } else {
      setState(() {});
      if (mounted) {
        snackBarMessage(context, 'Delete Task has been failed!');
      }
    }
  }

}
