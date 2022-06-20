import 'package:lan_code/back-end/redux/record/actions.dart';
import 'package:lan_code/back-end/redux/record/state.dart';
import 'package:redux/redux.dart';

Reducer<RecordListState> recordListReducer = combineReducers([
  TypedReducer<RecordListState, LoadRecordListAction>(_loadList),
  TypedReducer<RecordListState, ErrorRecordListAction>(_errorList),
  TypedReducer<RecordListState, ShowRecordListAction>(_showList),
]);

RecordListState _loadList(
  RecordListState state,
  LoadRecordListAction action,
) =>
    state.copyWith(
      isLoading: true,
      isError: false,
    );

RecordListState _errorList(
  RecordListState state,
  ErrorRecordListAction action,
) =>
    state.copyWith(
      isLoading: false,
      isError: true,
    );

RecordListState _showList(
  RecordListState state,
  ShowRecordListAction action,
) =>
    state.copyWith(
      isLoading: false,
      isError: false,
      records: action.records,
    );
