import 'package:beuty_support/constants/sizes.dart';
import 'package:beuty_support/firebase/auth_sevices.dart';
import 'package:beuty_support/widget/custom_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  String errorMessage = "";

  void updatePassword() async {
    setState(() {
      errorMessage = "";
    });

    final email = _controllerEmail.text.trim();
    final password = _controllerPassword.text.trim();

    // Validation check
    if (email.isEmpty || password.isEmpty) {
      setState(() {
        errorMessage = "Both fields are required.";
      });
      return;
    }

    try {
      await authServices.value.deleteAccount(email: email, password: password);

      // Show success SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Account Deleted."),
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
          "Delete your account",
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
                          "assets/images/DeletingAccountIcon.png",
                          fit: BoxFit.contain,
                          width: 200,
                          height: 200,
                        ),
                        const SizedBox(height: 16.0),
                        CustomInputField(
                          controller: _controllerEmail,
                          hintText: "Email",
                        ),
                        CustomInputField(
                          controller: _controllerPassword,
                          hintText: "Password",
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
                            color: Colors.redAccent,
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
                              'Delete Account',
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
