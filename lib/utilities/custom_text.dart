import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final String font;
  final FontWeight weight;

  CustomText(
      {@required this.text, this.size, this.color, this.weight, this.font});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size ?? 16,
        color: color ?? Colors.black,
        fontWeight: weight ?? FontWeight.normal,
        // fontFamily: 'Poppins',
        fontFamily: font ?? 'OpenSans',
        decoration: TextDecoration.none,
        letterSpacing: 1,
        // decoration:
        //     Responsive.isMobile(context) ? null : TextDecoration.underline,
        // decorationColor:
        //     Responsive.isMobile(context) ? null : Colors.black54
      ),
    );
  }
}
