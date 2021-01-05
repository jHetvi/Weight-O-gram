import 'package:flutter/material.dart';
import 'package:weight_o_gram/Global/Colors/Colors.dart';
import 'package:weight_o_gram/Global/Colors/Gradient.dart';

class CustomButton extends StatelessWidget {
  final bool whiteBg;
  final VoidCallback onTap;
  final String text;
  final double width;
  final double height;
  final double fontSize;
  final TextStyle textStyle;
  final EdgeInsets padding;
  final Color bgColor;
  final double elevation;
  final Widget prefix;
  final FontWeight fontWeight;
  CustomButton.whiteBackground({
    this.text,
    this.width,
    this.height,
    this.onTap,
    this.fontSize,
    this.padding = const EdgeInsets.all(12),
    this.textStyle,
    this.bgColor = Colors.white,
    this.elevation = 5,
    this.prefix,
    this.fontWeight = FontWeight.bold,
  }) : whiteBg = true;
  CustomButton.gradientBackground({
    this.text,
    this.width,
    this.height,
    this.onTap,
    this.fontSize,
    this.padding = const EdgeInsets.all(12),
    this.textStyle,
    this.bgColor = Colors.white,
    this.elevation = 5,
    this.prefix,
    this.fontWeight = FontWeight.bold,
  }) : whiteBg = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              width: double.maxFinite,
              alignment: Alignment.center,
              child: Text(
                text,
                style: textStyle ??
                    TextStyle(
                      color: whiteBg ? blackColor() : whiteColor(),
                      fontSize: fontSize ?? 24,
                      fontWeight: fontWeight,
                    ),
              ),
            ),
            if (prefix != null)
              Positioned(
                left: 16,
                top: 0,
                bottom: 0,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: prefix,
                ),
              ),
          ],
        ),
        alignment: Alignment.center,
        padding: padding,
        decoration: BoxDecoration(
          color: whiteBg ? bgColor : null,
          gradient: whiteBg ? null : customGradient(),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: elevation,
              offset: Offset(elevation, elevation),
            ),
          ],
        ),
      ),
    );
  }
}
