import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_project/data/Utility/Url.dart';
import 'package:task_manager_project/data/models/AutoControlerEmailVerify.dart';
import 'package:task_manager_project/data/services/network_caller.dart';
import 'package:task_manager_project/presentation/Widget/background_widget.dart';
import 'package:task_manager_project/presentation/Widget/snack_Bar_Message.dart';
import 'package:task_manager_project/presentation/screen/auth/Set_Password_screen.dart';
import 'package:task_manager_project/presentation/screen/auth/Sing_in_screen.dart';

class PinVerification extends StatefulWidget {
  const PinVerification({super.key});

  @override
  State<PinVerification> createState() => _PinVerificationState();
}

class _PinVerificationState extends State<PinVerification> {
  final TextEditingController _pinTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _otpTaskVerifyInProgress = false;
  EmailResponse _emailResponse = EmailResponse();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 180,
                ),
                Text(
                  'PIN Verification',
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
                  height: 16,
                ),
                Form(
                  key: _formKey,
                  child: PinCodeTextField(
                    keyboardType: TextInputType.number,
                    appContext: context,
                    length: 6,
                    obscureText: false,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      inactiveColor: Colors.white,
                      selectedFillColor: Colors.grey.shade300,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,
                    controller: _pinTEController,
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your Pin';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: _otpTaskVerifyInProgress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _getOtpTaskVerify(_pinTEController.text,
                              _emailResponse.data?.accepted.first ?? '');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SetPassword(),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'Verify',
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
    );
  }

  Future<void> _getOtpTaskVerify(String accepted, String otp) async {
    _otpTaskVerifyInProgress = true;
    setState(() {});
    final responce =
        await NetWorkCaller.getRequest(Urls.recoverVerifyOTP(accepted, otp));
    if (responce.isSuccess) {
      responce.statusCode ==200;
      _emailResponse =
          EmailResponse.fromJson(responce.responseBody);
      _emailResponse.data?.messageId ?? '';
      _emailResponse.data?.accepted ?? '';
      _otpTaskVerifyInProgress = false;
    } else {
      if (mounted) {
        setState(() {});
        snackBarMessage(
          context,
          responce.errorMessage ?? 'Invalid your pin! please try again.',
        );
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _pinTEController.dispose();
  }
}
