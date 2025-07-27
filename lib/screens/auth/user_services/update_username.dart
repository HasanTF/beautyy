import 'package:beuty_support/constants/colors.dart';
import 'package:beuty_support/constants/sizes.dart';
import 'package:beuty_support/firebase/auth_sevices.dart';
import 'package:beuty_support/widget/custom_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpdateUsername extends StatefulWidget {
  const UpdateUsername({super.key});

  @override
  State<UpdateUsername> createState() => _UpdateUsernameState();
}

class _UpdateUsernameState extends State<UpdateUsername> {
  final TextEditingController _controllerUsername = TextEditingController();

  String errorMessage = "";

  void updatePassword() async {
    setState(() {
      errorMessage = "";
    });

    final username = _controllerUsername.text.trim();

    // Validation check
    if (username.isEmpty) {
      setState(() {
        errorMessage = "field is required.";
      });
      return;
    }

    try {
      await authServices.value.updateUsername(username: username);

      // Show success SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Username is updated."),
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
          "Update username",
          style: TextStyle(
            color: Colors.redAccent,
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
              height: kHeight * 0.80,
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
                          "assets/images/ChangeUsernameIcon.png",
                          fit: BoxFit.contain,
                          width: 200,
                          height: 200,
                        ),
                        const SizedBox(height: 16.0),
                        CustomInputField(
                          controller: _controllerUsername,
                          hintText: "New username",
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
                              'Update Username',
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
