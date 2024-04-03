import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project/controller_binder.dart';
import 'package:task_manager_project/presentation/screen/Splash_screen.dart';
import 'package:task_manager_project/presentation/utils/appColors.dart';

class TaskManager extends StatefulWidget {
  const TaskManager({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  State<TaskManager> createState() => _TaskManagerState();
}
class _TaskManagerState extends State<TaskManager> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: TaskManager.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: _themeData,
      initialBinding: ControllerBinder(),
      home: const SplashScreen(),
    );
  }
  final ThemeData _themeData = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.themeColors,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 24,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.themeColors,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.themeColors,
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        )),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w600,
        fontSize:32,
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        color: Colors.black87,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        color: Colors.grey,
        fontWeight: FontWeight.w500,
      ),
    ),
    cardTheme: CardTheme(
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
    chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        )
    ),
  );
}
