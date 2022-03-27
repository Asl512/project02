import 'package:flutter/material.dart';
import 'package:lan_code/common/colors.dart';
import 'package:lan_code/common/textStyle.dart';

class MyTicketsPage extends StatelessWidget {
  const MyTicketsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        color:Grey,
        child: Center(
            child: Text("Мои билеты",style: Montserrat(color:Blue,size: 40,style: SemiBold))
        )
    );
  }
}
