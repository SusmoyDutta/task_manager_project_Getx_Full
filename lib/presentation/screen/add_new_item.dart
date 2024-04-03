import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project/presentation/Widget/Profile_App_Bar.dart';
import 'package:task_manager_project/presentation/Widget/background_widget.dart';
import 'package:task_manager_project/presentation/Widget/snack_Bar_Message.dart';
import 'package:task_manager_project/presentation/controllers/add_new_task_controller.dart';

class AddNewItem extends StatefulWidget {
  const AddNewItem({super.key});

  @override
  State<AddNewItem> createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {
  final TextEditingController _subjectTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  final bool _refreshNewTaskList = false;
 final AddNewTaskController _addNewTaskController = Get.find<AddNewTaskController>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        Get.back(canPop: _refreshNewTaskList);
        // Navigator.pop(context,_refreshNewTaskList);
      },
      child: Scaffold(
        appBar: profileAppBar,
        body: BackgroundWidget(
          child: Form(
            key: _fromKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Add New Task',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: _subjectTEController,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your title';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Subject',
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _descriptionTEController,
                      maxLines: 6,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your description';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Description',
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: GetBuilder<AddNewTaskController>(
                        builder: (addNewTaskController) {
                          return Visibility(
                            visible:_addNewTaskController.inProgress == false,
                            replacement: const Center(
                              child: CircularProgressIndicator(),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_fromKey.currentState!.validate()) {
                                  _addNewTask();
                                }
                              },
                              child: const Icon(
                                Icons.arrow_circle_right_outlined,
                                color: Colors.white,
                              ),
                            ),
                          );
                        }
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addNewTask() async {
    final result = await _addNewTaskController.getAddNewTask(
        _subjectTEController.text.trim(), _descriptionTEController.text.trim());
    if (result) {
      if (mounted) {
        _subjectTEController.clear();
        _descriptionTEController.clear();
        snackBarMessage(context, 'New task has been added');
      }
    } else {
      if (mounted) {
        snackBarMessage(
            context, _addNewTaskController.errorMessage, true);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionTEController.dispose();
    _subjectTEController.dispose();
  }
}
