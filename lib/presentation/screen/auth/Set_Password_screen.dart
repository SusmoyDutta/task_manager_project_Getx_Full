import 'package:flutter/material.dart';
import 'package:task_manager_project/data/Utility/Url.dart';
import 'package:task_manager_project/data/models/AutoControlerEmailVerify.dart';
import 'package:task_manager_project/data/services/network_caller.dart';
import 'package:task_manager_project/presentation/Widget/background_widget.dart';
import 'package:task_manager_project/presentation/Widget/snack_Bar_Message.dart';
import 'package:task_manager_project/presentation/screen/auth/Sing_in_screen.dart';

class SetPassword extends StatefulWidget {
  const SetPassword({super.key});

  @override
  State<SetPassword> createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
  final TextEditingController _newPasswordTEController =
      TextEditingController();
  final TextEditingController _confirmPasswordTeController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureTextTE = true;
  bool _setPasswordInProgress = false;
  EmailResponse emailResponse = EmailResponse();

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
                    'Set Password',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Minimum length password 8 character with Latter and number combination',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _newPasswordTEController,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: _obscureTextTE,
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter you Password';
                      }
                      if (value!.length <= 6) {
                        return 'Password should more then 6 letter';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.lock_outline_rounded,
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
                    height: 8,
                  ),
                  TextFormField(
                    controller: _confirmPasswordTeController,
                    obscureText: _obscureTextTE,
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter you Confirm Password';
                      }
                      if (value!.length <= 6) {
                        return 'Confirm Password should more then 6 letter';
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
                      hintText: 'Confirm Password',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: _setPasswordInProgress ==false,
                      replacement: const Center(child: CircularProgressIndicator(),),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _getSetPassword();
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SingIn(),
                            ),
                          );
                        },
                        child: const Text(
                          'Confirm',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
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
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SingIn(),
                              ),
                              (route) => false);
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

  Future<void> _getSetPassword() async {
    _setPasswordInProgress = true;
    setState(() {});
    Map<String, dynamic> input = {
      "email": emailResponse.data?.accepted ?? '',
      "OTP":emailResponse.data?.messageId?? '',
      "password": _newPasswordTEController.text,
    };
    final responce =
        await NetWorkCaller.postRequest(Urls.recoverResetPass, input);
    if (responce.isSuccess) {
      responce.statusCode ==200;
    } else {
      _setPasswordInProgress = false;
      setState(() {});
      if (mounted) {
        snackBarMessage(
            context,
            responce.errorMessage ??
                'Your confirm Password is failed! Pleased try age.');
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _newPasswordTEController.dispose();
    _confirmPasswordTeController.dispose();
  }
}
