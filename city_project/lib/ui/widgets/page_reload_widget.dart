import 'package:flutter/material.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/pages/navigation.dart';

class PageReloadWidget extends StatelessWidget {
  final String errorText;
  const PageReloadWidget(this.errorText,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height:  MediaQuery.of(context).size.height/1.25,
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  errorText,
                  style: Montserrat(style: Bold,size: 30),
                  textAlign: TextAlign.center,
                ),
                IconButton(
                    onPressed: ()=>Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const Navigation()), (_) => false),
                    icon: const Icon(
                      Icons.replay,
                      size: 30,
                      color: Red,
                    )
                )
              ],
            ),
          ),
        )
    );
  }
}
