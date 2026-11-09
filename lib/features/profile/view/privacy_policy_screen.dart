import 'package:desa/features/profile/controllers/get_pages_controller.dart';
import 'package:desa/utils/components/error_display/erroe_dispaly.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/components/warning_dispaly.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/loaders/loader/animated_loader.dart';
import 'package:desa/utils/resuableScreenStructure/resuable_screen_structure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../models/get_pages_model.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GetPagesController controller = Get.put(GetPagesController());
    controller.fetchPages();
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return ReusableScreenStructure(
        title: 'Privacy Policy',
        description:
            'Your privacy is important to us. This policy outlines how we collect, use, and protect your information.',
        bodyContent: Obx(() {
          if (controller.isLoading.value) {
            // Show loading indicator
            return SizedBox(
                height: height * 0.6,
                child: SizedBox(
                    width: width,
                    height: height * 0.9,
                    child: const AnimatedLoading()));
          }

          if (controller.errorMessage.isNotEmpty) {
            // Show error message when there's an error
            return ErrorDisplay(
              onTap: controller.fetchPages,
              errorMessage: controller.errorMessage.value,
            );
          }

          if (controller.pagesData.value != null) {
            // Fetch the description for ID 3
            final description = controller.pagesData.value!.data!
                .firstWhere(
                  (item) => item.id == 3,
                  orElse: () => Data(description: ''), // Default Data object
                )
                .description;

            if (description != null && description.isNotEmpty) {
              // Show the HTML content if description exists
              return Html(
                data: description,
                shrinkWrap: true,
              );
            } else {
              // Show "No Data Found" if description is empty
              return ErrorDisplay(
                onTap: controller.fetchPages,
                errorMessage: "No Data Found",
              );
            }
          }

          // Default fallback if pagesData is null
          return WarningDisplay();
        }));
  }
}
