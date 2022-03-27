import 'package:flutter/material.dart';
import 'package:lan_code/common/colors.dart';
import 'package:lan_code/common/textStyle.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final void Function()? func;
  final Color textColor;
  final Color buttonColor;
  final double padding;
  const ButtonWidget({
    required this.text,
    this.func,
    this.padding = 30,
    this.textColor = White,
    this.buttonColor = Blue,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: TextButton(
          onPressed: func,
          child: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: const BorderRadius.all(Radius.circular(500))
              ),
              child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(text, style: Montserrat(style: SemiBold,size: 18,color: textColor))
              )
          )
      ),
    );
  }
}