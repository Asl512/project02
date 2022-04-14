import 'package:flutter/material.dart';
import 'package:lan_code/back-end/domain/entities/city_entity.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/images.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/pages/navigation.dart';
import 'package:lan_code/ui/widgets/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CityCardWidget extends StatelessWidget {
  final CityEntity cityEntiti;

  const CityCardWidget({
    Key? key,
    required this.cityEntiti,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 20 - 5, 0,
          MediaQuery.of(context).size.width / 20 - 5, 10),
      child: TextButton(
        onPressed: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('city', cityEntiti.id);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const Navigation()),
            (route) => false,
          );
        },
        child: Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            ///КАРТИНКА
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                cityEntiti.photo,
                fit: BoxFit.cover,
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 7,
                loadingBuilder:
                    (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Placholder(double.infinity, MediaQuery.of(context).size.height / 7);
                },
                errorBuilder: (context, error, stackTrace) => Image.asset(excursionDef,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 10 + 20),
              ),
            ),

            ///НАЗВАНИЕ
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 3 +
                      cityEntiti.name.length.toDouble() * 11,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                ),
                Text(
                  cityEntiti.name.toUpperCase(),
                  style: Montserrat(
                    size: 25,
                    style: Bold,
                    color: White,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
