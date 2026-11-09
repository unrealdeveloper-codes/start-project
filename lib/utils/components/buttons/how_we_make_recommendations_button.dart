import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/constants/app_urls.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RecommendationsButton extends StatelessWidget {
  const RecommendationsButton({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    Future<void> lauchUrl(Uri url) async {
      if (!await launchUrl(
        url,
        mode: LaunchMode.inAppWebView,
      )) {
        throw Exception('Could not launch $url');
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizer.horizontal20),
      child: InkWell(
        onTap: () => lauchUrl(AppUrls.disclaimer),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: AppSizer.vertical5),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.info_outline,
                size: width * 0.045,
                color: const Color.fromARGB(255, 129, 129, 129),
              ),
              SizedBox(width: width * 0.02),
              MyManropeText(
                text: "How we make recommendations",
                color: const Color.fromARGB(255, 129, 129, 129),
                height: width * 0.004,
                fontWeight: FontWeight.w900,
                fontSize: AppSizer.fontSize12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
