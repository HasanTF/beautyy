import 'package:beuty_support/constants/colors.dart';
import 'package:beuty_support/constants/sizes.dart';
import 'package:beuty_support/firebase/auth_layout.dart';
import 'package:beuty_support/firebase/auth_sevices.dart';
import 'package:beuty_support/widget/custom_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String errorMessege = "";

  void register() async {
    setState(() {
      errorMessege = "";
    });

    try {
      UserCredential userCredential = await authServices.value.createAccount(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      await userCredential.user?.updateDisplayName(nameController.text.trim());

      await userCredential.user?.reload();

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AuthLayout()),
      );
    } on FirebaseAuthException catch (error) {
      setState(() {
        errorMessege = error.message ?? "An unknown error occurred.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final kWidth = screenSize.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(kWidth * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              HeaderText(),
              InputFeilds(
                nameController: nameController,
                emailController: emailController,
                passwordController: passwordController,
                errorMessege: errorMessege,
              ),
              SignUpButton(onPressed: register),
              TextDivider(),
              SocialButtons(),
              SignUpText(),
            ],
          ),
        ),
      ),
    );
  }
}

class InputFeilds extends StatelessWidget {
  const InputFeilds({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.errorMessege,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final String errorMessege;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomInputField(
          controller: nameController,
          hintText: "Full Name",
          obscureText: false,
          prefixIcon: const Icon(Icons.person),
        ),
        CustomInputField(
          controller: emailController,
          hintText: "E-Mail",
          obscureText: false,
          prefixIcon: const Icon(Icons.email),
        ),
        CustomInputField(
          controller: passwordController,
          hintText: "Password",
          obscureText: true,
          prefixIcon: const Icon(Icons.lock),
        ),
        Text(
          errorMessege,
          style: TextStyle(
            color: Colors.redAccent,
            fontSize: AppFontSizes.small,
          ),
        ),
      ],
    );
  }
}

class SignUpButton extends StatelessWidget {
  final VoidCallback onPressed;
  const SignUpButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.cPrimary,
            borderRadius: BorderRadius.circular(AppBorderRadius.borderR),
          ),
          child: TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              overlayColor: Colors.transparent,
            ),
            child: Text(
              'Sign Up',
              style: TextStyle(
                fontSize: AppFontSizes.medium,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Icon(Icons.check_box, color: AppColors.cPrimary),
            const SizedBox(width: 8),
            Text(
              "Remember me",
              style: TextStyle(
                color: AppColors.cLightGrey,
                fontSize: AppFontSizes.small,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class HeaderText extends StatelessWidget {
  const HeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Register",
          style: TextStyle(
            color: AppColors.cPrimary,
            fontSize: AppFontSizes.large,
            fontWeight: FontWeight.bold,
            fontFamily: "Dalius",
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          "Create your new account",
          style: TextStyle(
            color: AppColors.cLightGrey,
            fontSize: AppFontSizes.small,
            fontFamily: "Dalius",
          ),
        ),
      ],
    );
  }
}

class TextDivider extends StatelessWidget {
  const TextDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Colors.black26, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
          child: Text(
            "Or continue with",
            style: TextStyle(color: Colors.black, fontSize: AppFontSizes.small),
          ),
        ),
        const Expanded(child: Divider(color: Colors.black26, thickness: 1)),
      ],
    );
  }
}

class SocialButtons extends StatelessWidget {
  const SocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          padding: EdgeInsets.all(size * 0.035),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(Icons.facebook, size: size * 0.075),
        ),
        Container(
          padding: EdgeInsets.all(size * 0.035),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(Icons.g_mobiledata, size: size * 0.075),
        ),
        Container(
          padding: EdgeInsets.all(size * 0.035),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(Icons.apple, size: size * 0.075),
        ),
      ],
    );
  }
}

class SignUpText extends StatelessWidget {
  const SignUpText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: "Already have an account? ",
          style: TextStyle(
            color: AppColors.cLightGrey,
            fontSize: AppFontSizes.small,
          ),
          children: [
            TextSpan(
              text: "Sign In",
              style: TextStyle(
                color: AppColors.cPrimary,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/login');
                },
            ),
          ],
        ),
      ),
    );
  }
}
