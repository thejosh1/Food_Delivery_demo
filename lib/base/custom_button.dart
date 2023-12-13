import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final double? fontSize;
  final bool transparent;
  final double radius;
  final IconData? icon;
  CustomButton({Key? key,
    this.onPressed,
    required this.buttonText,
    this.margin,
    this.height,
    this.width=280,
    this.fontSize,
    this.transparent=false,
    this.radius=5,
    this.icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle _flatButton = TextButton.styleFrom(
      backgroundColor: onPressed==null?Theme.of(context).disabledColor:transparent?Colors.transparent:Theme.of(context).primaryColor,
      minimumSize: Size(width==null?Dimensions.screenWidth:width!, height!=null?height!:Dimensions.height45+5),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius)
      )
    );
    return Center(
      child: SizedBox(
        width: width ?? Dimensions.screenWidth,
        height: height?? Dimensions.height45+5,
        child: TextButton(
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon!=null?Padding(
                  padding: EdgeInsets.only(right: Dimensions.width10/2),
                  child: Icon(icon, color: transparent?Theme.of(context).primaryColor:Theme.of(context).cardColor,)
              ):SizedBox(),
              Text(buttonText, style: TextStyle(
                fontSize: fontSize ?? Dimensions.font16,
                color: transparent?Theme.of(context).primaryColor:Theme.of(context).cardColor
              ),)
            ],
          ),
          style: _flatButton,
        ),
      ),
    );
  }
}
