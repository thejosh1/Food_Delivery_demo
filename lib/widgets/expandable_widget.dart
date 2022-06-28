import 'package:flutter/material.dart';
import 'package:food_delivery_demo/utils/colors.dart';
import 'package:food_delivery_demo/utils/dimensions.dart';
import 'package:food_delivery_demo/widgets/small_text.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firsthalf;
  late String secondhalf;

  final textHeight = Dimensions.textheight100;

  bool hiddenText = true;

  @override
  void initState(){
    super.initState();
    if(widget.text.length>textHeight){
      firsthalf = widget.text.substring(0, textHeight.toInt());
      secondhalf = widget.text.substring(textHeight.toInt()+1, widget.text.length);
    } else {
      firsthalf = widget.text;
      secondhalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondhalf.isEmpty?SmallText(text: firsthalf, size: Dimensions.font16, color: AppColors.paraColor, height: Dimensions.fontheight,):Column(
        children: [
          SmallText(
            text: hiddenText?(firsthalf+"..."):(firsthalf + secondhalf),
            size: Dimensions.font16,
            color: AppColors.paraColor, height: Dimensions.fontheight,),
          InkWell(
            onTap: (){
              setState((){
                hiddenText=!hiddenText;
              });
            },
            child: Row(
              children: [
                SmallText(text: hiddenText?"show more":"show less", color: AppColors.mainColor,),
                Icon(hiddenText?Icons.arrow_drop_down:Icons.arrow_drop_up, color: AppColors.mainColor,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
