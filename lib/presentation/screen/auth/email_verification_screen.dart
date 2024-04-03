import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_project/presentation/Widget/background_widget.dart';
import 'package:task_manager_project/presentation/Widget/snack_Bar_Message.dart';
import 'package:task_manager_project/presentation/controllers/email_verification_controller.dart';
import 'package:task_manager_project/presentation/screen/auth/Pin_verification_screen.dart';
import 'package:task_manager_project/presentation/screen/auth/Sing_in_screen.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({
    super.key,
  });

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 final EmailVerificationController _emailVerificationController = Get.find<EmailVerificationController>();

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
                    'Your Email Address',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'A 6 digit verification pin will send to your email address',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _emailTEController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined),
                      hintText: 'Email',
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your email.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: GetBuilder<EmailVerificationController>(
                      builder: (emailVerificationController) {
                        return Visibility(
                          visible: _emailVerificationController.inProgress == false,
                          replacement: const Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _getEmailTask(
                                  _emailTEController.text.trim(),
                                );
                              }
                            },
                            child: const Icon(
                              Icons.arrow_circle_right_outlined,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        );
                      }
                    ),
                  ),
                  const SizedBox(
                    height: 28,
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
                          Get.off(()=>const SingIn());
                          // Navigator.pushAndRemoveUntil(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const SingIn(),
                          //   ),
                          //   (route) => false,
                          // );
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

  Future<void> _getEmailTask(String email) async {
    final result = await _emailVerificationController.emailVerification(email);

    if (result) {
      if (mounted) {
        Get.to(()=>PinVerification(email: email));
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => PinVerification(
        //       email: email,
        //     ),
        //   ),
        // );
      }
    } else {
      if (mounted) {
        snackBarMessage(context, _emailVerificationController.errorMessages, true);
      }
    } //wijefi3167@azduan.com
  }

  @override
  void dispose() {
    super.dispose();
    _emailTEController.dispose();
  }
}
