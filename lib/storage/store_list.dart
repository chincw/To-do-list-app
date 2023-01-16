import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/storage/list_model.dart';

class StoreToDoList {
  static late SharedPreferences _preferences;

  static Future<SharedPreferences> init() async => _preferences = await SharedPreferences.getInstance();

  static Future<void> setToDoList(List<ListModel> todoList) async {
    final String todoJson = jsonEncode(todoList.map((ListModel e) => e.toJson()).toList());
    await _preferences.setString('todo_list', todoJson);
  }

  static List<ListModel> getToDoList() {
    final String? todoJson = _preferences.getString('todo_list');
    if (todoJson != null) {
      return (jsonDecode(todoJson) as List<dynamic>).map((dynamic e) => ListModel.fromJson(e)).toList();
    }
    return <ListModel>[];
  }

  static Future<void> clearSharedPreference() => _preferences.clear();
}
