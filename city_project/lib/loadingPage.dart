import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'assets/style.dart';
import 'assets/finally.dart';

class Loading extends StatefulWidget
{
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Grey,

        body:WaitDialog(iLoading,"textLoading".tr())
    );
  }
}