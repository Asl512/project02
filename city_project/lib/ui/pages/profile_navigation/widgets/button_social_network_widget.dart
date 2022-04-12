import 'package:flutter/material.dart';
import 'package:lan_code/ui/common/colors.dart';

class ButtonSocialNetworkWidget extends StatelessWidget {
  final Widget icon;
  final void Function()? func;
  const ButtonSocialNetworkWidget({
    required this.icon,
    this.func,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: Alignment.center,
        children: [
          Container(
              width: 45,
              height: 45,
              decoration:const BoxDecoration(
                  color: White,
                  borderRadius: BorderRadius.all(Radius.circular(500))
              )
          ),
          IconButton(
              onPressed:func,
              icon: icon,
              iconSize: 50
          )
        ]
    );
  }
}
