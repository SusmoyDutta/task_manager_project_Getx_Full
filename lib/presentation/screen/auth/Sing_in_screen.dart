import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project/presentation/Widget/background_widget.dart';
import 'package:task_manager_project/presentation/Widget/snack_Bar_Message.dart';
import 'package:task_manager_project/presentation/controllers/sing_in_controller.dart';
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
  final SingInController _singInController = Get.find<SingInController>();

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
                        return'Enter your Email';
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
                    child: GetBuilder<SingInController>(
                      builder: (singInController) {
                        return Visibility(
                          visible: _singInController.inProgress == false,
                          replacement: const Center(
                            child: CircularProgressIndicator(
                              backgroundColor: AppColors.themeColors,
                            ),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                singIn();
                              }
                            },
                            child: const Icon(
                              Icons.arrow_circle_right_outlined,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Get.to(()=>const EmailVerification());
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const EmailVerification(),
                        //   ),
                        // );
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
                          Get.off(()=>const SingUp());
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const SingUp(),
                          //   ),
                          // );
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
    final result = await _singInController.singIn(
      _emailTEController.text.trim(),
      _passwordTeController.text,
    );

    if (result) {
      if (mounted) {
        Get.off(()=>const NavBarScreen(),);
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => const NavBarScreen(),
        //     ),
        //     (route) => false);
      }
    } else {
      if (mounted) {
        snackBarMessage(
          context,
          _singInController.errorMessage,
          true,
        );
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
