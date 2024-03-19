import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_project/data/Utility/Url.dart';
import 'package:task_manager_project/data/models/SingInUserData.dart';
import 'package:task_manager_project/data/services/network_caller.dart';
import 'package:task_manager_project/presentation/Widget/Profile_App_Bar.dart';
import 'package:task_manager_project/presentation/Widget/background_widget.dart';
import 'package:task_manager_project/presentation/Widget/snack_Bar_Message.dart';
import 'package:task_manager_project/presentation/controllers/auth_controllers.dart';
import 'package:task_manager_project/presentation/screen/navigator_app_bar.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _fastNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureTextTE = true;
  XFile? _pickerImage;
  bool _upDateProfileInProgress = false;

  @override
  void initState() {
    super.initState();
    _emailTEController.text = AuthController.userData?.email ?? '';
    _fastNameTEController.text = AuthController.userData?.firstName ?? '';
    _lastNameTEController.text = AuthController.userData?.lastName ?? '';
    _mobileTEController.text = AuthController.userData?.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Update Profile',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  imagePickerButton(),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    enabled: false,
                    controller: _emailTEController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.email_outlined,
                      ),
                      hintText: 'Email',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _fastNameTEController,
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your Fast Name';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.face),
                      hintText: 'Fast Name',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _lastNameTEController,
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
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your Mobile';
                      }
                      if (value!.length <= 11) {
                        return 'Mobile should more then 6 letter';
                      }
                      return null;
                    },
                    controller: _mobileTEController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.phone_android,
                      ),
                      hintText: 'Mobile',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _passwordTEController,
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
                      hintText: 'Password(Optional)',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: _upDateProfileInProgress == false,
                      replacement: const CircularProgressIndicator(),
                      child: ElevatedButton(
                        onPressed: () {
                          _upDateProfile();
                        },
                        child: const Icon(
                          color: Colors.white,
                          Icons.arrow_circle_right_outlined,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget imagePickerButton() {
    return GestureDetector(
      onTap: () {
        getImagePicker();
      },
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
              height: 60,
              width: 105,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                color: Colors.black54,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Photo',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    Icons.add_photo_alternate_outlined,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Text(
                _pickerImage?.name ?? '',
                maxLines: 1,
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getImagePicker() async {
    ImagePicker imagePicker = ImagePicker();
    _pickerImage = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  Future<void> _upDateProfile() async {
    String? photo;

    _upDateProfileInProgress = true;
    setState(() {});

    Map<String, dynamic> inputParams = {
      "email": _emailTEController.text,
      "firstName": _fastNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
    };

    if (_passwordTEController.text.isNotEmpty) {
      inputParams['password'] = _passwordTEController.text;
    }

    if (_pickerImage != null) {
      List<int> bytes = File(_pickerImage!.path).readAsBytesSync();
      photo = base64Encode(bytes);
      inputParams['photo'] = photo;
    }

    final response = await NetWorkCaller.postRequest(Urls.profileUpdate, inputParams);
    _upDateProfileInProgress = false;
    if (response.isSuccess) {
      if (response.responseBody['status'] == 'success') {
        UserData userData = UserData(
          email: _emailTEController.text,
          firstName: _fastNameTEController.text.trim(),
          lastName: _lastNameTEController.text.trim(),
          mobile: _mobileTEController.text.trim(),
          photo: photo,
        );
        await AuthController.saveUserData(userData);
      }
      if (mounted) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => const NavBarScreen()), (
                route) => false);
      }
    } else {
      if (!mounted) {
        return;
      }
      setState(() {});
      snackBarMessage(context, 'Update profile failed! Try again.');
    }
  }



  @override
  void dispose() {
    super.dispose();
    _emailTEController.dispose();
    _fastNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
  }
}
