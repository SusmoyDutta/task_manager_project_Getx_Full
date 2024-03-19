import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_manager_project/presentation/App.dart';
import 'package:task_manager_project/presentation/controllers/auth_controllers.dart';
import 'package:task_manager_project/presentation/screen/UpDate_Profile_Screen.dart';
import 'package:task_manager_project/presentation/screen/auth/Sing_in_screen.dart';

PreferredSizeWidget get profileAppBar {
  return AppBar(
    automaticallyImplyLeading: false,
    title: GestureDetector(
      onTap: () {
        Navigator.push(
          TaskManager.navigatorKey.currentState!.context,
          MaterialPageRoute(
            builder: (context) => const UpdateProfile(),
          ),
        );
      },
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: MemoryImage(base64Decode(AuthController.userData!.photo!)),
          ),
          const SizedBox(
            width: 12,
          ),
           Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(//'Susmoy',
                  AuthController .userData?.fullName?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                Text(
                  AuthController .userData?.email??'',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),

              ],
            ),
          ),
          IconButton(
            onPressed: () async {
             await AuthController .clearUserData();
              Navigator.pushAndRemoveUntil(
                  TaskManager.navigatorKey.currentState!.context,
                  MaterialPageRoute(
                    builder: (context) => const SingIn(),
                  ),
                  (route) => false);
            },
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
    ),
  );

}