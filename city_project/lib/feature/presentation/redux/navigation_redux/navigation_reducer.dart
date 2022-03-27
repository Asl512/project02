import 'package:flutter/cupertino.dart';
import 'package:redux/redux.dart';
import 'navigation_action.dart';
import 'navigation_state.dart';

NavigationState navigationReducer(NavigationState state, dynamic action){
  return NavigationState(
      navigation: _navigationReducer(state.navigation,action)
  );
}

Reducer<Widget> _navigationReducer = combineReducers([
  TypedReducer<Widget,NavigationWidgetAction>(_getNavigationReducer),
]);


Widget _getNavigationReducer(Widget widget, NavigationWidgetAction action) => action.widget;