import 'package:flutter/material.dart';
import 'package:beuty_support/constants/colors.dart';
import 'package:beuty_support/constants/sizes.dart';

class WriteAReview extends StatefulWidget {
  const WriteAReview({super.key});

  @override
  State<WriteAReview> createState() => _WriteAReviewState();
}

class _WriteAReviewState extends State<WriteAReview> {
  int selectedRating = 0;
  final TextEditingController reviewController = TextEditingController();

  @override
  void dispose() {
    reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final kWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Write a Review",
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Delius",
            fontWeight: FontWeight.bold,
            fontSize: AppFontSizes.medium,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Padding(
        padding: EdgeInsets.all(kWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "How was your experience?",
              style: TextStyle(
                fontSize: AppFontSizes.medium * 1.1,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: List.generate(5, (index) {
                return IconButton(
                  onPressed: () {
                    setState(() {
                      selectedRating = index + 1;
                    });
                  },
                  icon: Icon(
                    Icons.star,
                    color: index < selectedRating
                        ? Colors.amber
                        : AppColors.cLightGrey,
                    size: 30,
                  ),
                );
              }),
            ),
            SizedBox(height: 20),
            Text(
              "Your Review",
              style: TextStyle(
                fontSize: AppFontSizes.medium,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: reviewController,
              maxLines: 6,
              decoration: InputDecoration(
                hintText: "Write something about your visit...",
                filled: true,
                fillColor: AppColors.cSecondary,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppBorderRadius.borderR),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.cPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppBorderRadius.borderR,
                    ),
                  ),
                ),
                onPressed: () {
                  // Handle review submission here
                },
                child: Text(
                  "Submit Review",
                  style: TextStyle(
                    color: AppColors.cWhite,
                    fontSize: AppFontSizes.medium,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
