import 'package:beuty_support/constants/colors.dart';
import 'package:beuty_support/constants/sizes.dart';
import 'package:beuty_support/firebase/auth_layout.dart';
import 'package:beuty_support/firebase/auth_sevices.dart';
import 'package:beuty_support/widget/custom_input_field.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String errorMessege = "";

  void login() async {
    setState(() {
      errorMessege = "";
    });

    try {
      await authServices.value.signIn(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AuthLayout()),
      );
    } on FirebaseException catch (error) {
      setState(() {
        errorMessege = error.message ?? "This is not working!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final kWidth = screenSize.width;
    final kHeight = screenSize.height;

    return Scaffold(
      backgroundColor: AppColors.cWhite,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          TopClipPath(width: kWidth, height: kHeight),
          Padding(
            padding: EdgeInsets.all(kWidth * 0.05),
            child: SizedBox(
              height: kHeight * 0.70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const WelcomingText(),
                  Column(
                    children: [
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
                      const RememberMe(),
                    ],
                  ),
                  SignInButton(onPressed: login),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SignInButton extends StatelessWidget {
  final VoidCallback onPressed;
  const SignInButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 60),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 56,
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
                'Sign in',
                style: TextStyle(
                  fontSize: AppFontSizes.medium,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          RichText(
            text: TextSpan(
              text: "Don't have an account? ",
              style: TextStyle(
                color: AppColors.cLightGrey,
                fontSize: AppFontSizes.small,
              ),
              children: [
                TextSpan(
                  text: "Sign Up",
                  style: TextStyle(
                    color: AppColors.cPrimary,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pushNamed(context, '/signup');
                    },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RememberMe extends StatelessWidget {
  const RememberMe({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.check_box, color: AppColors.cPrimary),
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
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, "/resetpassword");
          },
          child: Text(
            "Forgot Password?",
            style: TextStyle(
              color: AppColors.cLightGrey,
              fontSize: AppFontSizes.small,
            ),
          ),
        ),
      ],
    );
  }
}

class WelcomingText extends StatelessWidget {
  const WelcomingText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Welcome Back",
          style: TextStyle(
            color: AppColors.cPrimary,
            fontSize: AppFontSizes.large,
            fontWeight: FontWeight.bold,
            fontFamily: "Dalius",
          ),
        ),
        Text(
          "Login in to your account",
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

class TopClipPath extends StatelessWidget {
  final double width;
  final double height;

  const TopClipPath({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TopWaveClipper(),
      child: Container(
        height: height * 0.25,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/onboarding.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class TopWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height * 0.75);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height,
      size.width * 0.5,
      size.height * 0.85,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.70,
      size.width,
      size.height * 0.80,
    );
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
