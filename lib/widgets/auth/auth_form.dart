import 'dart:io';

import 'package:chat_app/widgets/image_picker/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  bool isLoading = false;
  final void Function(
    String email,
    String userName,
    File image,
    String password,
    bool isLogin,
  ) submitFn;
  AuthForm({
    super.key,
    required this.submitFn,
    required this.isLoading,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  bool isLogin = false;
  var userEmail = '';
  var userName = '';
  var userPassword = '';
  File? _userImageFile;
  void _pickImage(File pickImage) {
    _userImageFile = pickImage;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_userImageFile == null && isLogin) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Please pick an image')));
      return;
    }
    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFn(
        userEmail.trim(),
        userName.trim(),
        File(_userImageFile!.path),
        userPassword.trim(),
        isLogin,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isLogin) UserImagePicker(imagePickFn: _pickImage),
                TextFormField(
                  key: const ValueKey('email'),
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'E-Mail'),
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Please enter valid email adrress.';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    userEmail = newValue!;
                  },
                ),
                if (isLogin)
                  TextFormField(
                    key: const ValueKey('user-name'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: 'User-Name'),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 4) {
                        return 'Please enter value atleast 4 characters long.';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      userName = newValue!;
                    },
                  ),
                TextFormField(
                  key: const ValueKey('password'),
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: (value) {
                    if (value!.isEmpty || value.length < 7) {
                      return 'Please enter value atleast 7 characters long.';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    userPassword = newValue!;
                  },
                ),
                const SizedBox(height: 15),
                if (widget.isLoading) const CircularProgressIndicator(),
                if (!widget.isLoading)
                  ElevatedButton(
                      onPressed: _trySubmit,
                      child: Text(isLogin ? 'Sign Up' : 'Login')),
                if (!widget.isLoading)
                  TextButton(
                      onPressed: () {
                        setState(() {
                          isLogin = !isLogin;
                        });
                      },
                      child: Text(isLogin
                          ? 'I have already an account!'
                          : 'Create Account'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
