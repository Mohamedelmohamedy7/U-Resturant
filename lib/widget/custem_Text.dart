import 'package:flutter/material.dart';

class CustemText extends StatelessWidget {
  final String? text;
  final Color? color;
  final FontWeight?fontw;
  final double ?fontsize;
  final double ?space;
  final TextOverflow ?overflow;

  const CustemText({this.text,this.color, this.fontw, this.space,this.fontsize,this.overflow});

  @override
  Widget build(BuildContext context) {
    return Text(text!.length>20?text!.replaceRange(15, text!.length, "..."):"$text", style: TextStyle(
      color:color,
      fontWeight:fontw,
      letterSpacing:space,
      fontSize:fontsize,
      overflow: overflow,

    ),maxLines: 2,);
  }
}
