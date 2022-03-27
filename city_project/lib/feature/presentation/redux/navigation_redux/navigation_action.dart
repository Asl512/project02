import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:lan_code/core/failure.dart';
import 'package:lan_code/feature/data/repositories/city_data_repository.dart';
import 'package:lan_code/feature/data/repositories/user_data_repository.dart';
import 'package:lan_code/feature/domain/entities/city_entity.dart';
import 'package:lan_code/feature/domain/entities/user_entity.dart';
import 'package:lan_code/feature/presentation/navigation.dart';
import 'package:lan_code/feature/presentation/widgets/loading_widget.dart';
import 'package:lan_code/feature/presentation/widgets/page_reload_widget.dart';
import 'package:lan_code/service.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class NavigationWidgetAction{
  final Widget widget;
  NavigationWidgetAction({required this.widget});
}

ThunkAction NavigationThunkAction(UserMeth? user, int index) => (Store store)async{
  store.dispatch(NavigationWidgetAction(widget: _loadingWidget()));

  dynamic response = await CityDataRepository().getCityCash();
  dynamic responseUser;
  if(user?.id != null){
    responseUser = await UserDataRepository().getUser((user?.id)??"null");
  }
  if(response is Right){
    UserEntity? userEntity;
    if(responseUser != null && responseUser is Right){
      userEntity = responseUser.value;
    }
    store.dispatch(NavigationWidgetAction(widget: _getBodyNavigationWidgets((response.value as CityEntiti),index,userEntity)));
  }else{
    store.dispatch(NavigationWidgetAction(widget: _errorWidgets((response.value as ServerFailure).error)));
  }
};

Widget _loadingWidget(){
  return const LoadingWidget();
}

Widget _getBodyNavigationWidgets(CityEntiti city, int index, UserEntity? user){
  return BodyNavigation(cityEntiti: city,index: index,userEntity: user,);
}

Widget _errorWidgets(String error){
  return PageReloadWidget(error);
}