import 'package:beuty_support/constants/colors.dart';
import 'package:beuty_support/constants/sizes.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final kWidth = screenSize.width;
    final kHeight = screenSize.height;

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(),
          const BackgroundBlackLayer(),
          SizedBox(
            height: kHeight,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: kHeight * 0.1,
                horizontal: kWidth * 0.05,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const WelcomingText(),
                  Column(
                    children: const [
                      SignInButton(),
                      SizedBox(height: 16),
                      CreateAccountText(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CreateAccountText extends StatelessWidget {
  const CreateAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, '/signup');
      },
      child: Text(
        'Create an account',
        style: TextStyle(color: Colors.white70, fontSize: AppFontSizes.small),
      ),
    );
  }
}

class SignInButton extends StatelessWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(40),
        borderRadius: BorderRadius.circular(AppBorderRadius.borderR),
      ),
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/login');
        },

        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          overlayColor: Colors.transparent,
        ),
        child: Text(
          'Sign In',
          style: TextStyle(
            color: Colors.white,
            fontSize: AppFontSizes.medium,
            fontWeight: FontWeight.bold,
            fontFamily: "Delius",
          ),
        ),
      ),
    );
  }
}

class WelcomingText extends StatelessWidget {
  const WelcomingText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Discover Top Beauty Centers Near You',
      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
        color: AppColors.cPrimary,
        fontWeight: FontWeight.bold,
        fontSize: AppFontSizes.large,
        fontFamily: "Delius",
        letterSpacing: 2,
      ),
    );
  }
}

class BackgroundBlackLayer extends StatelessWidget {
  const BackgroundBlackLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(color: Colors.black.withAlpha(200)),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.asset('assets/images/onboarding.jpg', fit: BoxFit.cover),
    );
  }
}
