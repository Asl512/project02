import 'package:flutter/material.dart';
import 'package:lan_code/feature/presentation/widgets/style.dart';

class BackgroundPictureWidget extends StatelessWidget {
  final String url;
  final String def;
  const BackgroundPictureWidget({
    required this.def,
    required this.url,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          url,
          fit: BoxFit.cover,
          width: double.infinity,
          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress){
            if (loadingProgress == null) return child;
            return Placholder(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
            },
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
                def,
                fit: BoxFit.cover,
                width: double.infinity
            );},
        ),
        Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5)
            )
        )
      ],
    );
  }
}
