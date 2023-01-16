import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/storage/list_model.dart';
import 'package:todo_list/storage/store_list.dart';

class ToDoListController extends GetxController {
  List<ListModel> toDoList = <ListModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    toDoList = StoreToDoList.getToDoList();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
