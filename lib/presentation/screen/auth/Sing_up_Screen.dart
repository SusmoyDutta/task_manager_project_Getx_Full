import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project/presentation/Widget/background_widget.dart';
import 'package:task_manager_project/presentation/Widget/snack_Bar_Message.dart';
import 'package:task_manager_project/presentation/controllers/sin_up_controller.dart';
import 'package:task_manager_project/presentation/screen/auth/Sing_in_screen.dart';
import 'package:task_manager_project/presentation/utils/appColors.dart';

class SingUp extends StatefulWidget {
  const SingUp({super.key});

  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _fastTEController = TextEditingController();
  final TextEditingController _lastTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTeController = TextEditingController();

  // globalKey die from check korbe
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //password check korar jono
  bool _obscureTextTE = true;

  //progress indicator check kore

  final SingUpController _singUpController = Get.find<SingUpController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            //form check kore
            child: Form(
              key: _formKey,
              //form check kore
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Text(
                    'Join With Us',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    //form controller nior jono used kora hoy
                    controller: _emailTEController,

                    keyboardType: TextInputType.emailAddress,
                    //keyboard text select kora hoy
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your Email ';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined),
                      hintText: 'Email ',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    //form controller nior jono used kora hoy
                    controller: _fastTEController,
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your Fast Name';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.face_outlined),
                      hintText: 'Fast Name',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _lastTEController,
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your Last Name';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.face),
                      hintText: 'Last Name',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _mobileTEController,
                    keyboardType: TextInputType.phone,
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your Mobile';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.phone_android),
                      hintText: 'Mobile ',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
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
                    child: GetBuilder<SingUpController>(
                        builder: (singUpController) {
                      return Visibility(
                        visible: _singUpController.inProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(
                            backgroundColor: AppColors.themeColors,
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _singUp();
                            }
                          },
                          child: const Icon(
                            Icons.arrow_circle_right_outlined,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Have account?",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      TextButton(
                        onPressed: () {
                          Get.off(()=>const SingIn(),);
                          // Navigator.pushAndRemoveUntil(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => const SingIn(),
                          //     ),
                          //     (route) => false);
                        },
                        child: const Text(
                          'Sing in',
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

  Future<void> _singUp() async {
    _singUpController.singUp(
      _emailTEController.text.trim(),
      _fastTEController.text.trim(),
      _lastTEController.text.trim(),
      _mobileTEController.text.trim(),
      _passwordTeController.text,
    );
    if (mounted) {
      snackBarMessage(context, _singUpController.successMessage);
      Get.back();
      // Navigator.pop(context);
    } else {
      if (mounted) {
        snackBarMessage(context, _singUpController.errorMessage, true);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _fastTEController.dispose();
    _lastTEController.dispose();
    _mobileTEController.dispose();
    _emailTEController.dispose();
    _passwordTeController.dispose();
  }
}
