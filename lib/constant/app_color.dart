import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Colors.blue;
  static const Color backgroundVote = Color.fromARGB(255, 243, 243, 243);
  static const Color offColor = Color.fromARGB(255, 83, 83, 83);
  static const Color grey = Colors.grey;
  static const Color white = Colors.white;
  static const Color black = Colors.black;
}

class GradientUtils {
  // Ngăn không cho tạo instance của class
  GradientUtils._();

  // Linear Gradient
  static  LinearGradient primaryGradient = LinearGradient(
    // colors: [
    //   Colors.greenAccent,
    //   Colors.blue],
    colors: [
      Color(0xffA77D40),
      Color(0xffD9BB83),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static  LinearGradient primaryBackground = LinearGradient(
    // colors: [
    //   Colors.greenAccent,
    //   Colors.blue],
    colors: [
      Colors.red.withOpacity(0.2),
      Colors.orange.withOpacity(0.2),
      Colors.yellow.withOpacity(0.2)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Radial Gradient
  static const RadialGradient radialGradient = RadialGradient(
    colors: [Colors.purple, Colors.red],
    center: Alignment.center,
    radius: 0.8,
  );
  // Radial Gradient
  static const LinearGradient offGradient = LinearGradient(
    colors: [AppColors.offColor, Colors.grey],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Sweep Gradient
  static const SweepGradient sweepGradient = SweepGradient(
    colors: [Colors.yellow, Colors.orange, Colors.red, Colors.yellow],
    center: Alignment.center,
    startAngle: 0.0,
    endAngle: 3.14 * 2, // Full circle
  );

  // Gradient with custom colors
  static LinearGradient customLinearGradient(List<Color> colors) {
    return LinearGradient(
      colors: colors,
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }

  // Gradient with opacity
  static LinearGradient gradientWithOpacity(
      Color color1, Color color2, double opacity) {
    return LinearGradient(
      colors: [
        color1.withOpacity(opacity),
        color2.withOpacity(opacity),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
}
