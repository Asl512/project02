import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:lan_code/core/failure.dart';
import 'package:lan_code/feature/data/repositories/excursion_data_repository.dart';
import 'package:lan_code/feature/data/repositories/type_data_repository.dart';
import 'package:lan_code/feature/data/repositories/user_data_repository.dart';
import 'package:lan_code/feature/domain/entities/excursion_entity.dart';
import 'package:lan_code/feature/domain/entities/type_entity.dart';
import 'package:lan_code/feature/domain/entities/user_entity.dart';
import 'package:lan_code/feature/presentation/pages/excursion_navigation/widgets/excursion_card_widget.dart';
import 'package:lan_code/feature/presentation/widgets/loading_widget.dart';
import 'package:lan_code/feature/presentation/widgets/page_reload_widget.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class GetExcursionsWidgetAction{
  final Widget widget;
  GetExcursionsWidgetAction({required this.widget});
}

ThunkAction GetExcursionsThunkAction() => (Store store)async{
  store.dispatch(GetExcursionsWidgetAction(widget: _loadingWidget()));

  dynamic responseExcursions = await ExcursionDataRepository().getAllExcursion();
  if(responseExcursions is Right){
    List<ExcursionEntiti> excursions = responseExcursions.value as List<ExcursionEntiti>;
    Map<String,dynamic> data = await getDataExcursion(excursions);

    store.dispatch(GetExcursionsWidgetAction(widget: _getExcursionsWidgets(
      excursions: excursions,
      data: data,
    )));
  }else{
    store.dispatch(GetExcursionsWidgetAction(widget: _errorWidgets((responseExcursions.value as ServerFailure).error)));
  }
};

ThunkAction GetExcursionsByTypeThunkAction(int type) => (Store store)async{
  store.dispatch(GetExcursionsWidgetAction(widget: _loadingWidget()));
  dynamic responseExcursions;
  if(type == 1){
    responseExcursions = await ExcursionDataRepository().getExcursionByType("12");
  }else{
    responseExcursions = await ExcursionDataRepository().getExcursionByType("3");
  }
  if(responseExcursions is Right){
    List<ExcursionEntiti> excursions = responseExcursions.value as List<ExcursionEntiti>;
    Map<String,dynamic> data = await getDataExcursion(excursions);

    store.dispatch(GetExcursionsWidgetAction(widget: _getExcursionsWidgets(
      excursions: excursions,
      data: data,
    )));
  }else{
    store.dispatch(GetExcursionsWidgetAction(widget: _errorWidgets((responseExcursions.value as ServerFailure).error)));
  }
};

Future<Map<String,dynamic>> getDataExcursion(List<ExcursionEntiti> excursions)async{
  List<UserEntity?> users = [];
  List<TypeEntity?> types = [];

  for(int i = 0; i<excursions.length;i++){
    dynamic responseUser = await UserDataRepository().getUser(excursions[i].guide);
    if(responseUser is Right){
      users.add(responseUser.value);
    }else{
      users.add(null);
    }

    dynamic responseType = await TypeDataRepository().getType(excursions[i].type);
    if(responseType is Right){
      types.add(responseType.value);
    }else{
      types.add(null);
    }
  }
  return {
    "users":users,
    "types":types
  };
}

Widget _loadingWidget(){
  return const LoadingWidget();
}

Widget _getExcursionsWidgets({
  required List<ExcursionEntiti> excursions,
  required Map<String,dynamic> data,
}){
  List<Widget> widgets = [];
  for(int i = 0; i < excursions.length; i++){
    widgets.add(ExcursionCardWidget(
      excursionEntiti: excursions[i],
      userEntity: data["users"][i],
      typeEntity: data["types"][i],
    ));
  }
  return ListView(children: widgets);
}

Widget _errorWidgets(String error){
  return PageReloadWidget(error);
}