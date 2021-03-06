import 'package:flutter/material.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/icons.dart';
import 'package:lan_code/ui/common/images.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:shimmer/shimmer.dart';


///Тень для виджетов
BoxShadow ShadowForContainer(){
  return BoxShadow(color: Colors.black38,
      blurRadius: 5,
      spreadRadius: 0.5,
      offset: Offset(0, 7)
  );
}

///Пункты в диалоговом окне
class TextDialogWindows extends StatelessWidget {
  String title = '';
  String text = '';

  TextDialogWindows(String title, String text){
    this.title = title;
    this.text = text;
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(margin:EdgeInsets.only(bottom:5),
          child: Text(title, style: Montserrat(color:White,size: 13,style: SemiBold),),
        ),
        Container(margin:EdgeInsets.only(bottom:10),
            child: Text(text, style: Montserrat(color:White,size: 13),)
        ),
      ],
    );
  }
}

class WaitDialog extends StatelessWidget {
  String illiustration = '';
  String text = '';

  WaitDialog(String illiustration,String text){
    this.illiustration = illiustration;
    this.text = text;
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(illiustration,
              width: MediaQuery.of(context).size.width/1.3,
              height: MediaQuery.of(context).size.width/1.3, fit:BoxFit.fill),
          Container( padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/6),
            child:Text(text, style: Montserrat(style: SemiBold,size: 18,color:Blue)),
          )
        ]);
  }
}

class Placholder extends StatelessWidget {

  double? width;
  double? heigth;

  Placholder(double width,double heigth){
    this.width = width;
    this.heigth = heigth;
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.transparent.withOpacity(0.1),
        highlightColor: White,
        child: Container(width: double.infinity,height: heigth,
            color: White, alignment: Alignment.center,
            child: SizedBox(width: width,height: heigth)
        )
    );
  }
}

class PhotoAuthor extends StatelessWidget {
  String? url;
  double? size;
  PhotoAuthor(this.url, {this.size = 40,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(borderRadius: BorderRadius.all(Radius.circular(500)),
        child: Image.network(url.toString(),
          fit: BoxFit.cover,
          width: size, height: size,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(avatarDef,
              width: size, height: size,
            );
          },
        )
    );
  }
}

class GuideCheck extends StatelessWidget {
  final bool? check;
  final double? size;
  final double? mSize;
  GuideCheck(this.check,{this.size = 40, this.mSize = 15,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(check == true)
    {
      return Container(width: size,height: size,
          alignment: Alignment.bottomRight,
          child: SizedBox(width: mSize,height: mSize,
              child: iconConfirmation)
      );
    }
    else
    {
      return SizedBox(width: size, height: size);
    }
  }
}

