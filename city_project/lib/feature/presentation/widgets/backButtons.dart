import 'package:flutter/material.dart';
import '../../../common/colors.dart';

class ButtonBack extends StatelessWidget {
  final Color color;
  const ButtonBack({Key? key, this.color = Blue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 70,
        width: 50,
        decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(bottomRight: Radius.circular(40))
        ),
        child: IconButton(icon: const Icon(Icons.arrow_back_ios,size: 20,color: White),
            onPressed: ()=>Navigator.pop(context)
        )
    );
  }
}