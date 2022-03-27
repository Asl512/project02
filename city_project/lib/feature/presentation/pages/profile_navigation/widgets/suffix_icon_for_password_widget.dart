import 'package:flutter/material.dart';
import 'package:lan_code/common/icons.dart';

class SuffixIconForPasswordWidget extends StatefulWidget {
  const SuffixIconForPasswordWidget({Key? key}) : super(key: key);

  @override
  _SuffixIconForPasswordWidgetState createState() => _SuffixIconForPasswordWidgetState();
}

class _SuffixIconForPasswordWidgetState extends State<SuffixIconForPasswordWidget> {
  bool _passwordVisible = true;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(right: 10),
        child: IconButton(
          icon: _passwordVisible == true ? iconShow : iconHide,
          onPressed: ()=>setState(()=>_passwordVisible = !_passwordVisible)
        )
    );
  }
}
