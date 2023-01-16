import 'package:flutter/material.dart';
import 'package:todo_list/controllers/todo_listform_controller.dart';
import 'package:get/get.dart';
import 'package:todo_list/presentation/widget/common_button.dart';
import 'package:todo_list/presentation/widget/text_form_field.dart';

class ToDoListform extends GetView<ToDoListformController> {
  const ToDoListform({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return GestureDetector(
      onTap: () => controller.titleFocusNode.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          automaticallyImplyLeading: true,
          title: Text(controller.toDoEdit != null
              ? 'Edit To-Do List'
              : 'Add new To-Do List'),
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.keyboard_arrow_left_sharp, size: 30),
          ),
        ),
        body: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            children: <Widget>[
              CustomTextFormField(
                label: 'To-Do Title',
                hintText: 'Please key in your To-Do title here',
                maxLines: 6,
                controller: controller.titleController,
                focusNode: controller.titleFocusNode,
                validator: (String? value) => controller.validateTitle(value),
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                label: 'Start Date',
                hintText: 'Select a date',
                controller: controller.startDateController,
                validator: (String? value) =>
                    controller.validateStartDate(value),
                onTap: () async {
                  controller.pickStartDate(context);
                },
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                label: 'Estimate End Date',
                hintText: 'Select a date',
                controller: controller.endDateController,
                validator: (String? value) => controller.validateEndDate(value),
                onTap: () async {
                  controller.pickEndDate(context);
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: CommonButton(
            label: controller.toDoEdit != null ? 'Update Now' : 'Create Now',
            onPressed: () {
              if (formKey.currentState!.validate()) {
                if (controller.toDoEdit != null) {
                  controller.onEditToDo();
                } else {
                  controller.onCreateToDo();
                }
              }
            }),
      ),
    );
  }
}
