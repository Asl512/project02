import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'assets/style.dart';
import 'assets/finally.dart';
import 'assets/text.dart';

class Authorization extends StatefulWidget
{
  const Authorization({Key? key}) : super(key: key);

  @override
  State<Authorization> createState() => _AuthorizationState();
}

class _AuthorizationState extends State<Authorization> {

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Column(children:
      [
        ///HEADER
        Flexible(flex: 1,
            child:Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
            )
        ),

        ///BODY
        Flexible(flex: 2,
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
            )
        )
      ]),
    );
  }
}