import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/pages/guide/add_excursion_page/add_excursion_page.dart';
import 'package:lan_code/ui/widgets/style.dart';
import 'package:lan_code/ui/widgets/text_field_style.dart';

class AddPhoto extends StatefulWidget {
  final ControllerNewExcursion controller;

  const AddPhoto({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<AddPhoto> createState() => _AddPhotoState();
}

class _AddPhotoState extends State<AddPhoto> {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleTextFormField(text: "Фотографии"),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: White,
              boxShadow: [ShadowForContainer()],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: photosList(),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 15),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Отмеченная фотография будет использоваться как фон в вашей карточке экскурсии',
              style: Montserrat(color: Red.withOpacity(0.5), size: 11, style: SemiBold),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> photosList() {
    ///КНОПКА ДОБАВИТЬ ФОТО
    List<Widget> photos = [
      TextButton(
        onPressed: () async {
          final List<XFile>? selectedImages = await _picker.pickMultiImage();
          if (selectedImages!.isNotEmpty) {
            setState(() => widget.controller.imageList.addAll(selectedImages));
          }
        },
        child: Container(
          padding: const EdgeInsets.only(top: 5),
          height: MediaQuery.of(context).size.width / 5,
          width: MediaQuery.of(context).size.width / 5 * 1.2,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Blue,
          ),
          child: Column(
            children: [
              const Icon(
                Icons.camera_alt_outlined,
                color: White,
                size: 35,
              ),
              Text(
                'Добавить фотографию',
                style: Montserrat(size: 12, color: White),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    ];

    ///ФОТОГРАФИИ
    for (int i = 0; i < widget.controller.imageList.length; i++) {
      photos.add(
        Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            TextButton(
              onPressed: () => setState(() => widget.controller.indexBackImage = i),
              child: Container(
                decoration: BoxDecoration(
                  border: i == widget.controller.indexBackImage
                      ? Border.all(color: Red, width: 2)
                      : Border.all(color: White, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    File(widget.controller.imageList[i].path),
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.width / 5,
                    width: MediaQuery.of(context).size.width / 5 * 1.2,
                  ),
                ),
              ),
            ),
            Container(
              height: 25,
              width: 25,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: White,
                border: Border.all(color: Blue, width: 2),
                borderRadius: BorderRadius.circular(500),
              ),
              margin: const EdgeInsets.only(right: 5),
              padding: EdgeInsets.zero,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    if (widget.controller.indexBackImage == i) widget.controller.indexBackImage = 0;
                    widget.controller.imageList.removeAt(i);
                  });
                },
                padding: EdgeInsets.zero,
                iconSize: 30,
                icon: Text('x', style: Montserrat(style: Bold, color: Blue)),
              ),
            ),
          ],
        ),
      );
    }
    return photos;
  }
}
