import 'package:beuty_support/constants/colors.dart';
import 'package:beuty_support/constants/sizes.dart';
import 'package:beuty_support/firebase/auth_sevices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _controllerEmail = TextEditingController();
  String errorMessage = "";

  void resetPassword() async {
    final email = _controllerEmail.text.trim();

    // Check if email is empty
    if (email.isEmpty) {
      setState(() {
        errorMessage = "Email is required.";
      });
      return;
    }

    try {
      await authServices.value.resetPassword(email: email);

      // Show success SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password reset link sent!"),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate back after short delay (optional)
      await Future.delayed(const Duration(seconds: 1));
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (error) {
      setState(() {
        errorMessage = error.message ?? "An error occurred.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final kWidth = size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(kWidth * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    "Reset your password",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: AppFontSizes.large,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Delius",
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Image.asset(
                    "assets/images/ResetPasswordIcon.png",
                    fit: BoxFit.contain,
                    width: 200,
                    height: 200,
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: _controllerEmail,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.cSecondary,
                      hintText: "Email",
                      hintStyle: TextStyle(color: AppColors.cPrimary),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppBorderRadius.borderR,
                        ),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  Text(
                    errorMessage,
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: AppFontSizes.small,
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.cPrimary,
                  borderRadius: BorderRadius.circular(AppBorderRadius.borderR),
                ),
                child: TextButton(
                  onPressed: resetPassword,
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    overlayColor: Colors.transparent,
                  ),
                  child: Text(
                    'Reset Password',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: AppFontSizes.medium,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Delius",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
