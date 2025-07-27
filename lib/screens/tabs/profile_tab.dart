import 'package:beuty_support/constants/colors.dart';
import 'package:beuty_support/constants/sizes.dart';
import 'package:beuty_support/firebase/auth_sevices.dart';
import 'package:beuty_support/screens/auth/user_services/change_password.dart';
import 'package:beuty_support/screens/auth/user_services/delete_account.dart';
import 'package:beuty_support/screens/auth/user_services/update_username.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final kWidth = screenSize.width;
    final kHeight = screenSize.height;

    final user = FirebaseAuth.instance.currentUser;
    final displayName = user?.displayName ?? "User";
    final email = user?.email ?? "Error loading E-Mail";

    void logout() async {
      try {
        await authServices.value.signOut();
      } on FirebaseAuthException catch (error) {
        debugPrint(error.message);
      }
    }

    return Scaffold(
      backgroundColor: AppColors.cWhite,
      appBar: AppBar(
        backgroundColor: AppColors.cWhite,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "My Profile",
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            SizedBox(
              height: 3,
              width: 60,
              child: Container(color: Colors.black),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kWidth * 0.05),
          child: SizedBox(
            height: kHeight * 0.75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                UserDetails(
                  kHeight: kHeight,
                  displayName: displayName,
                  email: email,
                ),
                SettingsText(),
                Services(kHeight: kHeight),
                InkWell(
                  onTap: () async {
                    final shouldLogout = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Confirm Logout"),
                        content: const Text("Are you sure you want to logout?"),
                        actions: [
                          TextButton(
                            onPressed: () =>
                                Navigator.of(context).pop(false), // Cancel
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () =>
                                Navigator.of(context).pop(true), // Confirm
                            child: const Text("Logout"),
                          ),
                        ],
                      ),
                    );

                    if (shouldLogout == true) {
                      logout(); // Only logout if user confirmed
                    }
                  },

                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "Logout",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.red[800],
                        fontSize: AppFontSizes.small,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Services extends StatelessWidget {
  const Services({super.key, required this.kHeight});

  final double kHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const UpdateUsername()),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Update username",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: AppFontSizes.small * 0.9,
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: kHeight * 0.03),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ChangePassword()),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Change password",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: AppFontSizes.small * 0.9,
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: kHeight * 0.03),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const DeleteAccount()),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Delete my account",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: AppFontSizes.small * 0.9,
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: kHeight * 0.03),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "About this app",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: AppFontSizes.small * 0.9,
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: kHeight * 0.03),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SettingsText extends StatelessWidget {
  const SettingsText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Settings",
          style: TextStyle(
            color: Colors.black,
            fontSize: AppFontSizes.medium,
            fontWeight: FontWeight.bold,
            fontFamily: "Delius",
            shadows: AppShadows.primaryShadow,
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}

class UserDetails extends StatelessWidget {
  const UserDetails({
    super.key,
    required this.kHeight,
    required this.displayName,
    required this.email,
  });

  final double kHeight;
  final dynamic displayName;
  final dynamic email;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: AppShadows.primaryShadow,
        borderRadius: BorderRadius.circular(AppBorderRadius.borderR),
      ),
      child: Padding(
        padding: EdgeInsets.all(kHeight * 0.025),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/images/avatar.jpg"),
              backgroundColor: AppColors.cPrimary.withAlpha(51),
            ),
            SizedBox(height: 15),
            Text(
              displayName,
              style: TextStyle(
                color: Colors.black,
                fontSize: AppFontSizes.medium,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              email,
              style: TextStyle(
                color: AppColors.cLightGrey,
                fontSize: AppFontSizes.small * 0.75,
                // fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
