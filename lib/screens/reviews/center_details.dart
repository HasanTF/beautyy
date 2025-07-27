import 'package:beuty_support/constants/colors.dart';
import 'package:beuty_support/constants/sizes.dart';
import 'package:flutter/material.dart';

class CenterDetails extends StatelessWidget {
  const CenterDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final kWidth = size.width;
    final kHeight = size.height;

    return Scaffold(
      backgroundColor: AppColors.cWhite,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.cWhite,
        elevation: 1,
        title: Text(
          "Glamour Beauty Center",
          style: TextStyle(
            color: Colors.black,
            fontSize: AppFontSizes.medium,
            fontWeight: FontWeight.bold,
            fontFamily: "Delius",
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CenterImage(kWidth: kWidth, kHeight: kHeight),
              CenterDetal(kWidth: kWidth),
              WriteReviewButton(kWidth: kWidth),
              Reviews(kWidth: kWidth, kHeight: kHeight),
            ],
          ),
        ),
      ),
    );
  }
}

class Reviews extends StatelessWidget {
  const Reviews({super.key, required this.kWidth, required this.kHeight});

  final double kWidth;
  final dynamic kHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(kWidth * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Reviews",
            style: TextStyle(
              color: Colors.black,
              fontSize: AppFontSizes.medium,
              fontWeight: FontWeight.bold,
              fontFamily: "Delius",
              shadows: AppShadows.primaryShadow,
            ),
          ),
          ListView.builder(
            itemCount: 5,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: kHeight * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage(
                            "assets/images/avatar.jpg",
                          ),
                          backgroundColor: AppColors.cPrimary.withAlpha(51),
                        ),
                        SizedBox(width: 18.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hasan",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: AppFontSizes.medium * 0.75,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 14.0,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 14.0,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 14.0,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 14.0,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 14.0,
                                ),
                                SizedBox(width: 10.0),
                                Text(
                                  "5",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: AppFontSizes.small,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "The best in the world",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: AppFontSizes.small,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    Text(
                      "Jul 10, 2025",
                      style: TextStyle(
                        color: AppColors.cLightGrey,
                        fontSize: AppFontSizes.small,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class WriteReviewButton extends StatelessWidget {
  final dynamic kWidth;

  const WriteReviewButton({super.key, required this.kWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: kWidth * 0.05),
      decoration: BoxDecoration(
        color: AppColors.cPrimary,
        borderRadius: BorderRadius.circular(AppBorderRadius.borderR),
      ),
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/writeareview');
        },
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          overlayColor: Colors.transparent,
        ),
        child: Text(
          'Write a Review',
          style: TextStyle(
            fontSize: AppFontSizes.medium,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class CenterDetal extends StatelessWidget {
  final dynamic kWidth;

  const CenterDetal({super.key, required this.kWidth});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(kWidth * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Glamour Beauty Center",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: AppFontSizes.medium * 1.1,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Delius",
                ),
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 18.0),
                      Icon(Icons.star, color: Colors.amber, size: 18.0),
                      Icon(Icons.star, color: Colors.amber, size: 18.0),
                      Icon(Icons.star, color: Colors.amber, size: 18.0),
                      Icon(Icons.star, color: Colors.amber, size: 18.0),
                    ],
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    "4,5",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    "·123 Eim St",
                    style: TextStyle(
                      color: AppColors.cLightGrey,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
              Text(
                "Damascus",
                style: TextStyle(color: AppColors.cLightGrey, fontSize: 16.0),
              ),
              Text(
                "555-1254",
                style: TextStyle(color: AppColors.cLightGrey, fontSize: 16.0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CenterImage extends StatelessWidget {
  const CenterImage({super.key, required this.kWidth, required this.kHeight});

  final double kWidth;
  final double kHeight;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/center.jpg",
      fit: BoxFit.fill,
      width: kWidth,
      height: kHeight * 0.22,
    );
  }
}
