import 'package:flutter/material.dart';

class CustomBackgroundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Custom-painted background
          CustomPaint(
            size: Size(double.infinity, double.infinity),
            painter: BackgroundPainter(),
          ),
          // Content at the bottom, with an illustration-like setup
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // Image.asset(
                //   'assets/checklist.png', // Replace with your actual image path
                //   width: 100, // Adjust size as needed
                // ),
                SizedBox(height: 10),
                Text(
                  'Grocery List',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.teal.shade100; // Light teal color

    // Draw top curved shape
    Path topPath = Path();
    topPath.moveTo(0, 0);
    topPath.lineTo(size.width, 0);
    topPath.lineTo(size.width, size.height * 0.1);
    topPath.quadraticBezierTo(
      size.width * 0.5, size.height * 0.2, // Control point for curve
      0, size.height * 0.1,                // End point
    );
    topPath.close();
    canvas.drawPath(topPath, paint);

    // Draw bottom curved shape with organic style
    Path bottomPath = Path();
    bottomPath.moveTo(0, size.height);
    bottomPath.lineTo(size.width, size.height);
    bottomPath.lineTo(size.width, size.height * 0.85);
    bottomPath.quadraticBezierTo(
      size.width * 0.7, size.height * 0.80, // Control point 1
      size.width * 0.5, size.height * 0.88, // Control point 2
    );
    bottomPath.quadraticBezierTo(
      size.width * 0.25, size.height * 0.95, // Control point 3
      0, size.height * 0.85,                // End point
    );
    bottomPath.close();
    canvas.drawPath(bottomPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
