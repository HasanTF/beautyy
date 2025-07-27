import 'package:beuty_support/constants/colors.dart';
import 'package:beuty_support/constants/sizes.dart';
import 'package:beuty_support/firebase/auth_sevices.dart';
import 'package:beuty_support/widget/custom_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _currentPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  String errorMessage = "";

  void updatePassword() async {
    // Clear previous error
    setState(() {
      errorMessage = "";
    });

    final currentPassword = _currentPassword.text.trim();
    final newPassword = _newPassword.text.trim();

    // Validation check
    if (currentPassword.isEmpty || newPassword.isEmpty) {
      setState(() {
        errorMessage = "Both fields are required.";
      });
      return;
    }

    // Confirm the passwords match
    if (_confirmPassword.text != _newPassword.text) {
      setState(() {
        errorMessage = "Passwords don't match!";
      });
      return;
    }

    try {
      // Get the email of the current user
      final email = FirebaseAuth.instance.currentUser?.email;

      if (email == null) {
        setState(() {
          errorMessage = "No user is logged in.";
        });
        return;
      }

      // Pass the email to the function
      await authServices.value.resetPasswordFromCurrentPassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        email: email, // Pass email here
      );

      // Show success SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Password updated successfully."),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate back
      Navigator.pop(context);
    } on FirebaseAuthException catch (error) {
      setState(() {
        errorMessage = error.message ?? "An error occurred.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final kHeight = size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Change password",
          style: TextStyle(
            color: Colors.black,
            fontSize: AppFontSizes.large,
            fontWeight: FontWeight.bold,
            fontFamily: "Delius",
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              height: kHeight * 0.85,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 16.0),
                        Image.asset(
                          "assets/images/ResetPasswordIcon.png",
                          fit: BoxFit.contain,
                          width: 200,
                          height: 200,
                        ),
                        const SizedBox(height: 16.0),
                        CustomInputField(
                          controller: _currentPassword,
                          hintText: "Current Password",
                          obscureText: true,
                        ),
                        CustomInputField(
                          controller: _newPassword,
                          hintText: "New Password",
                          obscureText: true,
                        ),
                        CustomInputField(
                          controller: _confirmPassword,
                          hintText: "Confirm Password",
                          obscureText: true,
                        ),

                        if (errorMessage.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Text(
                              errorMessage,
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: AppFontSizes.small,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 0.0),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 56,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.cPrimary,
                            borderRadius: BorderRadius.circular(
                              AppBorderRadius.borderR,
                            ),
                          ),
                          child: TextButton(
                            onPressed: updatePassword,
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              overlayColor: Colors.transparent,
                            ),
                            child: Text(
                              'Change Password',
                              style: TextStyle(
                                fontSize: AppFontSizes.small,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
