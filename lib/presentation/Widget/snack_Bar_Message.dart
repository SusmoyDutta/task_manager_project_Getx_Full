import 'package:flutter/material.dart';
import 'package:task_manager_project/presentation/utils/appColors.dart';

void snackBarMessage(BuildContext context, String message,
    [bool isErrorMessage = false]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message,style: const TextStyle(color: Colors.white),),
      backgroundColor: isErrorMessage ? Colors.red : AppColors.themeColors,
    ),
  );
}
