import 'package:flutter/material.dart';
import 'package:lan_code/common/icons.dart';

class VerifiedUserWidget extends StatelessWidget {
  final bool check;
  final double? size;
  final double? mSize;
  VerifiedUserWidget(
      this.check,{
        this.size = 40,
        this.mSize = 15,
        Key? key
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(check) {
      return Container(
          width: size,
          height: size,
          alignment: Alignment.bottomRight,
          child: SizedBox(
              width: mSize,
              height: mSize,
              child: iconConfirmation
          )
      );
    } else {
      return SizedBox(width: size, height: size);
    }
  }
}