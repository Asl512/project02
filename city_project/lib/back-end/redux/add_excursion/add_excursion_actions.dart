import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lan_code/back-end/data/repositories/category_people_data_repository.dart';
import 'package:lan_code/back-end/data/repositories/city_data_repository.dart';
import 'package:lan_code/back-end/data/repositories/currency_data_repository.dart';
import 'package:lan_code/back-end/data/repositories/tag_data_repository.dart';
import 'package:lan_code/back-end/data/repositories/type_data_repository.dart';
import 'package:lan_code/back-end/data/repositories/type_move_data_repository.dart';
import 'package:lan_code/back-end/data/repositories/user_data_repository.dart';
import 'package:lan_code/back-end/domain/entities/categorie_people_entity.dart';
import 'package:lan_code/back-end/domain/entities/city_entity.dart';
import 'package:lan_code/back-end/domain/entities/currency_entity.dart';
import 'package:lan_code/back-end/domain/entities/tag_entity.dart';
import 'package:lan_code/back-end/domain/entities/type_entity.dart';
import 'package:lan_code/back-end/domain/entities/type_move_entity.dart';
import 'package:lan_code/back-end/domain/entities/user_entity.dart';
import 'package:lan_code/back-end/domain/useCases/category_people_useCase.dart';
import 'package:lan_code/back-end/domain/useCases/city_useCase.dart';
import 'package:lan_code/back-end/domain/useCases/currency_useCase.dart';
import 'package:lan_code/back-end/domain/useCases/tag_useCase.dart';
import 'package:lan_code/back-end/domain/useCases/type_move_useCase.dart';
import 'package:lan_code/back-end/domain/useCases/type_useCase.dart';
import 'package:lan_code/back-end/domain/useCases/user_useCase.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/pages/guide/add_excursion_page/add_excursion_page.dart';
import 'package:lan_code/ui/pages/navigation.dart';
import 'package:lan_code/ui/widgets/libary/customSnackBar.dart';
import 'package:lan_code/ui/widgets/libary/topSnackBart.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

abstract class AddExcursionAction {}

class LoadAddExcursionAction extends AddExcursionAction {}

class ErrorAddExcursionAction extends AddExcursionAction {}

class ShowAddExcursionAction extends AddExcursionAction {
  final List<CityEntity> cities;
  final List<TypeEntity> types;
  final List<TagEntity> tags;
  final List<TypeMoveEntity> typesMove;
  final List<CategoryPeopleEntity> categoriesPeople;
  final List<CurrencyEntity> currencies;

  ShowAddExcursionAction({
    required this.cities,
    required this.tags,
    required this.categoriesPeople,
    required this.types,
    required this.currencies,
    required this.typesMove,
  });
}

ThunkAction AddExcursionThunkAction(BuildContext context) => (Store store) async {
      store.dispatch(LoadAddExcursionAction());
      UserEntity? responseUser =
          await GetUser(UserDataRepository()).call(store.state.authState.token);
      if (responseUser == null || !responseUser.guidePermit) {
        store.dispatch(ErrorAddExcursionAction());
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const Navigation(index: 0)),
          (route) => false,
        );
      } else {
        List<CityEntity>? responseCities = await GetAllCity(CityDataRepository()).call();
        List<TypeEntity>? responseTypes = await GetAllType(TypeDataRepository()).call();
        List<TypeMoveEntity>? responseTypesMove =
            await GetAllTypeMove(TypeMoveDataRepository()).call();
        List<TagEntity>? responseTags = await GetAllTag(TagDataRepository()).call();
        List<CategoryPeopleEntity>? responseCategoriesPeople =
            await GetAllCategoryPeople(CategoryPeopleDataRepository()).call();
        List<CurrencyEntity>? responseCurrencies =
            await GetAllCurrency(CurrencyDataRepository()).call();

        if (responseCities != null &&
            responseTags != null &&
            responseTypes != null &&
            responseTypesMove != null &&
            responseCurrencies != null &&
            responseCategoriesPeople != null) {
          store.dispatch(
            ShowAddExcursionAction(
              tags: responseTags,
              cities: responseCities,
              types: responseTypes,
              currencies: responseCurrencies,
              typesMove: responseTypesMove,
              categoriesPeople: responseCategoriesPeople,
            ),
          );
        } else {
          store.dispatch(ErrorAddExcursionAction());
        }
      }
    };

abstract class InsertExcursionAction {}

class LoadInsetExcursionAction extends InsertExcursionAction {}

class ChangeTypeInsetExcursionAction extends InsertExcursionAction {
  final TypeEntity type;

  ChangeTypeInsetExcursionAction({required this.type});
}

class ChangeCurrencyInsetExcursionAction extends InsertExcursionAction {
  final CurrencyEntity currency;

  ChangeCurrencyInsetExcursionAction({required this.currency});
}

class ErrorInsetExcursionAction extends InsertExcursionAction {
  final List? errorName;
  final List? errorCity;
  final List? errorGroupSize;
  final List? errorDuration;
  final List? errorMeetPoint;
  final List? errorStandardPrice;
  final List? errorTypesMove;
  final List? errorDescription;

  ErrorInsetExcursionAction({
    this.errorName,
    this.errorStandardPrice,
    this.errorMeetPoint,
    this.errorDuration,
    this.errorCity,
    this.errorGroupSize,
    this.errorTypesMove,
    this.errorDescription,
  });
}

Future<bool> checkAuth({
  required BuildContext context,
  required String? token,
}) async {
  if (token == null) {
    showTopSnackBar(
      context,
      CustomSnackBar.error(
        message: 'Ошибка обработки запроса',
        textStyle: Montserrat(size: 15, color: White),
      ),
    );

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const Navigation(index: 0)),
      (route) => false,
    );
    return false;
  } else {
    UserEntity? responseUser = await GetUser(UserDataRepository()).call(token);
    if (responseUser == null || !responseUser.guidePermit) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: 'Ошибка обработки запроса',
          textStyle: Montserrat(size: 15, color: White),
        ),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const Navigation(index: 0)),
        (route) => false,
      );
      return false;
    } else {
      return true;
    }
  }
}

ThunkAction InsertThunkAction({
  required context,
  required ControllerNewExcursion controller,
}) =>
    (Store store) async {
      store.dispatch(LoadInsetExcursionAction());
      bool error = false;
      List? errorName;
      List? errorCity;
      List? errorGroupSize;
      List? errorDuration;
      List? errorMeetPoint;
      List? errorStandardPrice;
      List? errorTypesMove;
      List? errorDescription;

      if (await checkAuth(context: context, token: store.state.authState.token)) {
        if (controller.typesMove.isEmpty) {
          error = true;
          errorTypesMove = [true, 'Выберите тип передвижения'];
        }

        if (controller.name.text.trim() == '') {
          error = true;
          errorName = [true, 'Введите название'];
        } else if (controller.name.text.trim().length <= 3) {
          error = true;
          errorName = [true, 'Слишком короткое название'];
        }

        if (controller.description.text.trim() == '') {
          error = true;
          errorDescription = [true, 'Введите описание экскурсии'];
        } else if (controller.description.text.trim().length <= 20) {
          error = true;
          errorDescription = [true, 'Слишком короткое описание экскурсии'];
        }

        if (controller.city == null) {
          error = true;
          errorCity = [true, 'Выберите город'];
        }

        if (controller.type.id != '3') {
          if (controller.meetPoint.text == '') {
            error = true;
            errorMeetPoint = [true, 'Введите место сбора'];
          } else if (controller.meetPoint.text.length <= 5) {
            error = true;
            errorMeetPoint = [true, 'Слишком короткое название места сбора'];
          }
        }

        if (controller.sizeGroup.text.trim() == '') {
          error = true;
          errorGroupSize = [true, 'Введите размер группы'];
        } else {
          try {
            int size = int.parse(controller.sizeGroup.text.trim());
            if (size <= 1) {
              error = true;
              errorGroupSize = [true, 'Размер группы должен быть больше 1 человека'];
            }
          } catch (e) {
            error = true;
            errorGroupSize = [true, 'Не верный формат'];
          }
        }

        if (controller.standardPrice.text.trim() == '') {
          error = true;
          errorStandardPrice = [true, 'Введите стоимость стандартного билета'];
        } else {
          try {
            int standardPrice = int.parse(controller.standardPrice.text.trim());
            if (standardPrice <= 200) {
              error = true;
              errorStandardPrice = [true, 'Стоимость должна быть больше 200р.'];
            }
          } catch (e) {
            error = true;
            errorStandardPrice = [true, 'Не верный формат'];
          }
        }

        if (!error) {
          try {
            /*void uploadImg() async {
            String fileName = controller.imageList[0].name;
            var bytes = await controller.imageList[0].readAsBytes();
            try {
              print("start, $fileName");
              firebase_storage.Reference _storage =
              firebase_storage.FirebaseStorage.instance.ref('photoExcursion/$fileName');
              await _storage.putData(bytes);
              print("++++");
              print("start URL");
              String url = await firebase_storage.FirebaseStorage.instance
                  .ref('photoExcursion/$fileName')
                  .getDownloadURL();
              print(url);
            } catch (e) {
              print(e);
            }
          }*/

            await FirebaseFirestore.instance.collection('excursion').add({
              "name": controller.name.text.trim(),
              "photo": "null",
              "organizationalDetails": controller.organizationalDetails.text.trim() == ''
                  ? 'null'
                  : controller.organizationalDetails.text.trim(),
              "addServices": controller.addServices.text.trim() == ''
                  ? 'null'
                  : controller.addServices.text.trim(),
              "included":
                  controller.included.text.trim() == '' ? 'null' : controller.included.text.trim(),
              "tags": controller.tags.map((e) => e.id).toList(),
              "duration": controller.duration.toString() + ' ' + controller.durationType,
              "description": controller.description.text.trim(),
              "idGuide": store.state.authState.token,
              "type": controller.type.id,
              "moment": true,
              "moveType": controller.typesMove.map((e) => e.id).toList(),
              "isCheck": false,
              "specialPrice": controller.categoriesPeoplePrice
                  .map((list) => {
                        "idCategory": list.first.id,
                        "price": int.parse(list.last),
                      })
                  .toList(),
              "meetPoint": controller.meetPoint.text.trim() == ''
                  ? 'null'
                  : controller.meetPoint.text.trim(),
              "rating": [0, 1],
              "currency": controller.currency.code,
              "groupSize": int.parse(controller.sizeGroup.text.trim()),
              "standartPrice": int.parse(controller.standardPrice.text.trim()),
              "idCity": controller.city!.id,
            });

            showTopSnackBar(
              context,
              CustomSnackBar.success(
                message: 'Вы добавили экскурсию',
                textStyle: Montserrat(size: 15, color: White),
              ),
            );

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const Navigation(index: 0)),
              (route) => false,
            );
          } catch (e) {
            store.dispatch(ErrorInsetExcursionAction());
            showTopSnackBar(
              context,
              CustomSnackBar.error(
                message: e.toString(),
                textStyle: Montserrat(size: 15, color: White),
              ),
            );
          }
        } else {
          store.dispatch(ErrorInsetExcursionAction(
            errorName: errorName,
            errorCity: errorCity,
            errorGroupSize: errorGroupSize,
            errorDuration: errorDuration,
            errorMeetPoint: errorMeetPoint,
            errorStandardPrice: errorStandardPrice,
            errorTypesMove: errorTypesMove,
            errorDescription: errorDescription,
          ));
          showTopSnackBar(
            context,
            CustomSnackBar.error(
              message: 'Ошибка валидации',
              textStyle: Montserrat(size: 15, color: White),
            ),
          );
        }
      }
    };
