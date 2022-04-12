import 'package:flutter/material.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/textStyle.dart';

class TextFieldWithShadow extends StatelessWidget {
  Widget? textField;
  List? error;
  bool errorText;

  TextFieldWithShadow(this.textField, {Key? key, List? error,this.errorText = false}) : super(key: key){
    if(error != null) {
      this.error = error;
    } else {
      this.error = [false,null];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            borderRadius: BorderRadius.circular(20),
            elevation: 7.0,
            shadowColor: Colors.black,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: error![0] ? Border.all(color: Red) : Border.all(color: White)
              ),
              child: textField,
            ),
          ),
          errorText && error![0] && error?.length == 2?
          Container(
              margin: const EdgeInsets.only(top: 10,left: 15),
              child: RichText(
                text: TextSpan(
                    text: error![1].toString(),
                    style: Montserrat(size: 13,color: Red)
                )
              )
          ):Container()
        ]
    );
  }
}

class TextFieldDecoration{
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  late InputDecoration inputDecoration;

  TextFieldDecoration({this.hintText,this.prefixIcon,this.suffixIcon}){
   inputDecoration =  InputDecoration(
       hintMaxLines: 3,
       hintStyle: Montserrat(color: Colors.black26, size: 15),
       hintText: hintText,
       counterText: '',
       //ИКОНКИ
       prefixIcon: prefixIcon,
       suffixIcon: suffixIcon,
       //СТИЛЬ
       border: OutlineInputBorder(
           borderRadius: BorderRadius.circular(20),
           borderSide: const BorderSide(
               width: 0,
               style: BorderStyle.none
           )
       ),
       fillColor: White,
       isDense: true,
       filled: true
   );
  }
}

class TitleTextFormField extends StatelessWidget {
  final String text;
  final bool required;

  const TitleTextFormField({
    required this.text,
    this.required = false,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10,bottom: 5),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(text: text, style: Montserrat(color: Blue, style: SemiBold,size: 17)),
            TextSpan(text: required?"*":"", style: Montserrat(color: Red))
          ],
        ),
      ),
    );
  }
}


class PrefixIconTextField extends StatelessWidget {
  Color? color;
  Widget icon;
  PrefixIconTextField({Key? key, required this.color,required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      width: 40,
      padding: const EdgeInsets.all(6),
      child: icon,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
            Radius.circular(10)),
      ),
    );
  }
}