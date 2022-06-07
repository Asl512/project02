import 'package:flutter/material.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //https://pub.dev/packages/loading_animation_widget
    return Center(
      child: LoadingAnimationWidget.fourRotatingDots(
        color: Blue,
        size: 50,
      ),
    );
  }
}
