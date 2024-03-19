import 'package:flutter/material.dart';
import 'package:task_manager_project/presentation/screen/cancel_screen.dart';
import 'package:task_manager_project/presentation/screen/complete_screen.dart';
import 'package:task_manager_project/presentation/screen/new_task_screen.dart';
import 'package:task_manager_project/presentation/screen/progress_screen.dart';
import 'package:task_manager_project/presentation/utils/appColors.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({super.key});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  int _currentIndex = 0;
  final List<Widget> _screen = [
    const NewTaskScreen(),
    const CompleteScreen(),
    const CancelScreen(),
    const ProgressScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: AppColors.themeColors,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          _currentIndex = index;
          if (mounted) {
            setState(() {});
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.article_outlined,
            ),
            label: 'New Task',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.incomplete_circle,
            ),
            label: 'Complete',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.cancel_presentation,
            ),
            label: 'Cancel',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.pending_rounded,
              ),
              label: 'Progress'),
        ],
      ),
    );
  }
}
