import 'package:flutter/material.dart';
import 'package:lan_code/ui/common/images.dart';

class PhotoUserWidget extends StatelessWidget {
  String url;
  double? size;
  PhotoUserWidget(this.url, {this.size = 40,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(500)),
        child: Image.network(
          url,
          fit: BoxFit.cover,
          width: size,
          height: size,
          errorBuilder: (context, error, stackTrace)=>
              Image.asset(
                avatarDef,
                width: size,
                height: size,
              )
        )
    );
  }
}