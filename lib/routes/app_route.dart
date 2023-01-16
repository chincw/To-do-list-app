import 'package:get/get.dart';
import 'package:todo_list/controllers/todo_list_controller.dart';
import 'package:todo_list/controllers/todo_listform_controller.dart';
import 'package:todo_list/presentation/todo_listform.dart';
import 'package:todo_list/presentation/todo_listview.dart';

class AppRoutes {
  static String initialRoute = '/list';
  static final List<GetPage> routes = [
    GetPage(
        name: '/list',
        page: () => const ToDoListview(),
        binding: BindingsBuilder(
          () {
            Get.lazyPut<ToDoListController>(
              () => ToDoListController(),
            );
          },
        )),
    GetPage(
        name: '/list/form',
        page: () => const ToDoListform(),
        binding: BindingsBuilder(
          () {
            Get.lazyPut<ToDoListformController>(
              () => ToDoListformController(),
            );
          },
        )),
  ];
}
