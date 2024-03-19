import 'package:flutter/material.dart';
import 'package:task_manager_project/data/Utility/Url.dart';
import 'package:task_manager_project/data/models/sinin_response.dart';
import 'package:task_manager_project/data/services/network_caller.dart';
import 'package:task_manager_project/data/models/response_object.dart';

import 'package:task_manager_project/presentation/Widget/background_widget.dart';
import 'package:task_manager_project/presentation/Widget/snack_Bar_Message.dart';
import 'package:task_manager_project/presentation/controllers/auth_controllers.dart';
import 'package:task_manager_project/presentation/screen/auth/Sing_up_Screen.dart';
import 'package:task_manager_project/presentation/screen/auth/email_verification_screen.dart';
import 'package:task_manager_project/presentation/screen/navigator_app_bar.dart';
import 'package:task_manager_project/presentation/utils/appColors.dart';

class SingIn extends StatefulWidget {
  const SingIn({super.key});

  @override
  State<SingIn> createState() => _SingInState();
}

class _SingInState extends State<SingIn> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTeController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureTextTE = true;
  bool _isInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 180,
                  ),
                  Text(
                    'Get Started With',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _emailTEController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return;
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined),
                      hintText: 'Email',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    obscureText: _obscureTextTE,
                    controller: _passwordTeController,
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your Password';
                      }
                      if (value!.length <= 6) {
                        return 'Password should more then 6 letter';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.lock_outlined,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureTextTE = !_obscureTextTE;
                          });
                        },
                        icon: Icon(
                          _obscureTextTE
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                      hintText: 'Password',
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: _isInProgress == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: AppColors.themeColors,
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          singIn();
                        },
                        child: const Icon(
                          Icons.arrow_circle_right_outlined,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EmailVerification(),
                          ),
                        );
                      },
                      child: Text(
                        'Forget Password',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have a account?",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SingUp(),
                            ),
                          );
                        },
                        child: const Text(
                          'Sing up',
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> singIn() async {
    _isInProgress = true;
    setState(() {});
    Map<String, dynamic> inputData = {
      "email": _emailTEController.text.trim(),
      "password": _passwordTeController.text,
    };
    final ResponseObject response = await NetWorkCaller.postRequest(
      Urls.login,
      inputData,
      fromSinIn: true,
    );
    _isInProgress = false;
    setState(() {});
    if (response.isSuccess) {
      if (!mounted) {
        return;
      }
      SingInResponce singInResponce =
          SingInResponce.fromJson(response.responseBody);
      await AuthController.saveUserData(singInResponce.userData!);
      await AuthController.saveUserToken(singInResponce.token!);
      if (mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const NavBarScreen(),
            ),
            (route) => false);
      }
    } else {
      if (mounted) {
        snackBarMessage(context, 'Sing in Field! Please Try agan.', true);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _passwordTeController.dispose();
    _emailTEController.dispose();
  }
}
