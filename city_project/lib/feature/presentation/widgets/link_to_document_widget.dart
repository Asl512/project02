import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lan_code/common/colors.dart';
import 'package:lan_code/common/textStyle.dart';

class ListToDocumentWidget extends StatelessWidget {
  final String mainText;
  final String lintText;
  final void Function()? func;
  const ListToDocumentWidget({
    required this.mainText,
    this.func,
    this.lintText = " Подробнее.",
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width/5),
      child: RichText(textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: mainText,
              style: Montserrat(size: 12, color: Blue),
            ),
            TextSpan(
                text: lintText,
                style: Montserrat(style: SemiBold,size: 13, color:Red),
                recognizer: TapGestureRecognizer()
                  ..onTap = func
            )
          ]
        )
      )
    );
  }
}
