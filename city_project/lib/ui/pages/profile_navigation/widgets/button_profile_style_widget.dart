import 'package:flutter/material.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/textStyle.dart';

class ButtonProfileStyleWidget extends StatelessWidget{

  final String title;
  final String description;
  final Widget icon;
  final void Function()? func;
  const ButtonProfileStyleWidget({Key? key,
    required this.title,
    required this.description,
    this.func,
    required this.icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: func,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: icon,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Montserrat(style: SemiBold, size: 16)),
                  SizedBox(
                      width: MediaQuery.of(context).size.width/1.5,
                      child: Text(description, style: Montserrat(size: 14))
                  )
                ]
              ),
              const Icon(Icons.arrow_forward_ios,color: Blue)
            ],
          )
      ),
    );
  }
}

class ButtonProfileStyleWidgetEasy extends StatelessWidget{

  final String title;
  final void Function()? func;
  const ButtonProfileStyleWidgetEasy({Key? key,
    required this.title,
    this.func
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: func,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: Montserrat(style: SemiBold, size: 16)),
              const Icon(Icons.arrow_forward_ios,color: Blue)
            ],
          )
      ),
    );
  }
}