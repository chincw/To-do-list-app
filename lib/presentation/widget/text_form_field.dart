import 'package:flutter/material.dart';
import 'package:todo_list/utils/color_utils.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.label,
    required this.hintText,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.maxLines = 1,
    this.onTap,
    this.validator,
  }) : super(key: key);

  final String label;
  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final int maxLines;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label,
            style: const TextStyle(color: ColorUtil.lightGray, fontSize: 18)),
        const SizedBox(height: 10),
        TextFormField(
          maxLines: maxLines,
          controller: controller,
          focusNode: focusNode,
          onTap: onTap,
          readOnly: onTap != null,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            fillColor: ColorUtil.theme,
            hintStyle: TextStyle(color: ColorUtil.lightGray.withOpacity(0.5)),
            suffixIcon: onTap != null
                ? const Icon(Icons.keyboard_arrow_down,
                    color: ColorUtil.lightGray)
                : null,
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: ColorUtil.theme, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(20))),
          ),
        ),
      ],
    );
  }
}
