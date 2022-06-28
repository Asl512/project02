import 'package:flutter/material.dart';
import 'package:lan_code/ui/common/images.dart';
import 'package:lan_code/ui/widgets/style.dart';

class ImageBoxWidget extends StatelessWidget {
  final String url;

  const ImageBoxWidget({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Image.network(
        url,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        loadingBuilder: (
          BuildContext context,
          Widget child,
          ImageChunkEvent? loadingProgress,
        ) {
          if (loadingProgress == null) return child;
          return Center(
            child: Placholder(double.infinity, double.infinity)
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            excursionDef,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
