import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project/presentation/Widget/App_logo.dart';
import 'package:task_manager_project/presentation/Widget/background_widget.dart';
import 'package:task_manager_project/presentation/controllers/auth_controllers.dart';
import 'package:task_manager_project/presentation/screen/auth/Sing_in_screen.dart';
import 'package:task_manager_project/presentation/screen/navigator_app_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToSingIn();
  }

  Future<void> _moveToSingIn() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );
    bool singInState = await AuthController.isUserLoggedIn();
    if (mounted) {
      if (singInState) {
        Get.off(()=>const NavBarScreen());
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const NavBarScreen(),
        //   ),
        // );
      } else {
        Get.off(() => const SingIn());
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const SingIn(),
        //   ),
        // );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BackgroundWidget(
        child: Center(
          child: AppLogo(),
        ),
      ),
    );
  }
}
