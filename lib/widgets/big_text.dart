import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  Color? color;
  double size;
  final String text;
  TextOverflow overflow;
  BigText({Key? key, this.color = const Color(0xFF332d2b), required this.text, this.overflow = TextOverflow.ellipsis, this.size = 20}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400
      ),
    );
  }
}
