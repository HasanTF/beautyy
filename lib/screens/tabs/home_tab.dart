import 'package:beuty_support/constants/colors.dart';
import 'package:beuty_support/constants/sizes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final kWidth = screenSize.width;

    final user = FirebaseAuth.instance.currentUser;
    final displayName = user?.displayName ?? "User";

    return Scaffold(
      backgroundColor: AppColors.cWhite,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kWidth * 0.05),
          child: Column(
            children: [
              SizedBox(height: 10.0),
              Header(displayName: displayName),
              SizedBox(height: 15.0),
              SearchBar(),
              SizedBox(height: 8.0),
              BeutySupport(),
              SizedBox(height: 15.0),
              Locations(),
              SizedBox(height: 8.0),
              CentersText(),
              SizedBox(height: 15.0),
              Centers(),
            ],
          ),
        ),
      ),
    );
  }
}

class Centers extends StatelessWidget {
  const Centers({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(top: 2, bottom: 15.0, left: 4, right: 4),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/centerdetails');
              },
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppBorderRadius.borderR),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      spreadRadius: 0.1,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "assets/images/center.jpg",
                        fit: BoxFit.cover,
                        height: AppFontSizes.large * 2.75,
                        width: AppFontSizes.large * 2.75,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Glamour Beuty Center",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: AppFontSizes.small * 1.3,
                              fontFamily: "Zain",
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 20),
                              Icon(Icons.star, color: Colors.amber, size: 20),
                              Icon(Icons.star, color: Colors.amber, size: 20),
                              Icon(Icons.star, color: Colors.amber, size: 20),
                              Icon(Icons.star, color: Colors.amber, size: 20),
                              Icon(Icons.star, color: Colors.amber, size: 20),
                              SizedBox(width: 8.0),
                              Text("4.0"),
                            ],
                          ),
                          Text(
                            "123 Elm St",
                            style: TextStyle(
                              color: AppColors.cLightGrey,
                              fontSize: AppFontSizes.small * 0.75,
                            ),
                          ),
                          Text(
                            "An experiend beuty specialists",
                            style: TextStyle(
                              color: AppColors.cLightGrey,
                              fontSize: AppFontSizes.small,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CentersText extends StatelessWidget {
  const CentersText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Centers",
          style: TextStyle(
            color: Colors.black,
            fontSize: AppFontSizes.medium,
            fontWeight: FontWeight.bold,
            fontFamily: "Delius",
            shadows: AppShadows.primaryShadow,
          ),
        ),
      ],
    );
  }
}

class Locations extends StatelessWidget {
  const Locations({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppBorderRadius.borderR),
        ),
        child: Image.asset("assets/images/Locations.jpg", fit: BoxFit.cover),
      ),
    );
  }
}

class BeutySupport extends StatelessWidget {
  const BeutySupport({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Beuty Support",
          style: TextStyle(
            color: Colors.black,
            fontSize: AppFontSizes.medium,
            fontWeight: FontWeight.bold,
            fontFamily: "Delius",
            shadows: AppShadows.primaryShadow,
          ),
        ),
      ],
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppBorderRadius.borderR),
          boxShadow: AppShadows.primaryShadow,
        ),
        child: TextField(
          style: TextStyle(color: AppColors.cPrimary),
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: AppColors.cPrimary),
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: AppColors.cPrimary),
            contentPadding: EdgeInsets.symmetric(vertical: 8),
          ),
          textAlignVertical: TextAlignVertical.center,
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  final dynamic displayName;

  const Header({super.key, required this.displayName});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.cPrimary.withAlpha(175),
                    blurRadius: 10,
                    offset: Offset(1, 1),
                  ),
                  BoxShadow(
                    color: AppColors.cSecondary.withAlpha(175),
                    blurRadius: 5,
                    offset: Offset(-1, 0.5),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 32,
                backgroundImage: AssetImage("assets/images/avatar.jpg"),
                backgroundColor: AppColors.cPrimary.withAlpha(51),
              ),
            ),
            SizedBox(width: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome back,",
                  style: TextStyle(
                    color: AppColors.cLightGrey,
                    fontSize: AppFontSizes.small,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  displayName,
                  style: TextStyle(
                    color: AppColors.cPrimary,
                    fontSize: AppFontSizes.medium,
                    fontWeight: FontWeight.w800,
                    fontFamily: "Delius",
                  ),
                ),
              ],
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppBorderRadius.borderR),
            boxShadow: AppShadows.primaryShadow,
          ),
          child: Icon(Icons.notifications_outlined, size: 28),
        ),
      ],
    );
  }
}
