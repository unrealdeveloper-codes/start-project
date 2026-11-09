import 'package:flutter/material.dart';

class ImageTitleCardData {
  final String heading;
  final String svg;
  final String? number;
  final VoidCallback onTap;

  ImageTitleCardData({
    required this.heading,
    required this.svg,
     this.number,
    required this.onTap,
  });
}
