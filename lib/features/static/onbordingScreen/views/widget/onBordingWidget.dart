import 'package:desa/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class OnBoardingWidget extends StatelessWidget {
  final controller;

  final String image;
  final int index;

  OnBoardingWidget({
    Key? key,
    required this.controller,
    required this.image,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    BorderRadiusGeometry borderRadius = BorderRadius.zero;
    List<BoxShadow> boxShadows = [
      BoxShadow(
        color: AppColor.primaryColor3.withOpacity(0.3),
        spreadRadius: 0,
        blurRadius: 50,
        offset: Offset(0, -5), // Top shadow
      ),
    ];

    if (index == 0) {
      borderRadius = BorderRadius.only(topLeft: Radius.circular(width * 0.19));
      boxShadows.add(BoxShadow(
        color: Colors.grey.withOpacity(0.3),
        spreadRadius: 0,
        blurRadius: 20,
        offset: Offset(-5, 0), // Left shadow
      ));
    } else if (index == 2) {
      borderRadius = BorderRadius.only(topRight: Radius.circular(width * 0.19));
      boxShadows.add(BoxShadow(
        color: Colors.grey.withOpacity(0.3),
        spreadRadius: 0,
        blurRadius: 20,
        offset: Offset(10, 0), // Right shadow
      ));
    }
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              children: [
                if (index == 0) SizedBox(width: width * 0.06),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: borderRadius,
                      boxShadow: boxShadows,
                    ),
                    child: ClipRRect(
                      borderRadius: borderRadius,
                      child: Image.asset(
                        image,
                        height: height * 0.654,
                        width: width,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                if (index == 2) SizedBox(width: width * 0.06),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
