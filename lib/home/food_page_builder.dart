import 'package:flutter/material.dart';

class FoodPageBuilder extends StatefulWidget {
  const FoodPageBuilder({Key? key}) : super(key: key);

  @override
  State<FoodPageBuilder> createState() => _FoodPageBuilderState();
}

class _FoodPageBuilderState extends State<FoodPageBuilder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
        return _buildPage(index);
      }),
    );
  }
  Widget _buildPage(int index){
    return Container(
      height: 220,
      margin: EdgeInsets.only(left: 5, right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30)
      ),
    );
  }
  
}


