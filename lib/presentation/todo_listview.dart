import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/controllers/todo_list_controller.dart';
import 'package:todo_list/presentation/widget/card.dart';
import 'package:todo_list/storage/store_list.dart';
import 'package:todo_list/utils/color_utils.dart';

class ToDoListview extends GetView<ToDoListview> {
  const ToDoListview({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtil.background,
      appBar: AppBar(
        title: const Text("To-do List"),
      ),
      body: GetBuilder<ToDoListController>(
        builder: (ToDoListController controller) {
          if (controller.toDoList.isEmpty) {
            return const Center(
                child: Text("No To-do item today, add one to start."));
          } else {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.separated(
                separatorBuilder: ((context, index) =>
                    const SizedBox(height: 10)),
                itemCount: controller.toDoList.length,
                itemBuilder: ((context, index) => CustomCard(
                    title: controller.toDoList[index].title ?? '',
                    startDate:
                        controller.toDoList[index].startDate ?? DateTime.now(),
                    endDate:
                        controller.toDoList[index].endDate ?? DateTime.now(),
                    onChanged: (value) {
                      controller.toDoList[index].isDone = value!;
                      controller.update();
                      StoreToDoList.setToDoList(controller.toDoList);
                    },
                    checkBoxValue: controller.toDoList[index].isDone,
                    onTap: () => Get.toNamed('/list/form',
                        arguments: controller.toDoList[index]))),
              ),
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: (() => Get.toNamed('/list/form', arguments: null)),
        child: const Icon(Icons.add),
      ),
    );
  }
}
