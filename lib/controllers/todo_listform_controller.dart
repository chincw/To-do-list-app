import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/controllers/todo_list_controller.dart';
import 'package:todo_list/storage/list_model.dart';
import 'package:todo_list/storage/store_list.dart';
import 'package:todo_list/utils/date_utils.dart';

class ToDoListformController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final ToDoListController toDoListController = Get.find<ToDoListController>();
  final FocusNode titleFocusNode = FocusNode();

  Rxn<DateTime> startDate = Rxn<DateTime>();
  Rxn<DateTime> endDate = Rxn<DateTime>();
  ListModel? toDoEdit;

  @override
  void onInit() {
    super.onInit();
    checkIfEdit();
  }

  @override
  void onClose() {
    titleController.dispose();
    titleFocusNode.dispose();
    super.onClose();
  }

  void onCreateToDo() {
    ListModel toDo = ListModel(
      id: UniqueKey().toString(),
      title: titleController.text,
      startDate: startDate.value,
      endDate: endDate.value,
      isDone: false,
      timeLeft: DateTime.now(),
    );
    toDoListController.toDoList = <ListModel>[
      toDo,
      ...toDoListController.toDoList
    ];
    toDoListController.update();
    StoreToDoList.setToDoList(toDoListController.toDoList);
    Get.back();
  }

  void checkIfEdit() {
    toDoEdit = Get.arguments;
    if (toDoEdit != null) {
      titleController.text = toDoEdit!.title!;
      startDate.value = toDoEdit!.startDate;
      endDate.value = toDoEdit!.endDate;
      startDateController.text =
          DateUtil.formatDefaultDate(toDoEdit!.startDate!);
      endDateController.text = DateUtil.formatDefaultDate(toDoEdit!.endDate!);
    }
  }

  void onEditToDo() {
    ListModel toDo = ListModel(
      id: toDoEdit!.id,
      title: titleController.text,
      startDate: startDate.value,
      endDate: endDate.value,
      isDone: toDoEdit!.isDone,
      timeLeft: DateTime.now(),
    );

    toDoListController.toDoList.asMap().forEach((int index, ListModel e) {
      if (e.id == toDoEdit!.id) {
        toDoListController.toDoList[index] = toDo;
      }
    });
    toDoListController.update();
    StoreToDoList.setToDoList(toDoListController.toDoList);
    Get.back();
  }

  Future<void> pickStartDate(BuildContext context) async {
    titleFocusNode.unfocus();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate.value ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      currentDate: startDate.value ?? DateTime.now(),
    );
    if (picked != null && picked != startDate.value) {
      startDate.value = picked;
      startDateController.text = DateUtil.formatDefaultDate(startDate.value!);
    }
  }

  Future<void> pickEndDate(BuildContext context) async {
    titleFocusNode.unfocus();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate.value ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      currentDate: endDate.value ?? DateTime.now(),
    );

    if (picked != null && picked != endDate.value) {
      endDate.value = picked;
      endDateController.text = DateUtil.formatDefaultDate(endDate.value!);
    }
  }

  String? validateStartDate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please select a start date';
    } else if (startDate.value != null &&
        endDate.value != null &&
        startDate.value!.isAfter(endDate.value!)) {
      return 'Start date must be before end date';
    }
    return null;
  }

  String? validateEndDate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please select a end date';
    } else if (startDate.value != null &&
        endDate.value != null &&
        startDate.value!.isAfter(endDate.value!)) {
      return 'End date must be after start date';
    }
    return null;
  }

  DateTime getEndDateFirstDate() {
    if (toDoEdit != null) {
      return toDoEdit!.startDate!;
    } else if (startDate.value != null) {
      return startDate.value!;
    } else {
      return DateTime.now();
    }
  }

  DateTime getStartDateLastDate() {
    if (toDoEdit != null) {
      return toDoEdit!.endDate!;
    } else if (endDate.value != null) {
      return endDate.value!;
    } else {
      return DateTime(2100);
    }
  }

  String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please key in your To-Do title here';
    }
    return null;
  }
}
