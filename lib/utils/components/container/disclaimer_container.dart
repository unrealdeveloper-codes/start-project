import 'package:desa/utils/constants/app_sizer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DisclaimerContainer extends StatelessWidget {
  final String disclaimer;
  final EdgeInsetsGeometry? margin;
  const DisclaimerContainer({super.key, required this.disclaimer, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizer.horizontal15,
        vertical: AppSizer.vertical6,
      ),
      margin: margin ?? EdgeInsets.symmetric(horizontal: AppSizer.horizontal15),
      decoration: BoxDecoration(
        color: const Color(0xFFC0C0C0).withOpacity(0.12),
        border: Border.all(
          color: const Color(0xFFC0C0C0).withOpacity(0.5),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: RichText(
        text: TextSpan(
          style: GoogleFonts.manrope(
            fontSize: AppSizer.fontSize13,
            fontWeight: FontWeight.w400,
            color: Colors.black87, // Matches text color
          ),
          children: [
            TextSpan(
              text: 'Disclaimer: ',
              style: GoogleFonts.manrope(
                fontWeight: FontWeight.bold,
                fontSize: AppSizer.fontSize13,
              ),
            ),
            TextSpan(
              text: disclaimer,
            ),
          ],
        ),
      ),
    );
  }
}
