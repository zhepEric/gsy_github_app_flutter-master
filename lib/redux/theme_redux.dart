import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

/**
 * 事件Redux
 * Created by guoshuyu
 * Date: 2018-07-16
 */

/**
 * 通过 flutter_redux 的 combineReducers 与 TypedReducer，将 RefreshThemeDataAction 类  和  _refresh 方法绑定起来，
 * 最终会返回一个 ThemeData  实例。也就是说：用户每次发出一个 RefreshThemeDataAction ，最终都会触发 _refresh 方法，
 * 然后更新 GSYState 中的 themeData。

 */

///通过 flutter_redux 的 combineReducers，实现 Reducer 方法
final ThemeDataReducer = combineReducers<ThemeData>([
  ///将 Action 、处理 Action 的方法、State 绑定
  TypedReducer<ThemeData, RefreshThemeDataAction>(_refresh),
]);

///定义处理 Action 行为的方法，返回新的 State
ThemeData _refresh(ThemeData themeData, action) {
  themeData = action.themeData;
  return themeData;
}

///定义一个 Action 类
///将该 Action 在 Reducer 中与处理该Action的方法绑定
class RefreshThemeDataAction {

  final ThemeData themeData;

  RefreshThemeDataAction(this.themeData);
}
