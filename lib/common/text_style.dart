import 'package:flutter/material.dart';

class CustomTextStyle extends StatelessWidget {
  String text;
  Color ?color;
  double ?fontsize;
  FontWeight ? fontWeight;
   CustomTextStyle({super.key,required this.text,this.color,this.fontsize,  this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(text,
    style: TextStyle(fontWeight: fontWeight,color: color,fontSize: fontsize),
    );
  }
}